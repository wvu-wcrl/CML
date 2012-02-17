/* file: CreateSRandomInterleaver.c

   Description: Produce a S-random interleaver

   The calling syntax is:

		[alpha] = CreateSRandomInterleaver( Length, S )

         alpha  = the interleaver in a length K vector 
		
         Length = the size of the interleaver 
		 S      = S value

   Copyright (C) 2005-2006, Matthew C. Valenti and Yufei Wu

   Last updated on Jan. 11, 2006

   Function CreateSRandomInterleaver is part of the Iterative Solutions 
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
#include "./include/srandom.h"

/* Input Arguments */
#define LENGTH     prhs[0]
#define SVAL	   prhs[1]

/* Output Arguments */
#define	OUTPUT	   plhs[0]

/* main function that interfaces with MATLAB */
void mexFunction(
	int		        nlhs,
	mxArray	        *plhs[],
	int		        nrhs,
	const mxArray	*prhs[] )
{
	int     DataLength;
    double	*output_p;
	int     *alpha_code; /* interleaver */
	int     i;
	int     s_value;

	/* Check for proper number of arguments */
	if (nrhs != 2) {
		mexErrMsgTxt("[alpha] = CreateSRandomInterleaver( Length, S )");
	} else if (nlhs > 1) {
		mexErrMsgTxt("[alpha] = CreateSRandomInterleaver( Length, S )");
	}	
	
	/* initialize the input data */
	DataLength   = (int) *mxGetPr(LENGTH);
	s_value = (int) *mxGetPr(SVAL);

	/* Create the interleaver */
	/* printf( "\nMaking interleaver\n" ); */
	alpha_code = calloc( DataLength, sizeof(int) );

	CreateSRandomInterleaver( DataLength, s_value, alpha_code );
	/* printf( "Done making the interleaver\n" );
	 printf( "K = %d\n", DataLength ); */

	/* Output encoded data */
	OUTPUT = mxCreateDoubleMatrix(1, DataLength, mxREAL);
	output_p = mxGetPr(OUTPUT);

	for (i=0;i<DataLength;i++) {
		output_p[i] = alpha_code[i];
		/* printf( "%d", CodeBits[i] ); */
	}

	/* printf( "\n" ); */

	free( alpha_code );

	return;
}
