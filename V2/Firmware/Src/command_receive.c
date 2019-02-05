/*
 * command_receive.c
 *
 *  Created on: 4 ene. 2018
 */
#include "command_receive.h"


input_data_t* create_input_data(uint16_t buffer_size) {

	new_input_data = (input_data_t*) pvPortMalloc(sizeof(input_data_t));
	new_input_data->input_commands_str = (uint8_t*) pvPortMalloc(buffer_size * sizeof(uint8_t) + 1); //Reserves an extra space for managing the '\0' character in the worst case
	new_input_data->circular_buffer = (uint8_t*) pvPortMalloc(CIRCULAR_BUFFER_SIZE * sizeof(uint8_t));
	new_input_data->head = new_input_data->circular_buffer;
	new_input_data->tail = new_input_data->circular_buffer;
	new_input_data->input_command_str_count = 0;
	new_input_data->input_command_str_current_count = 0;
	new_input_data->max_cmd_buffer_size = buffer_size;
	new_input_data->newline_flag = NO_NEWLINE;
	new_input_data->command = new_command_data();

//	new_input_data->command = new_command_data();

	return new_input_data;
}
retval_t remove_input_data(input_data_t* input_data) {

	if (input_data != NULL) {
		vPortFree(input_data->input_commands_str);
		vPortFree(input_data->circular_buffer);
		remove_command_data(input_data->command);
		vPortFree(input_data);
		return RET_OK;
	} else {
		return RET_ERROR;
	}
}

retval_t get_new_data(input_data_t* input_data) {

	if (input_data != NULL) {

//		input_data->head = input_data->circular_buffer + CIRCULAR_BUFFER_SIZE - __HAL_DMA_GET_COUNTER(huart2.hdmarx);
		volatile uint8_t* head = input_data->head;
		if (head > input_data->tail) {
			uint32_t new_chars_number = head - input_data->tail;
			uint16_t i;

			if ((input_data->input_command_str_count + new_chars_number) > input_data->max_cmd_buffer_size) {
				input_data->input_command_str_count = 0;
				input_data->input_command_str_current_count = 0;
				return RET_ERROR;	//COMMAND BUFFER OVERFLOW
			}

			for (i = 0; i < new_chars_number; i++) {
				input_data->input_commands_str[i + input_data->input_command_str_count] = input_data->tail[i];
			}

			input_data->input_command_str_count = input_data->input_command_str_count + new_chars_number;
			input_data->tail = head;
		}

		else if (head < input_data->tail) {

			uint16_t i;
			uint32_t diff_end = input_data->circular_buffer + CIRCULAR_BUFFER_SIZE - input_data->tail;
			uint32_t diff_start = head - input_data->circular_buffer;
			uint32_t new_chars_number = diff_end + diff_start;

			if ((input_data->input_command_str_count + new_chars_number) > input_data->max_cmd_buffer_size) {
				input_data->input_command_str_count = 0;
				input_data->input_command_str_current_count = 0;
				return RET_ERROR;	//COMMAND BUFFER OVERFLOW
			}

			for (i = 0; i < new_chars_number; i++) {
				if (i < diff_end) {
					input_data->input_commands_str[i + input_data->input_command_str_count] = input_data->tail[i];
				} else {
					input_data->input_commands_str[i + input_data->input_command_str_count] = input_data->circular_buffer[i - diff_end];
				}

			}

			input_data->input_command_str_count = input_data->input_command_str_count + new_chars_number;
			input_data->tail = head;

		}

		return RET_OK;
	} else {
		return RET_ERROR;
	}
}

retval_t check_newline(input_data_t* input_data) {

	if (input_data != NULL) {

		uint16_t i;
		uint16_t j;

		for (i = input_data->input_command_str_current_count; i < input_data->input_command_str_count; i++) {//First check if there exists a backspace

			if (input_data->input_commands_str[i] == '\b') {
				for (j = i; j < input_data->input_command_str_count - 1; j++) {
					input_data->input_commands_str[j] = input_data->input_commands_str[j + 1];
					input_data->input_command_str_count--;
				}
				i--;

			}
		}

		for (i = input_data->input_command_str_current_count; i < input_data->input_command_str_count; i++) {//Now check for a newline. The new line could be '\r' '\n' or '\r\n'

			if ((input_data->input_commands_str[i] == '\r') || (input_data->input_commands_str[i] == '\n')) {

				input_data->input_commands_str[i] = '\0';

				input_data->command->argv = str_split((char*) input_data->input_commands_str, ' ', (int*) &input_data->command->argc);//Memory for argv is reserved inside str_split function. It is necessary to free it later

				uint16_t extra_bytes = input_data->input_command_str_count - i - 1;		//Number of existing bytes after '\r' or '\n'

				for (j = 0; j < extra_bytes; j++) {				//Moves everything (if exists) after '\r' or '\n' to the start of the buffer

					input_data->input_commands_str[j] = input_data->input_commands_str[i + j + 1];

				}

				input_data->input_command_str_current_count = 0;
				input_data->input_command_str_count = extra_bytes;

				return RET_OK;

			}
		}

		input_data->input_command_str_current_count = input_data->input_command_str_count;

		return RET_OK;
	} else {
		return RET_ERROR;
	}
}

retval_t buffer_put(uint8_t data) {
	if (new_input_data != NULL) {
		if (!((new_input_data->head - new_input_data->tail) == CIRCULAR_BUFFER_SIZE)) { // buffer not full
			*(new_input_data->head) = data;
			volatile uint8_t* tmp = new_input_data->head;
			if(tmp++ >= new_input_data->circular_buffer + CIRCULAR_BUFFER_SIZE-1){
				new_input_data->head = new_input_data->circular_buffer;
			}
			else{
				new_input_data->head++;
			}
			return RET_OK;
		}
	}
	return RET_ERROR;
}
