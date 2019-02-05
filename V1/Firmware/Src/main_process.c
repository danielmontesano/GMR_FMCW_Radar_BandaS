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
#include "pga.h"
#include "config_ramp.h"
#include "protocol.h"
#include "types.h"

#define default_length 1000

volatile uint8_t flag = 0;
volatile uint8_t buffer_half = 0; //select which half of the buffer to transmit
uint8_t init = 0;

osMutexDef(data_mutex);// Declare mutex
osMutexId data_mutex_id;	// Mutex ID

adc_data_t adc_data;
dac_data_t dac_data;
packet_t *packet;

void main_process(void) {
	uint16_t num = 0;
	init_ramp(&adc_data, &dac_data, default_length, 150, 4000);
	packet = packet_allocate(default_length*4);
	data_mutex_id = osMutexCreate(osMutex(data_mutex));
	set_gain(4);
	osDelay(1000);
//	HAL_GPIO_WritePin(VCO_SHDN_GPIO_Port, VCO_SHDN_Pin, GPIO_PIN_SET); //enable VCO
//	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_SET);
//	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_SET);
//	HAL_TIM_PWM_Start(&htim4, TIM_CHANNEL_4);
	__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 10);

	memset(adc_data.data, 0, adc_data.size * sizeof(uint16_t));

	HAL_ADC_Start(&hadc2);
	HAL_TIM_Base_Start(&htim6);		//START DAC TIMER6
	__HAL_TIM_SetCounter(&htim6,0);
	HAL_ADC_Start_DMA(&hadc1, (uint32_t*) adc_data.data, adc_data.size);
	HAL_DAC_Start_DMA(&hdac, DAC_CHANNEL_1, (uint32_t*) dac_data.ramp, dac_data.length, DAC_ALIGN_12B_R);
	while (1) {
		if (flag) {
			HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_15);

			osMutexWait(data_mutex_id, osWaitForever);
//			HAL_GPIO_WritePin(GPIOB, GPIO_PIN_14, GPIO_PIN_SET);
			packet_encode(packet, (uint8_t*) (adc_data.data + adc_data.size/2 * buffer_half), num);
			CDC_Transmit_HS(packet->header, packet_size(packet));
			num++;
//			if (CDC_Transmit_HS((uint8_t*) (adc_data.data + adc_data.size/2 * buffer_half) , adc_data.size) != USBD_BUSY) {
//				HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_14);
//			}
//			if(((USBD_CDC_HandleTypeDef*)(hUsbDeviceFS.pClassData))->TxState==0){
//				CDC_Transmit_FS(buffer,length);
//			}
			flag = 0;
			osMutexRelease(data_mutex_id);
		}
	}
}

void Toggle_Led(void) {
	static uint32_t ticks;

	if (ticks % 50 == 0) {
		if (dac_data.blink) {
			__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 0);
			dac_data.blink = 0;
		} else
			__HAL_TIM_SET_COMPARE(&htim4, TIM_CHANNEL_4, 10);
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
	HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_14);
	if (flag) {
//		while (1) {
//			HAL_GPIO_WritePin(GPIOC, GPIO_PIN_8, GPIO_PIN_RESET);
//		}
	}
	buffer_half = 0;
	flag = 1;
}

//void HAL_DAC_ConvCpltCallbackCh1(DAC_HandleTypeDef* hdc) {
////	HAL_DAC_Stop_DMA(&hdac, DAC_CHANNEL_1);
//}

void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc) {
	HAL_GPIO_TogglePin(GPIOB, GPIO_PIN_14);
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

void HAL_DAC_ErrorCallbackCh1(DAC_HandleTypeDef *hdac) {
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_RESET);
	while (1)
		;
}

void vApplicationMallocFailedHook(void){
	while(1); //nos quedamos sin memoria
}
