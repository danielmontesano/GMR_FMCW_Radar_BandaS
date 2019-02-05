#include "protocol.h"

uint16_t calculate_crc16(const void *data, uint16_t length);

packet_t *packet_allocate(uint16_t length) {
	packet_t *packet = pvPortMalloc(sizeof(packet_t) + length * sizeof(uint8_t));
	if (packet != NULL) {
		packet->length = length;
	}
	return packet;
}

void packet_encode(packet_t *packet, const uint8_t *data, uint16_t sequence_num){
	uint16_t crc;
	packet->header[0] = 0xFF;
	packet->header[1] = 0xFA;
	packet->sequence_num = sequence_num;
	memcpy(&packet->header[2], &packet->sequence_num, sizeof(uint16_t));
	memcpy(&packet->header[4], &packet->length, sizeof(uint16_t));
	memcpy(&packet->data[0], data, packet->length * sizeof(uint8_t));
	crc = calculate_crc16(packet->data, packet->length);
	memcpy(&packet->header[6], &crc, sizeof(uint16_t));
}

/*
 * Function to calculate the CRC16 of data
 * CRC16-CCITT
 * Initial value = 0xFFFF
 * Polynomial = x^16 + x^12 + x^5 + x^0
 */
uint16_t calculate_crc16(const void *data, uint16_t length) {
	uint8_t *bytes = (uint8_t *) data;
	uint16_t crc = 0xFFFF, i;
	for (i = 0; i < length; i++)
	{
		crc = (uint16_t)((crc << 8) ^ crc16_table[(crc >> 8) ^ bytes[i]]);
	}
	return crc;
}

/*
 * Initialise the decoder
 */
void decoder_initialise(decoder_t *decoder) {
	decoder->buffer_length = 0;
	decoder->crc_errors = 0;
}

packet_t *packet_decode(decoder_t *decoder) {
	uint16_t decode_iterator = 0;
	packet_t *packet = NULL;
	uint16_t length, header, crc;

	while (decode_iterator + HEADER_SIZE <= decoder->buffer_length) {
		header = decoder->buffer[decode_iterator++] << 8;
		header |= decoder->buffer[decode_iterator++];
		if (header == 0xFFFA) {
			length = decoder->buffer[decode_iterator++];
			length |= decoder->buffer[decode_iterator++] << 8;
			crc = decoder->buffer[decode_iterator++];
			crc |= decoder->buffer[decode_iterator++] << 8;

			if (decode_iterator + length > decoder->buffer_length) {
				decode_iterator -= HEADER_SIZE;
				break;
			}

			if (crc == calculate_crc16(&decoder->buffer[decode_iterator], length)) {
				packet = packet_allocate(length);
				if (packet != NULL) {
					memcpy(packet->header, &decoder->buffer[decode_iterator - HEADER_SIZE], HEADER_SIZE * sizeof(uint8_t));
					memcpy(packet->data, &decoder->buffer[decode_iterator], length * sizeof(uint8_t));
				}
				decode_iterator += length;
				break;
			} else {
				decode_iterator -= (HEADER_SIZE - 1);
				decoder->crc_errors++;
			}
		} else {
			decode_iterator--;
		}

	}
	if (decode_iterator < decoder->buffer_length) {
		if (decode_iterator > 0) {
			memmove(&decoder->buffer[0], &decoder->buffer[decode_iterator], (decoder->buffer_length - decode_iterator) * sizeof(uint8_t));
			decoder->buffer_length -= decode_iterator;
		}
	}
	else decoder->buffer_length = 0;

	return packet;
}
