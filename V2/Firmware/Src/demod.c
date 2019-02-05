/*
 * pga.c
 *
 *  Created on: 2 nov. 2017
 */

#include "demod.h"

void init_demod(demod_t* demod) {
	demod->reg1.bits.adrs = 0b001;
	demod->reg1.bits.SPIadrs = 0b01;
	demod->reg1.bits.PWD_buf = 1;
	demod->reg1.bits.PWD_DC_OFF = 1;
	demod->reg1.bits.BB_gain = 15;
//	demod->reg1.bits.LPF_ADJ = 0b1000000;
}

void demod_set_gain(demod_t* demod, uint8_t gain_dB) {
	if (gain_dB < 18) {
		gain_dB = 18;
	}
	if (gain_dB > 41) {
		gain_dB = 41;
	}
	//(fig 34) se ha estimado la funcion de la potencia como una recta
	int x = (int)round((gain_dB-17.6818)/0.9636);
	demod->reg1.bits.BB_gain = x;
	uint8_t* tr = (uint8_t*)&demod->reg1;
	HAL_SPI_Transmit(&hspi3, tr, 4, 50);
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_SET); //latch enable
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_RESET);
}

void demod_set_filter(demod_t* demod, uint8_t freq) {
	//(fig 39) 150 son 2MHz y 255 debe andar por los 700kHz de corte, que es el minimo del componente
	demod->reg1.bits.LPF_ADJ = freq;
	uint8_t* tr = (uint8_t*)&demod->reg1;
	HAL_SPI_Transmit(&hspi3, tr, 4, 50);
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_SET); //latch enable
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_RESET);
}

void demod_enable_fast_gain(demod_t* demod, uint8_t bool, uint8_t multiplier) {
	// multiplier [1-2] dB
	demod->reg1.bits.fast_gain = bool;
	demod->reg1.bits.gain_sel = multiplier-1;
	uint8_t* tr = (uint8_t*)&demod->reg1;
	HAL_SPI_Transmit(&hspi3, tr, 4, 50);
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_SET); //latch enable
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_RESET);
}

void demod_enable_att(demod_t* demod, uint8_t bool) {
	demod->reg1.bits.att_3db = bool;
	uint8_t* tr = (uint8_t*)&demod->reg1;
	HAL_SPI_Transmit(&hspi3, tr, 4, 50);
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_SET); //latch enable
	HAL_GPIO_WritePin(GPIOA, GPIO_PIN_15, GPIO_PIN_RESET);
}
