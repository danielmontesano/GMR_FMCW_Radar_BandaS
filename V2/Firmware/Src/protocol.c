#include "protocol.h"
#include "gpio.h"
#include "dma.h"

packet_t *packet_allocate(uint16_t length) {
	packet_t *packet = pvPortMalloc(sizeof(packet_t) + length * sizeof(uint8_t));
	if (packet != NULL) {
		packet->length = length;
	}
	return packet;
}

void packet_encode(packet_t *packet, const uint8_t *data, uint16_t sequence_num){
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
	uint32_t crc;
	hcrc.Instance->CR |= CRC_CR_RESET; // reset CRC calculation
	HAL_DMA_Start(&hdma_memtomem_dma2_stream0, (uint32_t) data, (uint32_t) &(hcrc.Instance->DR), packet->length/4);
	packet->header[0] = 0xFF;
	packet->header[1] = 0xFA;
	packet->sequence_num = sequence_num;
	memcpy(&packet->header[2], &packet->sequence_num, sizeof(uint16_t));
	memcpy(&packet->header[4], &packet->length, sizeof(uint16_t));
	memcpy(&packet->data[0], data, packet->length * sizeof(uint8_t));
	HAL_DMA_PollForTransfer(&hdma_memtomem_dma2_stream0, HAL_DMA_FULL_TRANSFER, 5000); // wait for the CRC to complete
	crc = hcrc.Instance->DR;
	memcpy(&packet->header[6], &crc, sizeof(uint32_t));
	HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_RESET);
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

			if (crc == HAL_CRC_Calculate(&hcrc, (uint32_t*) &decoder->buffer[decode_iterator], length/2)) {
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
