/*
 * main_process.c
 *
 *  Created on: 24 oct. 2017
 */

#include "spi.h"
#include "tim.h"
#include "gpio.h"
#include "dac.h"
#include "adc.h"
#include "cmsis_os.h"
#include "usbd_cdc_if.h"
#include "main_process.h"
#include "config_ramp.h"
#include "demod.h"
#include "protocol.h"
#include "types.h"

#define default_length 500 // 1 ms
#define default_packet_size default_length * 16 //4000(samples) * 2(bytes/sample) * 2(channels)

volatile uint8_t flag = 0;
volatile uint8_t buffer_half = 0; //select which half of the buffer to transmit
uint8_t init = 0;

osMutexDef(data_mutex);		// Declare mutex
osMutexId data_mutex_id;	// Mutex ID

adc_data_t adc_data;
dac_data_t dac_data;
packet_t *packet;
demod_t demod;

void main_process(void) {
	uint16_t num = 0;
	init_ramp(&adc_data, &dac_data, default_length, 150, 4000);
	packet = packet_allocate(default_packet_size);
	data_mutex_id = osMutexCreate(osMutex(data_mutex));
	init_demod(&demod);
	demod_set_filter(&demod, 220);
	demod_set_gain(&demod, 18);
	demod_enable_att(&demod, 1);
	HAL_GPIO_WritePin(GPIOD, GPIO_PIN_0, GPIO_PIN_RESET); // disable demodulator
	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_11, GPIO_PIN_RESET); //disable the rest of the modules
	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_9, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_10, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOE, GPIO_PIN_12, GPIO_PIN_RESET);
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_SET); // led
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_SET); // led
	HAL_GPIO_WritePin(GPIOD, GPIO_PIN_15, GPIO_PIN_SET); // led
//	HAL_TIM_PWM_Start(&htim4, TIM_CHANNEL_4);
//	__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 200);
	osDelay(1000);

	//start acquiring two channels (ADC1, ADC2), we need twice the size to store the data
	start_acquisition(&adc_data, &dac_data);
	while (1) {
		if (flag) {
			HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_15);

			osMutexWait(data_mutex_id, osWaitForever);
//			HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
			packet_encode(packet, (uint8_t*) (adc_data.data + adc_data.size*4 * buffer_half), num);
			CDC_Transmit_HS(packet->header, packet_size(packet));
			num++;
			flag = 0;
			osMutexRelease(data_mutex_id);
		}
	}
}

void Toggle_Led(void) {
	static uint32_t ticks;

	if (ticks % 50 == 0) {
		if (dac_data.blink) {
//			__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 0);
			dac_data.blink = 0;
		} else {
//			__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 10);
		}
	}

	if (ticks++ == 100) {
		if (dac_data.mode)
			HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_8);
		else
			HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_SET);
		ticks = 0;
	}
}

void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef* hadc) {

	if (flag) {
//		while (1) {
//			HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_RESET);
//		}
	}
	buffer_half = 0;
	flag = 1;
}

void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc) {
//	HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_14);
	if (flag) {
//		while (1) {
//			HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_RESET);
//		}
	}
	buffer_half = 1;
	flag = 1;
}

void HAL_ADC_ErrorCallback(ADC_HandleTypeDef *hadc) {
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_RESET);
	while (1)
		;
}

void HAL_DAC_DMAUnderrunCallbackCh1(DAC_HandleTypeDef *hdac){
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_RESET);
	while (1);
}

void HAL_DAC_ConvCpltCallbackCh1(DAC_HandleTypeDef* hdac){

}

void HAL_DAC_ErrorCallbackCh1(DAC_HandleTypeDef *hdac) {
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_RESET);
	while (1)
		;
}

void vApplicationMallocFailedHook(void){
	while(1); //out of memory
}
