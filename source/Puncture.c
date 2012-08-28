/* file: Puncture.c

   Description: Puncture bits at output of encoder

   The calling syntax is:

      [output] = Puncture(input, pun_pattern, tail_pattern )

      output       = Punctured sequence

      input        = Code bits to be punctured
	  pun_pattern  = Puncturing pattern for encoded data bits
	  tail_pattern = Puncturing pattern for encoded tail bits

   Copyright (C) 2005-2008, Matthew C. Valenti

   Last updated on May 22, 2008

   Function Puncture is part of the Iterative Solutions 
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
	int length; /* number of data+tail bits */
	int tail_period; /*  period of the tail pattern */
	int number_data_bits; /* number of data bits */
	int pun_period;  /* period of puncturing pattern */
	int number_pun_bits; /* length after puncturing */
	int number_pun_periods; /* number of puncture periods */
	int partial_period; /* length of last period (if partial) */
	int bits_per_period; /* number punctured bits per period */
	int temp_count;
	int i, j, count_total, count_period; /* counting variables */

	/* Check for proper number of arguments */
	if ((nrhs < 3 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: [output] = Puncture(input, pun_pattern, tail_pattern )");
	} else {
		/* first input is the data word */
		input = mxGetPr(prhs[0]);
		length = mxGetN(prhs[0]);
		height = mxGetM(prhs[0]);

		/* second input is the punctuing pattern for coded data bits */
		pun_pattern = mxGetPr(prhs[1]);
		pun_period = mxGetN(prhs[1]);
		if ( mxGetM(prhs[1])!=height )
			mexErrMsgTxt("Number rows in pun_pattern must match the number in input");

		/* third input is the puncturing pattern for coded tail bits */
		tail_pattern = mxGetPr(prhs[2]);
		tail_period = mxGetN(prhs[2]);
		if ( ( mxGetM(prhs[2])!=height )&&( tail_period > 0 ) )
			mexErrMsgTxt("Number rows in tail_pattern must match the number in input");

		number_data_bits = length - tail_period;

		/* determine length of punctured output */
		bits_per_period = 0;
		for (i=0;i<pun_period*height;i++)
			bits_per_period += (int) pun_pattern[i];

		number_pun_periods = floor(number_data_bits/pun_period);
		number_pun_bits = number_pun_periods*bits_per_period;

		/* printf( "Calculated punctured DATA bits = %d\n", number_pun_bits ); */

		/* in case there is a fraction of a period at the end */
		partial_period = number_data_bits%pun_period;
		for (i=0;i<partial_period*height;i++)
			number_pun_bits += (int) pun_pattern[i];

		/* tail bits */
		for (i=0;i<tail_period*height;i++) {
			number_pun_bits += (int) tail_pattern[i];
		}

		/* set up output */
		plhs[0] = mxCreateDoubleMatrix(1, number_pun_bits, mxREAL );
		output_p = mxGetPr(plhs[0]);	

		/* printf( "Length = %d\n", length );
		printf( "Height = %d\n", height );
		printf( "Puncture Period = %d\n", pun_period );
		printf( "Tail Period = %d\n", tail_period);
		printf( "Number Puncture Periods = %d\n", number_pun_periods );
		printf( "Length of Partial Period = %d\n", partial_period );
	    printf( "Calculated punctured bits = %d\n", number_pun_bits ); */

		/* puncture the coded data bits  */
		count_total = 0;
		count_period = 0;
		for (i=0;i<number_data_bits*height;i++) {
			temp_count = pun_pattern[count_period];
			while( temp_count > 0 ) {
				output_p[count_total] = input[i];
				temp_count--;
				count_total++;
			}
			count_period++;
			if (count_period == pun_period*height)
				count_period = 0;
		} 

		/* puncture the coded tail bits
		   New 11/21/05: if height = 4, then 
		   the tail bits are rearranged to conform to UMTS convention */
		if ( height == 4 ) {
			
			/* upper RSC's tail bits */
			for (i=0;i<tail_period;i++) {
				for (j=0;j<2;j++) {
					temp_count = tail_pattern[i*4+j];
					while( temp_count > 0 ) {
						output_p[count_total] = input[number_data_bits*height+i*4+j];
						temp_count--;
						count_total++;
					}
				} 
			}

			/* lower RSC's tail bits */
			for (i=0;i<tail_period;i++) {
				for (j=0;j<2;j++) {
					temp_count = tail_pattern[i*4+j+2];
					while( temp_count > 0 ) {
						output_p[count_total] = input[number_data_bits*height+i*4+j+2];
						temp_count--;
						count_total++;
					}
				} 
			}

		} else {
			for (i=0;i<tail_period*height;i++) {
				temp_count = tail_pattern[i];
				while( temp_count > 0 ) {
					output_p[count_total] = input[number_data_bits*height+i];
					temp_count--;
					count_total++;
				}
			} 
		}

		if (count_total != number_pun_bits ) {
			printf( "Calculated punctured bits = %d but actual = %d", number_pun_bits, count_total );
			mexErrMsgTxt( "Error!" );
		}
	}

	return;
}
