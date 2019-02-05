/*
 * types.h
 *
 *  Created on: 4 ene. 2018
 *      Author: LuisAlberto
 */

#ifndef TYPES_H_
#define TYPES_H_

#include "stdlib.h"
#include "stdio.h"

/**
 * @brief Return values available
 */
typedef enum {
	RET_OK,   //!< Return success
	RET_ERROR,   //!< Return error
} retval_t;

#define DEFAULT_FALL	10

#endif /* TYPES_H_ */
