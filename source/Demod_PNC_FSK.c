/* File: Demod_PNC_FSK.c

   Description: Computes log-probability of M-ary PNC symbols at relay in two-way relay channel

   The calling syntax is:
   [output] = Demod_PNC_FSK( y, EsNo, csi_flag, a1, a2, sqE1, sqE2, csi1sw )

   Where:
   output  = linear vector containing symbol probability matrices for each
   symbol received at relay.  See [1] in the source file for more details.

   input   = 1   y         M by N matrix of received symbols
   2   EsNo      Signal-to-noise ratio
   3   csi_flag  0 - full csi, 1 - partial csi, 2 - no csi
   4   a1        M by N matrix of fading coefs for channel 1
   5   a2        M by N matrix of fading coefs for channel 2
   6   sqE1      Energy per symbol, source 1
   7   sqE2      Energy per symbol, source 2 
   8   csi1sw    Select alpha estimation type
   0 - knowledge of phase dif
   1 - phase dif approximated


   Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti

   Last updated on May. 29, 2012

   implementation of the receiver found in
   Noncoherent Digital Network Coding
   Using Multi-tone CPFSK Modulation
   Terry Ferrettâˆ— , Matthew C. Valentiâˆ— , and Don Torrieriâ€
   âˆ— West Virginia University, Morgantown, WV, USA.
   â€  U.S. Army Research Laboratory, Adelphi, MD, USA.

*/


/* [1]
   the output is a linear vector containing symbol probability matrices for
   each symbol received at the relay.  

   The dimensionality of the matrix is  MxM, where M is the modulation order.

   Each matrix is placed into the vector one row at a time, so for example
   in the 4-ary case

   [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
 
   becomes

   [1 2 3 4
   5 6 7 8
   9 10 11 12
   13 14 15 16]
*/


#include <mex.h>    /* required matlab include for c-mex */
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "./include/maxstar.h"



/* the logI_0 function */
static float logbesseli0(float x) {
  if (x < 1)
    return( 0.22594*x*x + 0.012495*x - 0.0011272 );
  else if (x < 2)
    return( 0.12454*x*x + 0.21758*x - 0.10782 );
  else if (x < 5)
    return( 0.028787*x*x + 0.63126*x - 0.56413 );
  else if (x < 15)
    return( 0.003012*x*x + 0.88523*x - 1.2115 );
  else if (x < 30)
    return( 0.00053203*x*x + 0.95304*x - 1.6829 );
  else if (x < 60)
    return( 0.00013134*x*x + 0.97674*x - 2.0388 );
  else if (x < 120)
    return( 0.9943*x - 2.6446 );
  else if (x < 250)
    return( 0.99722*x - 3.0039 );
  else if (x < 500)
    return( 0.99722*x - 3.0039 );
  else
    return( 0.99916*x - 3.6114 );
}


double Log2( double n )  
{  
    // log(n)/log(2) is log2.  
    return log( n ) / log( 2 );  
}


static void Demod_PNC_MFSK( double llr[],   float yr_f[],   float yi_f[],
			    float hr1_f[],  float hi1_f[],
			    float hr2_f[],  float hi2_f[],
			    float sqE1,  float sqE2,
			    float snr,
			    int csi_flag,   int M,  int ns,  int csi1sw ) {
    
  int i, j, k, s;             /* iterators */
  float a1Mag, a2Mag, aMag;   /* fading coefficients */
  int Ml; /* bits per symbol */
  int A, B;  /* temporary variables */
  float log_term_dif, log_term_same;

  Ml = (int)Log2(M); 
    

  /* terms which are constant for each symbol */
  log_term_dif = -log( 1/(sqE1*sqE2) * (1/sqE1 + snr) * (1/sqE2 + snr) );
  log_term_same = log( 1/(sqE1 + sqE2) ) - log( 1/(sqE1 + sqE2) + snr );
  /*****************************************/

    
  /* loop over all symbols */
  for(s=0; s < ns; s++){
        
    if(csi_flag == 0){
      mexErrMsgTxt("full csi case (csi = 0) not implemented");
      return;
    }


    else if (csi_flag == 1){
            
      /* compute fading coefficient magnitudes */
      if(csi1sw==0){
	/* First compute \alpha_1, alpha_2, and \alpha */
	a1Mag = hr1_f[s]*hr1_f[s] + hi1_f[s]*hi1_f[s];
	a2Mag = hr2_f[s]*hr2_f[s] + hi2_f[s]*hi2_f[s];
	aMag = (hr1_f[s]+hr2_f[s])*(hr1_f[s]+hr2_f[s]) + (hi1_f[s]+hi2_f[s])*(hi1_f[s]+hi2_f[s]);
      }else{
	a1Mag = hr1_f[s]*hr1_f[s] + hi1_f[s]*hi1_f[s];
	a2Mag = hr2_f[s]*hr2_f[s] + hi2_f[s]*hi2_f[s];
	aMag = a1Mag+a2Mag;
      }

            
      /*   compute values of log p(y|q1, q2)  */
      for(i=0; i < M; i++){
	for(j=0; j <= i; j++) {
	  if(i != j) {
	    llr[s*M*M + i*M + j] = -snr*(a1Mag + a2Mag)
	      + logbesseli0(2*snr*sqrt(a1Mag*(yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i])))
	      + logbesseli0(2*snr*sqrt(a2Mag*(yr_f[s*M + j]*yr_f[s*M + j] + yi_f[s*M + j]*yi_f[s*M + j])));

	    llr[s*M*M + j*M + i] = -snr*(a1Mag + a2Mag)
	      + logbesseli0(2*snr*sqrt(a1Mag*(yr_f[s*M + j]*yr_f[s*M + j] + yi_f[s*M + j]*yi_f[s*M + j])))
	      + logbesseli0(2*snr*sqrt(a2Mag*(yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i])));


	    /*  llr[s*M*M + j*M + i] = llr[s*M*M + i*M + j];    symmetric matrix entry */
	  }else {
	    llr[s*M*M + i*M + j] = -aMag*snr
	      + logbesseli0(2*snr*sqrt(aMag*(yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i])));
                        
	  }
	}
      }
      
    }   
    
    else if( csi_flag == 2) {     

   
      /*   compute values of log p(y|q1, q2)  */
      for(i=0; i < M; i++){
	for(j=0; j <=i ; j++) {
	  if(i != j) {
	    llr[s*M*M + i*M + j] =   log_term_dif
	      +
	      ( yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i] ) * sqE1/
	      ( 1/snr*(1/snr + sqE1) )
	      +
	      ( yr_f[s*M + j]*yr_f[s*M + j] + yi_f[s*M + j]*yi_f[s*M + j] ) * sqE2/
	      ( 1/snr*(1/snr + sqE2) );

	    llr[s*M*M + j*M + i] =   log_term_dif
	      +
	      ( yr_f[s*M + j]*yr_f[s*M + j] + yi_f[s*M + j]*yi_f[s*M + j] ) * sqE1/
	      ( 1/snr*(1/snr + sqE1) )
	      +
	      ( yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i] ) * sqE2/
	      ( 1/snr*(1/snr + sqE2) );


	    /* llr[s*M*M + j*M + i] = llr[s*M*M + i*M + j];    symmetric matrix entry */
	  }else {
	    llr[s*M*M + i*M + j] = log_term_same 
	      + ( yr_f[s*M + i]*yr_f[s*M + i] + yi_f[s*M + i]*yi_f[s*M + i] ) * ( sqE1 + sqE2 )/
	      ( (1/snr)*(1/snr) + 1/snr * (sqE1 + sqE2) );

	  }
                    
	}
      }
            
    }
   
  }    
    
}
 


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    
  int M;       /* modulation order */
  int ns;      /* number of transmitted symbols */
  float snr;   /* signal-to-noise ratio */
  int no;      /* number of outputs */
    
  double *hr1, *hi1;   /* gain for channel 1 */
  double *hr2, *hi2;   /* gain for channel 2 */
  float *hr1_f, *hi1_f;   /* gain for channel 1, float */
  float *hr2_f, *hi2_f;   /* gain for channel 2, float */
    
  double *yr, *yi;           /* matched filter outputs */
  float *yr_f, *yi_f;
    
  double *sym_likelihood;         /* symbol log-likelihood ratios */
  double  *sym_likelihood_f;
    
  int csi_flag;        /* channel state information
			* 0 - perfect
			* 1 - alpha known, theta unknown
			* 2 - alpha and theta unknown */
    
  double sqE1, sqE2;   /* signal energies */    
  int csi1sw;          /* alpha approximation mode */    
  int i, j, k;           /* iterators */
    
    
    
  if (nrhs < 2)                                       /* validate number of i/o args */
    mexErrMsgTxt("Usage: [output] = Demod_PNC_FSK( input, EsNo,\
                csi_flag, \
                a1, \
                a2, \
                sqE1, \
                sqE2, \
                csi1switch)");                
                
                
  ns = mxGetN(prhs[0]);      /* number of symbols in frame */    
  M = mxGetM(prhs[0]);       /* symbol vector dimensions */
  no = (int)ns*M*M;  /* amount of memory to allocate for output */


  /******* allocate memory for received symbols *********/    
  yr = mxGetPr(prhs[0]);

  yr_f = calloc( ns*M, sizeof(float) );      /* real part of the received symbols */    
  for (i=0; i<ns; i++)                               /* cast to float */
    for (j=0; j<M; j++)
      yr_f[i*M+j] = (float) yr[i*M+j];    
    
    
  yi_f = calloc( ns*M, sizeof(float) );       /* imaginary part of received symbols */
  if(mxIsComplex(prhs[0]) ) {
    yi = mxGetPi(prhs[0]);
    /* cast to float */
    for (i=0; i<ns ;i++)
      for (j=0;j<M;j++)
	yi_f[i*M+j] = (float) yi[i*M+j];
  }
  /*****************************************************/
       
    
  snr = (float) *mxGetPr(prhs[1]);     /* second input is the SNR */
    
  if (nrhs > 2 )                       /* third input (optional) is the csi flag */
    csi_flag = (int) *mxGetPr(prhs[2]);
  else
    csi_flag = 0;    
    
    
  if(nrhs>3) {    /* fourth input (optional) are the fading amplitudes */
        
    if (mxGetN(prhs[3])!=ns)              /* initialize the fading amplitudes */
      mexErrMsgTxt("Fading process must be same length as received signal");
        
    hr1_f = calloc( ns, sizeof(float) );
    hi1_f = calloc( ns, sizeof(float) );
    hr2_f = calloc( ns, sizeof(float) );
    hi2_f = calloc( ns, sizeof(float) );        
        
    hr1 = mxGetPr(prhs[3]);    /* real part of the fading process 1*/
    for (i=0; i<ns ;i++)           /* cast to float */
      hr1_f[i] = (float) hr1[i];        
        
    if (mxIsComplex(prhs[3]) ) {   /* imaginary part of the fading process 1 */
      hi1 = mxGetPi(prhs[3]);
            
      for (i=0; i<ns ;i++)         /* cast to float */
	hi1_f[i] = (float) hi1[i];
    }
               
        
    hr2 = mxGetPr(prhs[4]);   /* real part of the fading process 2*/
        
    for (i=0; i< ns ;i++)            /* cast to float */
      hr2_f[i] = (float) hr2[i];
        
    if (mxIsComplex(prhs[4]) ) {              /* imaginary part of the fading proces */
      hi2 = mxGetPi(prhs[4]);
            
      /* cast to float */
      for (i=0; i<ns; i++)
	hi2_f[i] = (float) hi2[i];
    }
        
  }


  /***** fifth input: symbol energies **********/    
  sqE1 = (float) *mxGetPr(prhs[5]);       
  sqE2 = (float) *mxGetPr(prhs[6]);
  /********************************/    

  /***** sixth input: csi switch  **************************/
  csi1sw = (int)*mxGetPr(prhs[7]);        
  /********************************************/
    

  /**** initialize output ****************/
  sym_likelihood = calloc( no, sizeof(double) );     /* intialize the output */
  plhs[0]=mxCreateDoubleMatrix(1, no, mxREAL);
  sym_likelihood_f = mxGetPr( plhs[0] );
  /***************************************/
    

  /*********** call to frame-wise demodulator ************/
  Demod_PNC_MFSK( sym_likelihood,   yr_f,   yi_f,
		hr1_f,  hi1_f,
		hr2_f,  hi2_f,
		sqE1,  sqE2,
		snr,
		csi_flag,   M,  ns,  csi1sw );
  /*******************************************/
    
    
  /********** assign computed LLRs to output ****************/
  for (i=0; i<no ;i++) {
    sym_likelihood_f[i] = sym_likelihood[i];
  }
  /*****************************************/
    
    
  /* free memory */
  free( yr_f );   /* matched filter outputs */
  free( yi_f );
  if(nrhs > 3){
    free( hr1_f );  /* fading processes */
    free( hi1_f );
    free( hr2_f );
    free( hi2_f );
  }    
    
  free( sym_likelihood );    
}



/******************************************************
   Function Demod_PNC_FSK is part of the Iterative Solutions 
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
************************************************************/
