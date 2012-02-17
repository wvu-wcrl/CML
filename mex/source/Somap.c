/* File: Somap.c

   Description: Soft demapper (M-ary to binary LLR conversion)

   The calling syntax is:
      [output] = Somap( input, [demod_type], [extrinsic_info] )

   Where:
      output     = Length N*log2(M) stream of LLR values

      input      = M by N matrix of symbol likelihoods
	  demod_type = The type of max_star algorithm that is used 
	             = 0 For linear approximation to log-MAP (DEFAULT)
                 = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) )
                 = 2 For Constant-log-MAP algorithm
	             = 3 For log-MAP, correction factor from small nonuniform table and interpolation
                 = 4 For log-MAP, correction factor uses C function calls

	  extrinsic_info = 1 by N*log2(M) vector of extrinsic info (defaults to all-zero)

   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on Jan. 11, 2006

   Function Somap is part of the Iterative Solutions 
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
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

*/
#include <math.h>
#include <mex.h>
#include <matrix.h>
#include <stdlib.h>
#include "./include/maxstar.h"

/* Input Arguments
prhs[0] is input
prhs[1] is demod_type
prhs[2] is ex_info

/* Output Arguments
plhs[0] is output

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double  *input;
	double  *llr_in;	
	double  *output_p;
	
	int demod_type = 0;
	int M, m, DataLength; 
	int i, j, k, n, mask;
	int NumberSymbols;
	float metric;
	float *den, *num;
	int temp_int;
	float *llr;
	int Number_LLR_bits;

	/* put the different max_star functions into array so easy to call */
	float (*max_star[])(float, float) =
	{ 
		max_star0, max_star1, max_star2, max_star3, max_star4
	};

	/* Check for proper number of arguments */
	if (nrhs ==  0) {
		mexErrMsgTxt("Usage: [output] = Somap( input, [demod_type], [extrinsic_info] )");
	} 
	if (nrhs > 0 ) {
		/* first (and only required) input is M-ary symbols for conversion */
		input = mxGetPr(prhs[0]);	
	} 	
	if (nrhs > 1) {
		/* second (optional) input is the demodulator type */
		demod_type = (int) *mxGetPr(prhs[1]);
		if ( (demod_type < 0)||(demod_type > 4) )
			mexErrMsgTxt("demod_type must be be 0 through 4");
	}
	
	/* initialize the input data */
	NumberSymbols = mxGetN(prhs[0]);
	M = mxGetM(prhs[0]);

	/* determine number of bits per symbol */
	m = 0;
	temp_int = M;
	while (temp_int>1) {
		temp_int = temp_int/2;
		m++;
	}
	/* printf( "%d bits per symbol\n", m ); */
	if (temp_int < 1)
		mexErrMsgTxt("Number of symbols M must be a power of 2");

	DataLength = m*NumberSymbols; /* total number of bits */

	/* allocate memory */
	den = calloc( m, sizeof(float) );
	num = calloc( m, sizeof(float) );
	llr = calloc( DataLength, sizeof(float) );  /* llr input defaults to all-zeros */

	if (nrhs > 2) {
		/* third (optional) input is the llr
		   if not long enough, assume that end is all-zeros */
		Number_LLR_bits = mxGetN(prhs[2]);
		if ( Number_LLR_bits > DataLength )
			mexErrMsgTxt("Too many a prior LLR inputs");

		llr_in = mxGetPr(prhs[2]);
		for (k=0;k<Number_LLR_bits;k++) {
			llr[k] = (float) llr_in[k];
		}
	}

	/* the bit-wise LLRs */		
	plhs[0] = mxCreateDoubleMatrix(1, DataLength, mxREAL );
	output_p = mxGetPr(plhs[0]);	
	
	for (n=0;n<NumberSymbols;n++) { /* loop over symbols */
	
		for (k=0;k<m;k++) {		
			/* initialize */
			num[k] = -1000000;			
			den[k] = -1000000;			
		}
			
		for (i=0;i<M;i++) {
			metric = input[n*M+i]; /* channel metric for this symbol */

			mask = 1 << m - 1;					
			for (j=0;j<m;j++) {		/* incorporate extrinsic info */
				if (mask&i) {
					metric += llr[n*m+j];
				}
				mask = mask >> 1;
			}

			mask = 1 << m - 1;
			for (k=0;k<m;k++) {	/* loop over bits */
				if (mask&i) {
					/* this bit is a one */
					num[k] = ( *max_star[demod_type] )( num[k], metric - llr[n*m+k] );
				} else {
					/* this bit is a zero */
					den[k] = ( *max_star[demod_type] )( den[k], metric );
				}
				mask = mask >> 1;
			}
		}	
			
		for (k=0;k<m;k++) {
			output_p[m*n+k] = num[k] - den[k];
		}
	}

	/* free memory */
	free( den );
	free( num );
	free( llr );

	return;
}

