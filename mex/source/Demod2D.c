/* File: Demod2D.c

   Description: Transforms received symbols into ML symbol log-likelihoods 

   The calling syntax is:
      [output] = Demod2D( input, S_matrix, EsNo, [fade_coef] )

   Where:
      output    = M by N matrix of symbol log-likelihoods

      input     = 1 by N matrix of (complex) matched filter outputs
	  S_matrix  = Length M complex vector representing the constellation
	  EsNo      = the symbol SNR (in linear, not dB, units)
	  fade_coef = 1 by N matrix of (complex) fading coefficients (defaults to all-ones)

   Copyright (C) 2005-2006, Matthew C. Valenti

   Last updated on May 6, 2006

   Function Demod2D is part of the Iterative Solutions 
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
prhs[1] is S_matrix
prhs[2] is EsNo
prhs[3] is fade_coef

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
  int    number_symbols;
  float  EsNo;
  double *Sr, *Si , *ar, *ai, *yr, *yi, *output;
  int    i,j;
  double tempsr, tempsi, Er, Ei;

  /* make sure there are enough inputs */
  if (nrhs<3)
	  mexErrMsgTxt("Usage: [output] = Demod2D( input, S_matrix, EsNo, [fade_coef] )");

  /* read in the inputs */
  number_symbols = mxGetN(prhs[0]);
  yr = mxGetPr(prhs[0]);
  if(!mxIsComplex(prhs[0]) )
	  yi = calloc( number_symbols, sizeof(double) );
  else
	  yi = mxGetPi(prhs[0]);  

  if (mxGetN(prhs[1])==1) /* column vector */
	  M = mxGetM( prhs[1] );
  else if (mxGetM(prhs[1])==1) /* row vector */
	  M = mxGetN( prhs[1] );
  else
	  mexErrMsgTxt("S_matrix should only have one column or row");

  Sr = mxGetPr(prhs[1]);
  if (!mxIsComplex(prhs[1]) )
	  Si = calloc( M, sizeof(double) );
  else
	  Si = mxGetPi(prhs[1]);

  EsNo = (float) *mxGetPr(prhs[2]);

  if(nrhs>3) {
	  if (mxGetN(prhs[3])!=number_symbols)
		  mexErrMsgTxt("Fading process must be same length as received signal");
	  
	  ar = mxGetPr(prhs[3]);
	  if (!mxIsComplex(prhs[3]) ) 
		  ai = calloc( number_symbols, sizeof(double) );
	  else
		  ai = mxGetPi(prhs[3]);
  } else {
	  ar = calloc( number_symbols, sizeof(double) );
	  for (i=0;i<number_symbols;i++)
		  ar[i] = 1; /* assume AWGN if no fading process specified */
	  ai = calloc( number_symbols, sizeof(double) );
  }

  plhs[0]=mxCreateDoubleMatrix(M, number_symbols, mxREAL);
  output = mxGetPr( plhs[0] );

  /* determine output */
  for (i=0;i<number_symbols;i++) { /* go through each received symbol */
	  for (j=0;j<M;j++) { /* each postulated symbol */
		  tempsr = ar[i]*Sr[j]-ai[i]*Si[j];
		  tempsi = ai[i]*Sr[j]+ar[i]*Si[j];
		  Er = yr[i]-tempsr;
		  Ei = yi[i]-tempsi;
		  output[i*M+j] = -EsNo*(Er*Er+Ei*Ei);
	  }
  }

  /* free memory */
  if(!mxIsComplex(prhs[0]) )
     free(yi);
  if(!mxIsComplex(prhs[1]) )
     free(Si);
  if (nrhs>3) {
	  if(!mxIsComplex(prhs[3]) )
		  free(ai);
  } else {
	  free(ar);
	  free(ai);
  }
}
