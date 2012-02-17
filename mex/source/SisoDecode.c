/* file: SisoDecode.c

   Description: Soft-in/soft-out decoding algorithm for a convolutional code

   The calling syntax is:

      [output_u, output_c] = SisoDecode(input_u, input_c, g_encoder, [code_type], [dec_type] )

      output_u = LLR of the data bits
	  output_c = LLR of the code bits

      Required inputs:
	  input_u = APP of the data bits
	  input_c = APP of the code bits
	  g_encoder = generator matrix for convolutional code
	              (If RSC, then feedback polynomial is first)
	  
	  Optional inputs:
	  code_type = 0 for RSC outer code (default)
	            = 1 for NSC outer code
	  dec_type = the decoder type:
			= 0 For linear approximation to log-MAP (DEFAULT)
			= 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) )
			= 2 For Constant-log-MAP algorithm
			= 3 For log-MAP, correction factor from small nonuniform table and interpolation
			= 4 For log-MAP, correction factor uses C function calls (slow)  
   
   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on Jan. 11, 2006

   Function SisoDecode is part of the Iterative Solutions 
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
#include "./include/maxstar.h"
#include "./include/convolutional.h"
#include "./include/siso.h"

/* Input Arguments */
#define INPUT_U     prhs[0]
#define INPUT_C     prhs[1]
#define GENENCODER  prhs[2]
#define CODETYPE    prhs[3]
#define DECTYPE     prhs[4]

/* Output Arguments */
#define OUTPUT_U    plhs[0]
#define OUTPUT_C    plhs[1] 

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double	*input_u, *input_c, *g_array; /* input arrays */
	double  *output_u_p, *output_c_p; /* output arrays */
	int      DataLength, CodeLength, i, j, index;
	int      subs[] = {1,1};
	int     *g_encoder;
	int		 nn, KK, mm, max_states, code_type, dec_type;
	double   elm;
	float   *input_u_float, *input_c_float;
	float   *output_u_float, *output_c_float;
	int     *out0, *out1, *state0, *state1;

	/* default values */
	code_type = 0;
	dec_type  = 0;

	/* Check for proper number of arguments */
	if (nrhs < 3 ) {
		mexErrMsgTxt("Usage: [output_u, output_c] = SisoDecode(input_u, input_c, g_encoder, code_type, decoder_type )");
	} else {
		/* first two inputs are the LLRs of the data and code bits */
		input_u = mxGetPr(INPUT_U);	
		input_c = mxGetPr(INPUT_C);

		/* third input specifies the code */
		g_array = mxGetPr(GENENCODER);
		nn = mxGetM(GENENCODER);
		KK = mxGetN(GENENCODER);
		mm = KK - 1;	
		max_states = 1 << mm;			/* 2^mm */
		
		DataLength = mxGetN(INPUT_U); /* number of data bits */
		CodeLength = mxGetN(INPUT_C); /* number of code bits */

		/* make sure these agree */
		if ( CodeLength != nn*(DataLength+mm) ) 
			mexErrMsgTxt( "SisoDecode: Length of input_u and input_c don't agree" );

		/* convert the inputs into float */			
		input_u_float = calloc( DataLength, sizeof(float) );
		for (i=0;i<DataLength;i++)
			input_u_float[i] = input_u[i];
		
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

	if (nrhs > 3 ) {
		/* 4th input (optional) is the type of code */
		code_type   = (int) *mxGetPr(CODETYPE);
	} if (nrhs > 4 ) {
		/* 5th input (optional) is the decoder type */
		dec_type  = (int) *mxGetPr(DECTYPE);
	} 

	if (nlhs  > 2) {
		mexErrMsgTxt("Usage: [output_u, output_c] = SisoDecode(input_u, input_c, g_encoder, code_type, decoder_type )" );
	} 

	/* the outputs */		
	OUTPUT_U = mxCreateDoubleMatrix(1, DataLength, mxREAL );
	output_u_p = mxGetPr(OUTPUT_U);	
	output_u_float = calloc( DataLength, sizeof(float) );
	
	OUTPUT_C = mxCreateDoubleMatrix(1, CodeLength, mxREAL );
	output_c_p = mxGetPr(OUTPUT_C);	
	output_c_float = calloc( CodeLength, sizeof(float) );

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

	/* Run the SISO algorithm */
	siso( output_u_float, output_c_float, out0, state0, out1, state1,
		input_u_float, input_c_float, KK, nn, DataLength, dec_type );

	/* cast to outputs */
	for (j=0;j<DataLength;j++) {
		output_u_p[j] = output_u_float[j];
	}

	for (j=0;j<CodeLength;j++) {
		output_c_p[j] = output_c_float[j];
	}
		
	/* Clean up memory */
	free( out0 );
	free( out1 );
	free( state0 );
	free( state1 );
	free( g_encoder );
	free( input_u_float );
	free( input_c_float );
	free( output_u_float );
	free( output_c_float );

	return;
}
