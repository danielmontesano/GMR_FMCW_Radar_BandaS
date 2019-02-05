/*
 * command_receive.h
 *
 *  Created on: 4 ene. 2018
 */

#ifndef COMMAND_RECEIVE_H_
#define COMMAND_RECEIVE_H_

#include "strfunc.h"
#include "config_commands.h"

#define MAX_CMD_INPUT_BUFFER	256

#define	CIRCULAR_BUFFER_SIZE	256

#define NO_NEWLINE	0
#define NEWLINE		1

typedef struct input_data{
	uint8_t* circular_buffer;
	uint8_t* input_commands_str;
	volatile uint8_t* head;
	volatile uint8_t* tail;
	uint16_t input_command_str_count;
	uint16_t input_command_str_current_count;
	uint16_t max_cmd_buffer_size;
	command_data_t* command;
	uint8_t newline_flag;
}input_data_t;

input_data_t* new_input_data;

input_data_t* create_input_data(uint16_t buffer_size);
retval_t remove_input_data(input_data_t* input_data);

retval_t start_listening(input_data_t* input_data);
retval_t stop_listening(input_data_t* input_data);
retval_t pause_listening(input_data_t* input_data);
retval_t resume_listening(input_data_t* input_data);

retval_t get_new_data(input_data_t* input_data);
retval_t check_newline(input_data_t* input_data);
retval_t buffer_put(uint8_t data);


#endif /* COMMAND_RECEIVE_H_ */
