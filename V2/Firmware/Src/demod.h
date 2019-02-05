/*
 * demod.h
 *
 *  Created on: 22 oct. 2018
 */

#ifndef DEMOD_H_
#define DEMOD_H_

#include "types.h"
#include "cmsis_os.h"
#include "gpio.h"
#include "spi.h"
#include "math.h"

typedef union {
    struct {
        unsigned adrs : 3;
        unsigned SPIadrs : 2;
        unsigned ID : 2;
        unsigned NU : 9;
        unsigned DC_off_Q : 8;
        unsigned DC_off_I : 8;
    }bits;
    uint32_t reg;
}register0_t;

typedef union {
    struct {
        unsigned adrs : 3;
        unsigned SPIadrs : 2;
        unsigned PWD_RF : 1;
        unsigned NU1 : 1;
        unsigned PWD_buf : 1;
        unsigned P : 1;
        unsigned NU2 : 1;
        unsigned PWD_DC_OFF : 1;
        unsigned NU3 : 1;
        unsigned BB_gain : 5;
        unsigned LPF_ADJ : 8;
        unsigned DC_dect_BW : 2;
        unsigned fast_gain : 1;
        unsigned gain_sel : 1;
        unsigned osc_test : 1;
        unsigned NU4 : 1;
        unsigned att_3db : 1;
    }bits;
    uint32_t reg;
}register1_t;

typedef union {
    struct {
        unsigned adrs : 3;
        unsigned SPIadrs : 2;
        unsigned EN_autocal : 1;
        unsigned IDAC_dc_off : 8;
        unsigned QDAC_dc_off : 8;
        unsigned IDet : 2;
        unsigned Cal_sel : 1;
        unsigned CLK_div : 3;
        unsigned Cal_clk_sel : 1;
        unsigned Osc_trim : 3;
    }bits;
    uint32_t reg;
}register2_t;

typedef union {
    struct {
        unsigned adrs : 3;
        unsigned SPIadrs : 2;
        unsigned ILoadA : 6;
        unsigned ILoadB : 6;
        unsigned QLoadA : 6;
        unsigned QLoadB : 6;
        unsigned Bypass : 1;
        unsigned Fltr_ctrl : 2;
    }bits;
    uint32_t reg;
}register3_t;

typedef union {
    struct {
        unsigned adrs : 3;
        unsigned SPIadrs : 2;
        unsigned Mix_GM_trim : 2;
        unsigned Mix_LO_trim : 2;
        unsigned Mix_buf_trim : 2;
        unsigned Fltr_trim : 2;
        unsigned Out_buf_trim : 2;
        unsigned NU : 17;
    }bits;
    uint32_t reg;
}register5_t;

typedef struct {
	register0_t reg0;
	register1_t reg1;
	register2_t reg2;
	register3_t reg3;
	register5_t reg5;
}demod_t;

void init_demod(demod_t* demod);
void demod_set_gain(demod_t* demod, uint8_t gain_dB);
void demod_set_filter(demod_t* demod, uint8_t freq);
void demod_enable_fast_gain(demod_t* demod, uint8_t bool, uint8_t multiplier);
void demod_enable_att(demod_t* demod, uint8_t bool) ;

#endif /* DEMOD_H_ */
