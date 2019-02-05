/**
 * @file strfunc.c
 */


#include "strfunc.h"


char** str_split( char* str, char delim, int* numSplits )
{
	char** ret;
	int retLen;
	char* c = str;
	int prevDelim = 0;
	int i = 0;
	char *strStart = c;
	int strlen = 0;
	int j = 0;

	retLen = 0;

	/* Pre-calculate number of elements */
	do
	{
		if ( (*c == delim)  && (prevDelim == 0))
		{
			prevDelim = 1;
		}
		if ( (*c != delim)  && (prevDelim == 1)){
			prevDelim = 0;
			retLen++;
		}

		c++;
	} while ( *c != '\0' );

	ret = pvPortMalloc( ( retLen + 1 ) * sizeof( *ret ) );

	c = str;

	retLen++;

	for (i=0; i<retLen;i++){

LOOP:
		while(*c != delim){
			c++;
			strlen ++;
		}

		if(strlen != 0){
			ret[i] = pvPortMalloc( ( strlen+1) * sizeof(char) );
			for(j=0; j<strlen;j++){
				ret[i][j] = strStart[j];
			}
			ret[i][j] = '\0';
		}
		else{
			c++;
			strlen = 0;
			strStart = c;
			goto LOOP;
		}

		c++;
		strlen = 0;
		strStart = c;
	}

	*numSplits = retLen;
	return ret;

}
