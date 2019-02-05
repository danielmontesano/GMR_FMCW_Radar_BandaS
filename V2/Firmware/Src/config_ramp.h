/*
 * config_ramp.h
 *
 *  Created on: 26 ene. 2018
 *      Author: LuisAlberto
 */

#ifndef CONFIG_RAMP_H_
#define CONFIG_RAMP_H_

#include "types.h"
#include "cmsis_os.h"
#include "tim.h"
#include "adc.h"
#include "dac.h"

typedef struct {
	uint16_t size;
	uint16_t* data;
} adc_data_t;

typedef struct {
	uint16_t* ramp;
	uint16_t length;
	uint16_t voltage1;
	uint16_t voltage2;
	uint16_t fall_percent;
	uint8_t mode;
	uint8_t blink;
} dac_data_t;

//new ramp struct
typedef struct {
	uint16_t* ramp;
	uint16_t length;
	uint16_t points_count;
} inc_ramp_t;


retval_t init_ramp(adc_data_t* adc_data, dac_data_t* dac_data, uint16_t length, uint16_t v1, uint16_t v2);
retval_t set_ramp_voltages(dac_data_t* dac_data, uint16_t v1, uint16_t v2);
retval_t set_ramp_bw(dac_data_t* dac_data, uint16_t bw);
retval_t set_ramp_length(adc_data_t* adc_data, dac_data_t* dac_data, uint16_t length, uint16_t fall_percent);

retval_t new_ramp(uint16_t length);
retval_t add_points_ramp(uint16_t* points, uint16_t num_points);
retval_t add_modulation(adc_data_t* adc_data, dac_data_t* dac_data);
retval_t check_modulation_ok();
retval_t set_modulation(adc_data_t* adc_data, dac_data_t* dac_data);

retval_t start_acquisition(adc_data_t* adc_data, dac_data_t* dac_data);

#endif /* CONFIG_RAMP_H_ */
