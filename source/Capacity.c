/* File: Capacity.c

   Description: Determines capacity of M-ary modulation

   The calling syntax is:
      [output] = capacity( input, data )

   Where:
      output  = Instantaneous capacity of this frame

      input   = M by N matrix of symbol likelihoods 
	  data    = 1 by N*log2(M) vector of data bits

   Note: if M = 1, then the input must be bitwise LLRs. 

   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on Jan. 11, 2006

   Function Capacity is part of the Iterative Solutions 
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
#include "./include/maxstar.h"

/* Input Arguments
prhs[0] is input
prhs[1] is data

/* Output Arguments
plhs[0] is output

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
  int    M;
  int    number_symbols, number_bits, bits_per_symbol;
  double *input, *output, *data; 
  int    i,j,index,temp_int;
  double cap_sum, temp_cap;

  /* make sure there are enough inputs */
  if (nrhs<2)
	  mexErrMsgTxt("Usage: [output] = capacity( input, data )");

  /* read in input received symbols */
  number_symbols = mxGetN(prhs[0]);
  M = mxGetM(prhs[0]);
  input = mxGetPr(prhs[0]);

  /* read in data bits */
  number_bits = mxGetN(prhs[1]);
  if ( mxGetM(prhs[1])!=1)
	  mexErrMsgTxt("data must be a row vector");
  data = mxGetPr(prhs[1]);

  /* determine the number of bits per symbol */
  if (M == 1) 
	  bits_per_symbol = 1; /* input is bitwise LLRs */
  else {
	  bits_per_symbol = 0;
	  temp_int = M;
	  while (temp_int>1) {
		  temp_int = temp_int/2;
		  bits_per_symbol++;
	  }
  }
  /* printf( "number of symbols = %d\n", number_symbols);
  printf( "number of bits = %d\n", number_bits );
  printf( "M = %d\n", M);
  printf( "Bits per symbol = %d\n", bits_per_symbol ); /*
  
  /* make sure that number of bits is consistent */
  if ( number_bits%bits_per_symbol )
	  mexErrMsgTxt( "Number of bits does not divide log_2(M)" );
  if ( (number_symbols*bits_per_symbol) != number_bits )
	  mexErrMsgTxt( "Number of bits inconsistent with number of symbols" );

  /* output is a real scalar */
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  output = mxGetPr( plhs[0] );

  /* determine capacity */
  cap_sum = 0;
  if ( M == 1 ) {
	  /* the input is bitwise LLRs */
	  for (i=0;i<number_symbols;i++) {
		  if ( data[i] > 0 )
			  cap_sum += max_star4( 0, -input[i] );
		  else
			  cap_sum += max_star4( 0, input[i] );
	  }
	  /* printf( "cap_sum = %f\n", cap_sum ); */
	  output[0] = 1 - cap_sum/(number_symbols*log(2));
  } else {
	  for (i=0;i<number_symbols;i++) { /* create each modulated symbol */
		  /* determine the index */
		  index = 0;
		  for (j=0;j<bits_per_symbol;j++) { /* go through each associated bit */
			  index = index << 1; /* shift to the left (multiply by 2) */
			  index += data[i*bits_per_symbol+j];
		  }
		  temp_cap = -1000000;
		  for (j=0;j<M;j++) {
			  /* printf( "metric[%d] = %f\n", M, input[i*M+j]-input[i*M+index] ); */
			  temp_cap = max_star4( temp_cap, input[i*M+j] - input[i*M+index] );
		  }
		  /* printf( "temp_cap = %f\n\n", temp_cap ); */
		  cap_sum += temp_cap;
	  }
	  output[0] = 1 - cap_sum/(number_symbols*log(M));
  }

  /* printf( "cap_sum = %f\n", cap_sum ); */
  /* printf( "instantaneous capacity = %f\n", output[0] ); */

}

