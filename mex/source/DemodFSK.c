/* File: DemodFSK.c

   Description: Transforms M-dimensional FSK symbols into ML symbol log-likelihoods 

   The calling syntax is:
      [output] = FskDemod( input, EsNo, [csi_flag], [fade_coef] )

   Where:
      output    = M by N matrix of symbol log-likelihoods

      input     = M by N matrix of (complex) matched filter outputs
	  EsNo      = the symbol SNR (in linear, not dB, units)
	  csi_flag  = 0 for coherent reception (default)
	              1 for noncoherent reception w/ perfect amplitude estimates
				  2 for noncoherent reception without amplitude estimates
	  fade_coef = 1 by N matrix of (complex) fading coefficients (defaults to all-ones, i.e. AWGN)

   Copyright (C) 2006, Matthew C. Valenti

   Last updated on May 6, 2006

   Function DemodFSK is part of the Iterative Solutions 
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
prhs[1] is EsNo
prhs[2] is csi_flag
prhs[3] is fade_coef

/* Output Arguments
plhs[0] is output

/* the logI_0 function */
static float logbesseli0(float x)
{	
	if (x < 1) 
		return( 0.226*x*x+0.0125*x-0.0012 );
	else if (x < 2)
		return( 0.1245*x*x+0.2177*x-0.108 );
	else if (x < 5)
		return( 0.0288*x*x+0.6314*x-0.5645 );
	else if (x < 20)
		return( 0.002*x*x+0.9048*x-1.2997 );
	else
		return(0.9867*x-2.2053);
}

/* Function that does the demodulation (can be used in stand-alone C) */
static void FskDemod(
					 float out[],
					 float yr[],
					 float yi[],
					 float ar[],
					 float ai[],
					 float SNR,
					 int csi_flag,
					 int M,
					 int number_symbols
					 )
{
	int i, j;	
	float a_envelope, y_envelope, y_power, scale_factor;
	
	if (csi_flag == 0) {	
		scale_factor = 2*SNR;
		for (i=0;i<number_symbols;i++) { 
			for (j=0;j<M;j++) { 				
				out[i*M+j] = scale_factor*( yr[i*M+j]*ar[i] + yi[i*M+j]*ai[i] );
			}
		}
	} else if (csi_flag == 1) {	
		scale_factor = 2*SNR;
		for (i=0;i<number_symbols;i++) { 
			a_envelope = sqrt( ar[i]*ar[i] + ai[i]*ai[i] );

			for (j=0;j<M;j++) { 
				y_envelope = sqrt( yr[i*M+j]*yr[i*M+j] + yi[i*M+j]*yi[i*M+j] );
				out[i*M+j] = logbesseli0( scale_factor*a_envelope*y_envelope );
			}
		}
	} else if (csi_flag == 2) {
		scale_factor = SNR*SNR/(1+SNR);
		for (i=0;i<number_symbols;i++) { 
			for (j=0;j<M;j++) { 
				y_power = yr[i*M+j]*yr[i*M+j] + yi[i*M+j]*yi[i*M+j];
				out[i*M+j] = scale_factor*y_power;
			}
		}
	}
}

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
  double *ar, *ai, *yr, *yi, *output;
  int    i,j;
  int	 csi_flag;

  float *ar_float, *ai_float, *yr_float, *yi_float, *output_float;

  /* might not need */
  double tempsr, tempsi, Er, Ei;

  /* make sure there are enough inputs */
  if (nrhs<2)
	  mexErrMsgTxt("Usage: [output] = DemodFSK( input, EsNo, [csi_flag], [fade_coef] )");

  /* read in the inputs */

  /* first input are the recevied complex symbols */
  number_symbols = mxGetN(prhs[0]); 
  M = mxGetM(prhs[0]);

  /* real part of the received symbols */
  yr_float = calloc( number_symbols*M, sizeof(float) );
  yr = mxGetPr(prhs[0]);

  /* cast to float */
  for (i=0;i<number_symbols;i++) { 
	  for (j=0;j<M;j++) { 
		   yr_float[i*M+j] = (float) yr[i*M+j];
	  }
  }

  /* imaginary part of the received symbols */
  yi_float = calloc( number_symbols*M, sizeof(float) );

  if(mxIsComplex(prhs[0]) ) {
	  yi = mxGetPi(prhs[0]);

	  /* cast to float */
	  for (i=0;i<number_symbols;i++) { 
		  for (j=0;j<M;j++) { 
			  yi_float[i*M+j] = (float) yi[i*M+j];
		  }
	  }
  }
  

  /* second input is the SNR */
  EsNo = (float) *mxGetPr(prhs[1]);

  /* third input (optional) is the csi flag */
  if (nrhs > 2 ) 
	  csi_flag = (int) *mxGetPr(prhs[2]);
  else
	  csi_flag = 0;

  /* initialize the fading amplitudes */ 
  ar_float = calloc( number_symbols, sizeof(float) );
  ai_float = calloc( number_symbols, sizeof(float) );

  /* fourth input (optional) are the fading amplitudes */ 
  if(nrhs>3) {
	  if (mxGetN(prhs[3])!=number_symbols)
		  mexErrMsgTxt("Fading process must be same length as received signal");
	  
	  /* real part of the fading process */
	  ar = mxGetPr(prhs[3]);

	  /* cast to float */
	  for (i=0;i<number_symbols;i++)
		  ar_float[i] = (float) ar[i];

	  /* imaginary part of the fading proces */
	  if (mxIsComplex(prhs[3]) ) {
		  ai = mxGetPi(prhs[3]);
		  
		  /* cast to float */
		  for (i=0;i<number_symbols;i++)
			  ai_float[i] = (float) ai[i];
	  }

  } else {
	  for (i=0;i<number_symbols;i++)
		  ar_float[i] = 1; /* assume AWGN if no fading process specified */
  }

  /* intialize the output */
  output_float = calloc( number_symbols*M, sizeof(float) );
  plhs[0]=mxCreateDoubleMatrix(M, number_symbols, mxREAL);
  output = mxGetPr( plhs[0] );

  /* determine output */
  FskDemod( output_float, yr_float, yi_float, ar_float, ai_float, EsNo, csi_flag, M, number_symbols );


  /* cast from float to double */
  for (i=0;i<number_symbols;i++) { 
	  for (j=0;j<M;j++) { 
		   output[i*M+j] = output_float[i*M+j];
	  }
  }

  /* free memory */
  free( yr_float );
  free( yi_float );
  free( ar_float );
  free( ai_float ); 
  free( output_float );

}

