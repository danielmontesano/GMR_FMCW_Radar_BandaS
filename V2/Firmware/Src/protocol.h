#ifndef protocol_h
#define protocol_h

#include "cmsis_os.h"
#include "crc.h"
#include <string.h>

#define HEADER_SIZE 10
#define DECODE_BUFFER_SIZE 10*(8000+HEADER_SIZE)

#define packet_size(packet) (packet->length + HEADER_SIZE)*sizeof(uint8_t)
#define decoder_increment(decoder, bytes_received) (decoder)->buffer_length += bytes_received

typedef struct {
	uint16_t length;
	uint16_t sequence_num;
	uint8_t header[HEADER_SIZE];
	uint8_t data[1];
} packet_t;

typedef struct {
	uint8_t buffer[DECODE_BUFFER_SIZE];
	uint16_t buffer_length;
	uint32_t crc_errors;
} decoder_t;

void print_packet(const packet_t *packet);
packet_t *packet_allocate(uint16_t length);
void packet_encode(packet_t *packet, const uint8_t *data, uint16_t sequence_num);

void decoder_initialise(decoder_t *decoder);
packet_t *packet_decode(decoder_t *decoder);

#endif
