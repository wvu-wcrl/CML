/* file: ConvEncode.c

   Description: Convolutionally encode with either NSC or RSC code.

   The calling syntax is:

      [output] = ConvEncode(input, g_encoder, [code_type] )

      output = code word

      Required inputs:
	  input  = data word
	  g_encoder = generator matrix for convolutional code
	              (If RSC, then feedback polynomial is first)
	  Optional inputs:
	  code_type = 0 for recursive systematic convolutional (RSC) code (default)
	            = 1 for non-systematic convolutional (NSC) code
				= 2 for tail-biting NSC code               

   Copyright (C) 2005-2008, Matthew C. Valenti

   Last updated on May 21, 2008

   Function ConvEncode is part of the Iterative Solutions 
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

/* library of functions */
#include "./include/convolutional.h"

/* Input Arguments */
#define INPUT       prhs[0]
#define GENENCODER  prhs[1]
#define CODETYPE    prhs[2]

/* Output Arguments */
#define OUTPUT      plhs[0]

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double	*input, *g_array;
	double	*output_p;
	int      DataLength, CodeLength, i, j, index;
	int      subs[] = {1,1};
	int     *g_encoder;
	int		 nn, KK, mm, code_type, max_states;
	double   elm;
	int		*input_int, *output_int;
	int     *out0, *out1, *state0, *state1, *tail;

	code_type = 0; /* Default:Code is RSC with terminated trellis */

	/* Check for proper number of arguments */
	if ((nrhs < 2 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: [output] = ConvEncode(input, g_encoder, code_type )");
	} else {
		/* first input is the data word */
		input = mxGetPr(INPUT);	
		DataLength = mxGetN(INPUT); /* number of data bits */

		/* cast the input into a vector of integers */
		input_int = calloc( DataLength, sizeof(int) );
		for (i=0;i<DataLength;i++)
			input_int[i] = (int) input[i];

		/* second input specifies the code polynomial */
	    g_array = mxGetPr(GENENCODER);	
		nn = mxGetM(GENENCODER);
		KK = mxGetN(GENENCODER);
		mm = KK - 1;
		max_states = 1 << mm;

		if ( nrhs == 3 ) {		
			/* optional third input indicates if outer is RSC, NSC or tail-biting NSC */
			code_type   = (int) *mxGetPr(CODETYPE);
		}

		/* Determine the length of the output */
		if (code_type < 2)
			CodeLength = nn*(DataLength+mm);
		else
			CodeLength = nn*DataLength;
			
		/* Convert code polynomial to binary */
		g_encoder = calloc(nn, sizeof(int) );

		for (i = 0;i<nn;i++) {
			subs[0] = i;
			for (j=0;j<KK;j++) {
				subs[1] = j;
				index = mxCalcSingleSubscript(GENENCODER, 2, subs);
				elm = g_array[index];
				if (elm != 0) {
					g_encoder[i] = g_encoder[i] + (int) pow(2,(KK-j-1)); 
				}
			}
			/* mexPrintf("   g_encoder[%d] = %o\n", i, g_encoder[i] ); */
		}

	} 

	/* create the output vector */		
	OUTPUT = mxCreateDoubleMatrix(1, CodeLength, mxREAL );
	output_p = mxGetPr(OUTPUT);	
	output_int = calloc( CodeLength, sizeof( int ) );

	/* create appropriate transition matrices */
	out0 = calloc( max_states, sizeof(int) );
	out1 = calloc( max_states, sizeof(int) );
	state0 = calloc( max_states, sizeof(int) );
	state1 = calloc( max_states, sizeof(int) );
	tail = calloc( max_states, sizeof(int) );

	if ( code_type ) {
		nsc_transit( out0, state0, 0, g_encoder, KK, nn );
		nsc_transit( out1, state1, 1, g_encoder, KK, nn );
		if (code_type == 2)
			tail[0] = -1;
	} else {
		rsc_transit( out0, state0, 0, g_encoder, KK, nn );
		rsc_transit( out1, state1, 1, g_encoder, KK, nn );
		rsc_tail( tail, g_encoder, max_states, mm );
	}

	/* Encode */
	conv_encode( output_int, input_int, out0, state0, out1, state1, tail, KK, DataLength, nn );	

	/* cast to output */
    for (i=0;i<CodeLength;i++) 			
		output_p[i] = output_int[i];
		
	/* Clean up memory */
	free( output_int );
	free( input_int );
	free( g_encoder );
	free( out0 );
	free( out1 );
	free( state0 );
	free( state1 );
	free( tail );

	return;
}
