/* file: Deinterleave.c

   Description: Deinterleave one block of data according to interleaving pattern alpha_code

   The calling syntax is:

      [output] = Deinterleave(input, alpha_code )

      output = deinterleaved data 

      input  = interleaved data (float or int)
	  alpha_code = interleaver pattern

   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on Jan. 11, 2006

   Function Deinterleave is part of the Iterative Solutions 
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

/* Input Arguments */
#define INPUT       prhs[0]
#define ALPHA       prhs[1]

/* Output Arguments */
#define OUTPUT      plhs[0]

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double	*input, *alpha;
	double	*output_p;
	int      InterleaverLength, i, index;

	/* Check for proper number of arguments */
	if ((nrhs < 2 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: [output] = Deinterleave(input, alpha_code )");
	} else {
		/* first input is the data word */
		input = mxGetPr(INPUT);	
		InterleaverLength = mxGetN(INPUT); /* number of data bits */

		/* second input is the interleaver */
		if ( mxGetN(ALPHA) != InterleaverLength )
			mexErrMsgTxt("Deinterleave: Error input and alpha_code must be same length");
		alpha = mxGetPr(ALPHA);

		OUTPUT = mxCreateDoubleMatrix(1, InterleaverLength, mxREAL );
		output_p = mxGetPr(OUTPUT);	

		/* Interleave */
		for(i=0;i<InterleaverLength;i++) { 
			index = (int) alpha[i];
			output_p[index] = input[i];
		}
	}

	return;
}
