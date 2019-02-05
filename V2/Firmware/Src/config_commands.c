/*
 * config_commands.c
 *
 *  Created on: 15 oct. 2017
 */

#include "config_commands.h"

retval_t null_func(uint16_t argc, char** argv);
retval_t cmd_init(uint16_t argc, char** argv);
retval_t cmd_set_ramp_length(uint16_t argc, char** argv);
retval_t cmd_set_ramp_bw(uint16_t argc, char** argv);
retval_t cmd_set_ramp_voltages(uint16_t argc, char** argv);

retval_t cmd_new_ramp(uint16_t argc, char** argv);
retval_t cmd_add_points_ramp(uint16_t argc, char** argv);
retval_t cmd_set_ramp(uint16_t argc, char** argv);
retval_t cmd_dac_set_voltage(uint16_t argc, char** argv);
retval_t cmd_get_power(uint16_t argc, char** argv);
retval_t cmd_enable_device(uint16_t argc, char** argv);

retval_t cmd_demod_set_gain(uint16_t argc, char** argv);
retval_t cmd_demod_set_filter(uint16_t argc, char** argv);

extern uint8_t init;
extern osMutexId data_mutex_id;	// Mutex ID
extern adc_data_t adc_data;
extern dac_data_t dac_data;
extern packet_t *packet;
extern demod_t demod;


command_data_t* new_command_data() {

	command_data_t* new_command_data = (command_data_t*) pvPortMalloc(
			sizeof(command_data_t));
	new_command_data->argc = 0;
	new_command_data->command_func = null_func;

	return new_command_data;
}
retval_t remove_command_data(command_data_t* command_data) {

	if (command_data != NULL) {
		vPortFree(command_data);
		return RET_OK;
	} else {
		return RET_ERROR;
	}

}

retval_t select_command(command_data_t* command_data) {
	if (command_data != NULL) {
		if (command_data->argc != 0) {
			dac_data.blink = 1;
			if (strcmp(command_data->argv[0], " ") == 0) {
				command_data->command_func = null_func;
			} else if (strcmp(command_data->argv[0], INIT) == 0) {
				command_data->command_func = cmd_init;
			} else if (strcmp(command_data->argv[0], SETRAMPLENGTH) == 0) {
				command_data->command_func = cmd_set_ramp_length;
			} else if (strcmp(command_data->argv[0], SETRAMPVOLTAGE) == 0) {
				command_data->command_func = cmd_set_ramp_voltages;
			} else if (strcmp(command_data->argv[0], SETRAMPBW) == 0) {
				command_data->command_func = cmd_set_ramp_bw;
			} else if (strcmp(command_data->argv[0], NEWRAMP) == 0) {
				command_data->command_func = cmd_new_ramp;
			} else if (strcmp(command_data->argv[0], ADDPOINTS) == 0) {
				command_data->command_func = cmd_add_points_ramp;
			} else if (strcmp(command_data->argv[0], SETRAMP) == 0) {
				command_data->command_func = cmd_set_ramp;
			} else if (strcmp(command_data->argv[0], SETVOLTAGE) == 0) {
				command_data->command_func = cmd_dac_set_voltage;
			} else if (strcmp(command_data->argv[0], SETGAIN) == 0) {
				command_data->command_func = cmd_demod_set_gain;
			} else if (strcmp(command_data->argv[0], SETFILTER) == 0) {
				command_data->command_func = cmd_demod_set_filter;
			} else if (strcmp(command_data->argv[0], ENABLEDEVICE) == 0) {
				command_data->command_func = cmd_enable_device;
			} else if (strcmp(command_data->argv[0], GETPOWER) == 0) {
				command_data->command_func = cmd_get_power;
			} else {
				command_data->command_func = null_func;
				return RET_ERROR;
			}
			return RET_OK;
		} else {
			return RET_OK;
		}
	} else {
		return RET_ERROR;
	}
}

retval_t execute_command(command_data_t* command_data) {
	if (command_data != NULL) {
		uint16_t i = 0;

		command_data->command_func(command_data->argc, command_data->argv);
		command_data->command_func = null_func;

		for (i = 0; i < command_data->argc; i++) {//When a command is executed, the memory occupied by the args must be freed
			if (command_data->argv[i] != NULL) {
				vPortFree(command_data->argv[i]);
				command_data->argv[i] = NULL;
			}
		}
		if (command_data->argv != NULL) {
			vPortFree(command_data->argv);
			command_data->argv = NULL;
		}

		command_data->argc = 0;

		return RET_OK;

	} else {
		return RET_ERROR;
	}
}

retval_t null_func(uint16_t argc, char** argv) {
	return RET_OK;
}

retval_t cmd_init(uint16_t argc, char** argv) {
	if (argc == 2) {
		init = 1;
	}
	return RET_OK;
}

retval_t cmd_set_ramp_length(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint16_t length = atoi(argv[1]);
		osMutexWait(data_mutex_id, osWaitForever);
		HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
		//both ADCs must be stop, or overrun will happen
		HAL_ADCEx_MultiModeStop_DMA(&hadc1);
		HAL_ADC_Stop(&hadc2);

		set_ramp_length(&adc_data, &dac_data, length, DEFAULT_FALL);
		vPortFree(packet);
		packet = packet_allocate(length * 16);
		dac_data.mode = 1;
		osDelay(1);
		start_acquisition(&adc_data, &dac_data);
		osMutexRelease(data_mutex_id);
	}
	return RET_OK;
}

retval_t cmd_set_ramp_bw(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint16_t bw = atoi(argv[1]);
		osMutexWait(data_mutex_id, osWaitForever);
		HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
		//both ADCs must be stop, or overrun will happen
		HAL_ADCEx_MultiModeStop_DMA(&hadc1);
		HAL_ADC_Stop(&hadc2);

		set_ramp_bw(&dac_data, bw);
		dac_data.mode = 1;
		osDelay(1);
		start_acquisition(&adc_data, &dac_data);
		osMutexRelease(data_mutex_id);
	}
	return RET_OK;
}

retval_t cmd_set_ramp_voltages(uint16_t argc, char** argv) {
	if (argc == 3) {
		uint16_t v1 = atoi(argv[1]);
		uint16_t v2 = atoi(argv[2]);
		osMutexWait(data_mutex_id, osWaitForever);
		HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
		//both ADCs must be stop, or overrun will happen
		HAL_ADCEx_MultiModeStop_DMA(&hadc1);
		HAL_ADC_Stop(&hadc2);

		set_ramp_voltages(&dac_data, v1, v2);
		dac_data.mode = 1;
		osDelay(2);
		start_acquisition(&adc_data, &dac_data);
		osMutexRelease(data_mutex_id);
	}
	return RET_OK;
}

retval_t cmd_dac_set_voltage(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint16_t voltage = atoi(argv[1]);
		osMutexWait(data_mutex_id, osWaitForever);
		HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
		//both ADCs must be stop, or overrun will happen
		HAL_ADCEx_MultiModeStop_DMA(&hadc1);
		HAL_ADC_Stop(&hadc2);

		if (dac_data.ramp != NULL) {
			vPortFree(dac_data.ramp);
		}
		uint16_t* ramp = pvPortMalloc(dac_data.length * sizeof(uint16_t));
		for (int i = 0; i < dac_data.length; ++i) {
			ramp[i] = voltage;
		}
		dac_data.ramp = ramp;
		dac_data.mode = 0;

		start_acquisition(&adc_data, &dac_data);
		osMutexRelease(data_mutex_id);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_new_ramp(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint16_t length = atoi(argv[1]);
		new_ramp(length);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_add_points_ramp(uint16_t argc, char** argv) {
	if (argc >= 2) {
		uint16_t num_points = atoi(argv[1]);
		uint16_t points[num_points];
		for (int i = 0; i < num_points; ++i) {
			points[i] = atoi(argv[i + 2]);
		}
		add_points_ramp(points, num_points);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_set_ramp(uint16_t argc, char** argv) {
	if (argc == 2) {
		osMutexWait(data_mutex_id, osWaitForever);
		HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
		//both ADCs must be stop, or overrun will happen
		HAL_ADCEx_MultiModeStop_DMA(&hadc1);
		HAL_ADC_Stop(&hadc2);

		set_modulation(&adc_data, &dac_data);
		dac_data.mode = 1;
		//double the size of DAC data, 2 bytes per point measured.
		vPortFree(packet);
		packet = packet_allocate(dac_data.length * 16);
		osDelay(1);
		start_acquisition(&adc_data, &dac_data);
		osMutexRelease(data_mutex_id);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_enable_device(uint16_t argc, char** argv) {
	if (argc == 3) {
		uint8_t device = (uint8_t) atoi(argv[1]);
		uint8_t enable = (uint8_t) atoi(argv[2]);
		if (device == VCO) {
			HAL_GPIO_WritePin(GPIOE, GPIO_PIN_11, enable);
			return RET_OK;
		} else if (device == LNA1) {
			HAL_GPIO_WritePin(GPIOE, GPIO_PIN_9, enable);
			return RET_OK;
		} else if (device == LNA2) {
			HAL_GPIO_WritePin(GPIOE, GPIO_PIN_10, enable);
			return RET_OK;
		} else if (device == PA) {
			HAL_GPIO_WritePin(GPIOE, GPIO_PIN_12, enable);
			return RET_OK;
		} else if (device == DEMOD) {
			HAL_GPIO_WritePin(GPIOD, GPIO_PIN_0, enable);
			return RET_OK;
		}
		return RET_ERROR;
	}
	return RET_ERROR;
}

retval_t cmd_demod_set_gain(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint8_t gain = (uint8_t) atoi(argv[1]);
		demod_set_gain(&demod, gain);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_demod_set_filter(uint16_t argc, char** argv) {
	if (argc == 2) {
		uint8_t freq = (uint8_t) atoi(argv[1]);
		demod_set_filter(&demod, freq);
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t cmd_get_power(uint16_t argc, char** argv) {
	if (argc == 2) {
		osMutexWait(data_mutex_id, osWaitForever);
		uint32_t pot = HAL_ADC_GetValue(&hadc2);
		char send[32];
//		int len = sprintf(send,"X%lu\n", pot);
//		while( CDC_Transmit_HS((uint8_t*) send, len) == USBD_BUSY);
		osMutexRelease(data_mutex_id);
		return RET_OK;
	}
	return RET_ERROR;
}
