/*
 * config_commands.h
 *
 *  Created on: 15 oct. 2017
 */

#ifndef CONFIG_COMMANDS_H_
#define CONFIG_COMMANDS_H_

#include "types.h"
#include "cmsis_os.h"
#include "string.h"
#include "gpio.h"
#include "dac.h"
#include "adc.h"
#include "tim.h"
#include "config_ramp.h"
#include "usbd_cdc_if.h"

#include "demod.h"
#include "protocol.h"

#define INIT					"init"
#define SETRAMPLENGTH			"setramplength"
#define SETRAMPBW				"setrampbw"
#define SETRAMPVOLTAGE			"setrampvoltages"
#define NEWRAMP					"newramp"
#define ADDPOINTS				"addpoints"
#define SETRAMP					"setramp"
#define SETVOLTAGE				"setvoltage"
#define SETGAIN					"setgain"
#define SETFILTER				"setfilter"
#define GETPOWER				"getpower"
#define ENABLEDEVICE			"enabledevice"

enum devices {
	VCO = 0,
	LNA1 = 1,
	LNA2 = 2,
	PA = 3,
	DEMOD = 4,
};

typedef struct {
	uint16_t argc;
	char** argv;
	retval_t (*command_func)(uint16_t argc, char** argv);
} command_data_t;

command_data_t* new_command_data();
retval_t remove_command_data(command_data_t* command_data);

retval_t select_command(command_data_t* command_data);
retval_t execute_command(command_data_t* command_data);

#endif /* CONFIG_COMMANDS_H_ */
