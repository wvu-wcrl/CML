/* file: Depuncture.c

   Description: Depuncture bits by zero-padding deleted bits.

   The calling syntax is:

      [output] = Depuncture(input, pun_pattern, tail_pattern )

      output       = Unpunctured codeword

      input        = Punctured codeword
	  pun_pattern  = Puncturing pattern for encoded data bits
	  tail_pattern = Puncturing pattern for encoded tail bits

   Copyright (C) 2005-2008, Matthew C. Valenti

   Last updated on May 22, 2008

   Function Depuncture is part of the Iterative Solutions 
   Coded Modulation Library. The Iterative Solutions Coded Modulation 
   Library is free software; you can redistribute it and/or modify it 
   under the terms of the GNU Lesser General Public License as published 
   by the Free Software Foundation; either version 2.1 of the License, 
   or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.
  
   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*/
#include <math.h>
#include <mex.h>
#include <matrix.h>
#include <stdlib.h>

/* Input Arguments 
prhs[0] is input
prhs[1] is pun_pattern
prhs[2] is tail_pattern

/* Output Arguments
plhs[0] is output */

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double	*input, *pun_pattern, *tail_pattern; /* inputs */
	double	*output_p; /* output */
	int height; /* height of input matrices */
	int pun_period;  /* period of puncturing pattern */
	int tail_period; /* period of tail */
	int pun_bits_per_frame; 
	int unpun_bits_per_frame;
	int pun_bits_in_tail;
	int unpun_bits_in_tail;
	int pun_bits_in_payload;
	int unpun_bits_in_payload;
	int pun_bits_per_period;
	int unpun_bits_per_period;
	int number_pun_periods; /* number of puncture periods */
	int partial_period = 0; /* length of last period (if partial) */
	int number_fractional_bits;
	int temp_count;
	int i, j, count_punctured; /* counting variables */

	/* Check for proper number of arguments */
	if ((nrhs < 3 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: [output] = Puncture(input, pun_pattern, tail_pattern )");
	} else {
		/* first input is the punctured word */
		input = mxGetPr(prhs[0]);
		pun_bits_per_frame = mxGetN(prhs[0]);
		if ( mxGetM(prhs[0]) != 1 )
			mexErrMsgTxt("Input must be a row vector");

		/* second input is the puncturing pattern for coded data bits */
		pun_pattern = mxGetPr(prhs[1]);
		pun_period = mxGetN(prhs[1]);
		height = mxGetM(prhs[1]);
		unpun_bits_per_period = height*pun_period; /* number of unpunctured bits per payload period */

		/* third input is the puncturing pattern for coded tail bits */
		tail_pattern = mxGetPr(prhs[2]); 
		tail_period = mxGetN(prhs[2]);
		if ( ( mxGetM(prhs[2])!=height )&&( tail_period > 0 ) )
			mexErrMsgTxt("Number rows in tail_pattern must match the number in pun_pattern");
		unpun_bits_in_tail = height*tail_period; /* number of unpunctured bits in the tail */

		/* printf( "Height = %d\n", height );
		printf( "Puncture Period = %d\n", pun_period );
		printf( "Tail Period = %d\n", tail_period );  */

		/* determine number of punctured bits per payload period (non-tail) */
		pun_bits_per_period = 0;
		for (i=0;i<pun_period*height;i++)
			pun_bits_per_period += (int) pun_pattern[i];
		/* printf( "Punctured bits per payload period = %d\n", pun_bits_per_period );  */

		/* determine number of punctured bits in the tail */
		pun_bits_in_tail = 0;
		for (i=0;i<tail_period*height;i++)
			pun_bits_in_tail += (int) tail_pattern[i];
		/* printf( "Punctured bits in the tail = %d\n", pun_bits_in_tail ); */

		/* determine how many periods in payload */
		pun_bits_in_payload = pun_bits_per_frame - pun_bits_in_tail;
		number_pun_periods = floor( pun_bits_in_payload/pun_bits_per_period );
		/* printf( "Number Puncture Periods = %d\n", number_pun_periods ); */

		/* determine if there is a fractional period in payload */
		number_fractional_bits = pun_bits_in_payload - number_pun_periods*pun_bits_per_period;
		/* printf( "Number of punctured fractional bits = %d\n", number_fractional_bits ); */
		if (number_fractional_bits > 0 ) {
			temp_count = 0;
			i = 0;		 /* column */
			while (temp_count < number_fractional_bits ) {
				for (j = 0; j<height; j++ ) { /* row */
					temp_count += pun_pattern[i*height+j];
				}
				if ( temp_count > number_fractional_bits )
					mexErrMsgTxt( "Incomplete column of puncturing pattern" );
				i++;
				partial_period = i;
			}
		}
				
		/* printf( "Length of Partial Period = %d\n", partial_period ); */

		unpun_bits_in_payload = unpun_bits_per_period*number_pun_periods + height*partial_period;
		unpun_bits_per_frame = unpun_bits_in_payload + unpun_bits_in_tail;

		/* printf( "Number of Unpunctured Bits = %d\n", unpun_bits_per_frame ); */
	
		/* set up output */
		plhs[0] = mxCreateDoubleMatrix(height, unpun_bits_per_frame/height, mxREAL );
		output_p = mxGetPr(plhs[0]);

		/* unpuncture the coded data bits  */
		count_punctured = 0;
		for (j=0;j<number_pun_periods;j++) { /* go through each period */
			for (i=0;i<height*pun_period;i++) {
				temp_count = pun_pattern[i];
				while (temp_count > 0) {
					output_p[j*pun_period*height+i]+=input[count_punctured];
					count_punctured++;
					temp_count--;
				}
			}
		}

		if (partial_period > 0) { /* go through last (partial) period */
			for (i=0;i<height*partial_period;i++) {
				temp_count = pun_pattern[i];
				while (temp_count > 0) {
					output_p[number_pun_periods*pun_period*height+i]+=input[count_punctured];
					count_punctured++;
					temp_count--;
				}
			}
		}


		/* depuncture the coded tail bits 
		New 11/21/05: if height = 4, then 
		the tail bits are rearranged to conform to UMTS convention */
		if ( height == 4 ) {
			
			/* upper RSC's tail bits */
			for (i=0;i<tail_period;i++) {
				for (j=0;j<2;j++) {
					temp_count = tail_pattern[i*4+j];
					while( temp_count > 0 ) {
						output_p[unpun_bits_in_payload + i*4+j] += input[count_punctured];
						count_punctured++;
						temp_count--;
					}
				} 
			}
			
			/* lower RSC's tail bits */
			for (i=0;i<tail_period;i++) {
				for (j=0;j<2;j++) {
					temp_count = tail_pattern[i*4+j+2];
					while( temp_count > 0 ) {
						output_p[unpun_bits_in_payload + i*4+j+2] += input[count_punctured];
						count_punctured++;
						temp_count--;
						
					}
				} 
			}
			
		} else {
			for (i=0;i<unpun_bits_in_tail;i++) {
				temp_count = tail_pattern[i];
				while( temp_count > 0 ) {
					output_p[unpun_bits_in_payload + i] += input[count_punctured];
					count_punctured++;
					temp_count--;
				}
			} 
			
		}

	}

	return;
}
