/*
 * pga.c
 *
 *  Created on: 2 nov. 2017
 */

#include "cmsis_os.h"
#include "pga.h"
#include "gpio.h"
#include "spi.h"

void set_gain(uint8_t gain) {
//	if(gain < 4){
//		gain = 4;
//	}
	uint8_t wiperB = WIPERB;
	uint8_t value = 255-(22000.0f*0.0255f/(gain-1));
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_RESET); //enable potentiometer
	HAL_SPI_Transmit(&hspi3, &wiperB, 1, 50);
	HAL_SPI_Transmit(&hspi3, &value, 1, 50);
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_SET);

}
