/*
 * config_ramp.c
 *
 *  Created on: 26 ene. 2018
 */
#include "config_ramp.h"

inc_ramp_t temp_ramp;

retval_t init_ramp(adc_data_t* adc_data, dac_data_t* dac_data, uint16_t length, uint16_t v1, uint16_t v2) {
	dac_data->mode = 1;
	dac_data->length = length;
	dac_data->fall_percent = DEFAULT_FALL;
	set_ramp_voltages(dac_data, v1, v2);
	set_ramp_length(adc_data, dac_data, length, DEFAULT_FALL);
	return RET_OK;
}


retval_t set_ramp_voltages(dac_data_t* dac_data, uint16_t v1, uint16_t v2) {
	uint16_t ramp_amplitude = v2 - v1;
	if (ramp_amplitude > 4095 || v1 > v2) {
		return RET_ERROR;
	}
	if (dac_data->ramp != NULL) {
		vPortFree(dac_data->ramp);
		dac_data->ramp = NULL;
	}
	uint16_t fall_m = dac_data->length * dac_data->fall_percent / 100; //muestras correspondientes a la caida
	float step = (float) ramp_amplitude/(dac_data->length - fall_m); //offset para un BW dado
	uint16_t* ramp = pvPortMalloc(dac_data->length * sizeof(uint16_t));
	//rising edge
	int i;
	for (i = 0; i < dac_data->length - fall_m; ++i) {
		ramp[i] = i * step + v1;
	}
	//falling edge
	uint16_t diff = ramp[dac_data->length - fall_m - 1] - ramp[0];
	step = (float) diff / (fall_m - 1);
	for (int j = 0; j < fall_m; ++j) {
		ramp[i + j] = ramp[dac_data->length - fall_m - 1] - j * step;
	}

	dac_data->ramp = ramp;
	dac_data->voltage1 = v1;
	dac_data->voltage2 = v2;
	return RET_OK;
}

retval_t set_ramp_bw(dac_data_t* dac_data, uint16_t bw) {
	uint16_t ramp_amplitude = (4096 - 2 * 100) * bw / 363; //amplitud en valores discretos de la rampa
	if (ramp_amplitude > 4095) {
		return RET_ERROR;
	}
	if (dac_data->ramp != NULL) {
		vPortFree(dac_data->ramp);
		dac_data->ramp = NULL;
	}

	uint16_t offset = (4096 - ramp_amplitude) / 2; //offset para un BW dado
	uint16_t* ramp = pvPortMalloc(dac_data->length * sizeof(uint16_t));
	//rising edge
	uint16_t fall_m = dac_data->length * dac_data->fall_percent / 100; //muestras correspondientes a la caida
	float index;
	int i;
	for (i = 0; i < dac_data->length - fall_m; ++i) {
		index = (float) i / (dac_data->length - fall_m);
		ramp[i] = index * (4096 - 2 * offset) + offset;
	}
	//falling edge
	uint16_t diff = ramp[dac_data->length - fall_m - 1] - ramp[0];
	float step = (float) diff / (fall_m - 1);
	for (int j = 0; j < fall_m; ++j) {
		ramp[i + j] = ramp[dac_data->length - fall_m - 1] - j * step;
	}

	dac_data->ramp = ramp;
//	dac_data->offset = offset;
	return RET_OK;
}

retval_t set_ramp_length(adc_data_t* adc_data, dac_data_t* dac_data, uint16_t length, uint16_t fall_percent) {
	if (length < 100 || length > 5000) {
		return RET_ERROR;
	}
	if (dac_data->ramp != NULL) {
		vPortFree(dac_data->ramp);
		dac_data->ramp = NULL;
	}
	if (adc_data->data != NULL) {
		vPortFree(adc_data->data);
		adc_data->data = NULL;
	}

	dac_data->length = length;
	dac_data->fall_percent = fall_percent;
	uint16_t ramp_amplitude = dac_data->voltage2 - dac_data->voltage1;
	uint16_t fall_m = length * fall_percent / 100; //muestras correspondientes a la caida
	float step = (float) ramp_amplitude / (length - fall_m); //offset para un BW dado
	uint16_t* ramp = pvPortMalloc(dac_data->length * sizeof(uint16_t));
	//rising edge
	int i;
	for (i = 0; i < dac_data->length - fall_m; ++i) {
		ramp[i] = i * step + dac_data->voltage1;
	}
	//falling edge
	uint16_t diff = ramp[dac_data->length - fall_m - 1] - ramp[0];
	step = (float) diff / (fall_m - 1);
	for (int j = 0; j < fall_m; ++j) {
		ramp[i + j] = ramp[dac_data->length - fall_m - 1] - j * step;
	}

	dac_data->ramp = ramp;
	adc_data->size = length * 4;
	adc_data->data = pvPortMalloc(adc_data->size  * sizeof(uint16_t));
	return RET_OK;
}


retval_t new_ramp(uint16_t length) {
	temp_ramp.length = length;
	temp_ramp.points_count = 0;
	if(temp_ramp.ramp != NULL){
		vPortFree(temp_ramp.ramp);
		temp_ramp.ramp = NULL;
	}
	temp_ramp.ramp = pvPortMalloc(length * sizeof(uint16_t));
	return RET_OK;
}

retval_t add_points_ramp(uint16_t* points, uint16_t num_points) {

	if ((temp_ramp.points_count + num_points) > temp_ramp.length) { // trying to put more points than the maxium
		return RET_ERROR;
	}

	for (int i = 0; i < num_points; ++i) {
		temp_ramp.ramp[temp_ramp.points_count + i] = points[i];
	}
	temp_ramp.points_count += num_points;
	return RET_OK;
}

retval_t check_modulation_ok() {

	// if number of points added are equals to the maximum the ramp it's ok
	if (temp_ramp.points_count == temp_ramp.length) {
		return RET_OK;
	}
	return RET_ERROR;
}

retval_t set_modulation(adc_data_t* adc_data, dac_data_t* dac_data) {
	if (check_modulation_ok() == RET_OK) {
		if (adc_data->data != NULL) {
			vPortFree(adc_data->data);
			adc_data->data = NULL;
		}
		if (dac_data->ramp != NULL) {
			vPortFree(dac_data->ramp);
			dac_data->ramp = NULL;
		}
		dac_data->ramp = temp_ramp.ramp;
		temp_ramp.ramp = NULL;
		dac_data->length = temp_ramp.length;
		adc_data->size = temp_ramp.length * 4;
		adc_data->data = pvPortMalloc(adc_data->size * sizeof(uint16_t));
		return RET_OK;
	}
	return RET_ERROR;
}

