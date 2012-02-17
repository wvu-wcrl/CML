/* RateDematch reverses the basic HSDPA Rate Matching algorithm

   The calling syntax is:
      y = RateDematch( x, X_i, e_ini, e_plus, e_minus );
 
      y = depunctured output (length X_i)

      x = input consisting of received/punctured bits
      X_i = length of the depunctured output
      e_ini = parameter used by algorithm
      e_plus = parameter used by algorithm
      e_minus = parameter used by algorithm

   Copyright (C) 2005, Matthew C. Valenti

   Last updated on Dec. 3, 2005


   Function RateDematch is part of the Iterative Solutions 
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

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	double *input, *output_p;
	int X_i, e_ini, e_plus, e_minus;
	int m, e, index, input_length;

	/* Check for proper number of arguments */
	if ((nrhs < 5 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: y = RateDematch( x, X_i, e_ini, e_plus, e_minus )");
	} 		
	
	/* first input vector that needs to have rate matching reversed */
	input = mxGetPr( prhs[0] );	
	input_length = mxGetN( prhs[0] ); /* length of input */
	
	/* remaining inputs (all ints) */
	X_i = (int) *mxGetPr( prhs[1] );
	e_ini = (int) *mxGetPr( prhs[2] );
	e_plus = (int) *mxGetPr( prhs[3] );
	e_minus = (int) *mxGetPr( prhs[4] );

	/* verify that input length is correct
	   development note: eventually this could be replaced by a formula */
	e = e_ini;
	index = 1;
	for (m=1;m<=X_i;m++) {
		e -= e_minus;
		if (e<=0) 
			e += e_plus;
		else
			index++;
	}
	
	index--;
	if ( index != input_length )
		mexErrMsgTxt("Input length is invalid");

	/* Create output */
	plhs[0] = mxCreateDoubleMatrix( 1, X_i, mxREAL );
	output_p = mxGetPr( plhs[0] );

	/* Dematch */
	e = e_ini;
	index = 1;
	for (m=1;m<=X_i;m++) {
		e -= e_minus;
		if (e<=0) {
			/* zero pad */
			e += e_plus;
		} else {
			output_p[m-1] = input[index-1];
			index++;
		}
	}		

	return;
}
