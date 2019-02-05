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

void main_process() {
//	HAL_GPIO_WritePin(VCO_SHDN_GPIO_Port, VCO_SHDN_Pin, GPIO_PIN_SET); //enable VCO
	HAL_GPIO_WritePin(GPIOC, GPIO_PIN_6, GPIO_PIN_SET);
	while(1){

	}
}
