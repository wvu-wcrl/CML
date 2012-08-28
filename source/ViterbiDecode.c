/* file: ViterbiDecode.c

   Description: Soft-in/hard-out decoding for a convolutional code using the Viterbi algorithm

   The calling syntax is:

      [output_u] = ViterbiDecode( input_c, g_encoder, [code_type], [depth] )

      output_u = hard decisions on the data bits (0 or 1)

      Required inputs:
	  input_c = LLR of the code bits (based on channel observations)
	  g_encoder = generator matrix for convolutional code
	              (If RSC, then feedback polynomial is first)
	  
	  Optional inputs:
	  code_type = 0 for recursive systematic convolutional (RSC) code (default)
	            = 1 for non-systematic convolutional (NSC) code
				= 2 for tail-biting NSC code               
      depth = wrap depth used for tail-biting decoding
	          default is 6 times the constraint length

   Copyright (C) 2005-2008, Matthew C. Valenti

   Last updated on May 21, 2008

   Function ViterbiDecode is part of the Iterative Solutions 
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
#define INPUT_C     prhs[0]
#define GENENCODER  prhs[1]
#define CODETYPE    prhs[2]
#define DEPTH       prhs[3]

/* Output Arguments */
#define OUTPUT_U    plhs[0]

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double	*input_c, *g_array; /* input arrays */
	double  *output_u_p; /* output arrays */
	int      DataLength, CodeLength, i, j, index, depth;
	int      subs[] = {1,1};
	int     *g_encoder;
	int		 nn, KK, mm, max_states, code_type;
	double   elm;
	float   *input_c_float;
	int     *output_u_int;
	int     *out0, *out1, *state0, *state1;

	/* Check for proper number of arguments */
	if (nrhs < 2 ) {
		mexErrMsgTxt("Usage: [output_u] = ViterbiDecode( input_c, g_encoder, [code_type], [depth] )");
	} else {
		/* first input is the LLRs of the code bits */
		input_c = mxGetPr(INPUT_C);

		/* second input specifies the code */
		g_array = mxGetPr(GENENCODER);
		nn = mxGetM(GENENCODER);
		KK = mxGetN(GENENCODER);
		mm = KK - 1;	
		max_states = 1 << mm;			/* 2^mm */
		
		CodeLength = mxGetN(INPUT_C); /* number of code bits */

		/* Make sure CodeLength is a multiple of nn */
		if ( CodeLength % nn > 0)
			mexErrMsgTxt("Length of input_c must be a multiple of n, the number of rows in g");

		/* default values */
		code_type = 0;

		/* 3rd input (optional) is the type of code */
		if (nrhs > 2 ) {			
			code_type   = (int) *mxGetPr(CODETYPE);
		} 

		/* determine the DataLength */
		if ( code_type < 2 ) {
			DataLength = (CodeLength/nn)-mm;
		} else {
			DataLength = CodeLength/nn;
			/* 4th input (optional) is the wrap depth */
			if (nrhs > 3) {
				depth = (int) *mxGetPr(DEPTH);
				depth = depth*KK;
			}	else {
				depth = 6*KK;
			}
		}

		/* convert the input into float */			
		input_c_float = calloc( CodeLength, sizeof(float) );
		for (i=0;i<CodeLength;i++)
			input_c_float[i] = input_c[i];

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

	if (nlhs  > 1) {
		mexErrMsgTxt("Usage: [output_u] = ViterbiDecode( input_c, g_encoder, [code_type], [depth] )" );
	} 

	/* the outputs */		
	OUTPUT_U = mxCreateDoubleMatrix(1, DataLength, mxREAL );
	output_u_p = mxGetPr(OUTPUT_U);	
	output_u_int = calloc( DataLength, sizeof(int) );
	
	/* create appropriate transition matrices */
	out0 = calloc( max_states, sizeof(int) );
	out1 = calloc( max_states, sizeof(int) );
	state0 = calloc( max_states, sizeof(int) );
	state1 = calloc( max_states, sizeof(int) );

	if ( code_type ) {
		nsc_transit( out0, state0, 0, g_encoder, KK, nn );
		nsc_transit( out1, state1, 1, g_encoder, KK, nn );
	} else {
		rsc_transit( out0, state0, 0, g_encoder, KK, nn );
		rsc_transit( out1, state1, 1, g_encoder, KK, nn );
	}

	/* Run the Viterbi algorithm */
	if ( code_type < 2 ) {
		Viterbi( output_u_int, out0, state0, out1, state1,
			input_c_float, KK, nn, DataLength ); 
	} else {
		ViterbiTb( output_u_int, out0, state0, out1, state1,
			input_c_float, KK, nn, DataLength, depth ); 
	}

	/* cast to outputs */
	for (j=0;j<DataLength;j++) {
		output_u_p[j] = output_u_int[j];
	}
	
	/* Clean up memory */
	free( out0 );
	free( out1 );
	free( state0 );
	free( state1 );
	free( g_encoder );
	free( input_c_float );
	free( output_u_int );

	return;
}
