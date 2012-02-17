/* File: Modulate.c

   Description: Complex K-dimensional M-ary modulator

   The calling syntax is:
      [output] = Modulate( input, S_matrix )

   Where:
      output   = K by N vector of modulated symbols

      input    = 1 by N*log2(M) vector of data bits 
	  S_Matrix = K by M complex matrix containing the constellation signals
	             Each Column is one signal, each signal is K-dimensional

      Note: For legacy purposes, S_matrix can be a M by 1 matrix when signal
	  set can be characterized by a one-dimensional complex value (QAM, etc).

   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on May 6, 2006

   Function Modulate is part of the Iterative Solutions 
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

/* Input Arguments
prhs[0] is input
prhs[1] is S_matrix

/* Output Arguments
plhs[0] is output

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
  int    M, K;
  int    number_symbols, number_bits, bits_per_symbol;
  double *input, *Sr, *Si, *output_r, *output_i;
  int    i,j,temp_int,index;
  int    *data_int;

  /* make sure there are enough inputs */
  if (nrhs<2)
	  mexErrMsgTxt("Usage: [output] = Modulate( input, S_matrix )");

  /* read in input bits */
  number_bits = mxGetN(prhs[0]);
  input = mxGetPr(prhs[0]);

  /* read in the constellation matrix */
  
  /* for legacy purposes, see if it is a single column */
  if ( mxGetN( prhs[1] ) == 1 ) {
	  M = mxGetM( prhs[1] );
	  K = 1;
  } else {
	  M = mxGetN( prhs[1] );
	  K = mxGetM( prhs[1] );
  }  

  /* get the real part */
  Sr = mxGetPr(prhs[1]);

  /* if not complex, set imagainary part to zero */
  if (!mxIsComplex(prhs[1]) )
	  Si = calloc( M*K, sizeof(double) );
  else
	  Si = mxGetPi(prhs[1]);

  /* determine the number of bits per symbol 
     for future development: check to make sure M is a power of 2 */
  bits_per_symbol = 0;
  temp_int = M;
  while (temp_int>1) {
	 temp_int = temp_int/2;
	 bits_per_symbol++;
  }
  
  /* determine the number of output symbols */
  number_symbols = number_bits/bits_per_symbol + (number_bits%bits_per_symbol>0);

  /* read in the input data and cast to int */
  data_int = calloc( number_symbols*bits_per_symbol, sizeof(int) );
  for (i=0;i<number_bits;i++) 
	  data_int[i] = input[i];

  /* create the complex output matrix */
  plhs[0]=mxCreateDoubleMatrix( K, number_symbols, mxCOMPLEX);
  output_r = mxGetPr( plhs[0] );
  output_i = mxGetPi( plhs[0] );

  /* determine output */
  for (i=0;i<number_symbols;i++) { /* create each modulated symbol */
	  index = 0;
	  for (j=0;j<bits_per_symbol;j++) { /* go through each associated bit */
		  index = index << 1; /* shift to the left (multiply by 2) */
		  index += data_int[i*bits_per_symbol+j];
	  }
	  /* assign the K-dimensional output symbol */
	  for (j=0;j<K;j++) {
		  output_r[K*i+j] = Sr[K*index+j];
		  output_i[K*i+j] = Si[K*index+j];
	  }
  }

  /* free memory */
  free( data_int );
  
  if(!mxIsComplex(prhs[1]) )
     free(Si);

}

