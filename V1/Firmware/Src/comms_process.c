/*
 * comms_process.c
 *
 *  Created on: 3 ene. 2018
 */

#include "cmsis_os.h"
#include "usbd_cdc_if.h"
#include "pga.h"
#include "command_receive.h"

void comms_process(void) {

	input_data_t* input_data = create_input_data(MAX_CMD_INPUT_BUFFER);
	while (1) {

		get_new_data(input_data);
		check_newline(input_data);
		select_command(input_data->command);
		execute_command(input_data->command);

		osDelay(10);
	}
}
