/* file: DuobinaryCRSCDecode.c

   Description: Decod a sequence that was encoded by a duobinary tailbiting
                convolutional code.

   The calling syntax is:

      [outx, outz, soft_bits] = DuobinaryCRSCDecode( inx, inz, poly, dec_type); 

   Inputs:
       inx  = 3*N matrix for information couples input in GF(4) {01, 10, 11}
       inz  = 3*N matrix for parity couples input
       poly = polynomials for parity bits, 
              use [1 0 1 1; 1 0 0 1] for DVB and Wimax CTC Code, 
              note that the feedback vector is [1 1 0 1] by default.
       dec_type = the decoder type:
			    = 0 For linear approximation to log-MAP (DEFAULT)
			    = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) )
			    = 2 For Constant-log-MAP algorithm
			    = 3 For log-MAP, correction factor from small nonuniform table and interpolation
			    = 4 For log-MAP, correction factor uses C function calls (slow)  

   Outputs:
       outx =  total output for information couples, also in 3*N forms in GF(4)
               outx - inx  is the extrinsic information for information couples
       outz =  total output for parity couples , also in M*N forms
               outz - inz is the extrinsic information for parity couples
           
       (outz is not calculated in the current version, since for turbo decoding only, they are useless
        to be added later)
           
       soft_bits =  the soft information to make a hard decsion, they are close to outx, 
                   but might be different when max_option is not -1.


   Copyright (C) 2005-2007, Matthew C. Valenti and Shi Cheng

   Last updated on Oct. 12, 2007

   Function DuobinaryCRSCDecode is part of the Iterative Solutions 
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
#include "mex.h"
#include "math.h"
#include ".\include\maxstar.h"
#include ".\include\turbo.h"

#define ABS_ERR 1E-7
#define MAX_CYCLE 4

/* the Duo binary CRCS code SISO, 
   inx: input llrs of systematic symbols
   inz: input llrs of parity symbols
   len: length of the symbols 
   trellis_end_state, the array indicating the end state of each trellis
   trellis_out:  the array indicating the output of each trellis, refer to find_Duobinary_trellis for detail
   dec_type: the max_star operator type 

   outx: output llrs of systematic symbols
   outz: output llrs of parity symbols
   soft_bits: soft llrs of binary systematic bits*/
void Duobinary_SISO_wtrellis( float *inx, float *inz, float *outx, float *outz, float *soft_bits, int len, int *trellis_end_state, int *trellis_out , int dec_type)
{

    int m_input = 2;  // 2 input bits,
	int max_states = 8; // total state numbers
	int M_input = 1<<m_input;
	int llr_height = M_input -1;  //llr_height is 3 for DVB and Wimax code
	float **beta, **alpha, *gamma, *tempab, *temp_llrout;  // tempab saves the temporary calcuation of beta and alpha, for comparison with the stopping threshold
	int i, j, max_trellis = M_input * max_states;
	int cycles= 0, stop_it = 0, temp_input, temp_output;
    float (*max_star[])(float, float) =
	{ 
		max_star0, max_star1, max_star2, max_star3, max_star4
	};


	// allocate memory for alpha, beta, and gamma
	beta = malloc( sizeof(float*)* max_states);
	alpha = malloc( sizeof(float*)* max_states);
	for ( i = 0; i < max_states; i++)
	{
		alpha[i] = malloc( sizeof(float)* (len+1) );
		beta[i] = malloc( sizeof(float) * (len+1) );
	}
    gamma = malloc( sizeof(float)* max_trellis);
    tempab = malloc (sizeof(float) * max_states);
    temp_llrout = malloc( sizeof(float)* M_input);

    // initialization  for CRSC code
    for (i =0; i< max_states; i++)
	{
		alpha[i][0] = 0;
		beta[i][len] = 0;
	}

	//beta
	cycles = 0;
	  
	while (cycles < MAX_CYCLE )
	{
        
		for (i = len-1; i>=0; i--)  // calculate beta[][i] based on beta[][i+1]
		{
			stop_it = 1; // stop iterations
			for (j = 0; j< max_trellis; j++)
			{
				temp_input = j%M_input;
				temp_output = trellis_out[j];
				gamma[j] = ( temp_input ==0)? 0: inx[ (temp_input -1)+ i*llr_height ];   //llr for systematic symbol
				gamma[j] += ( temp_output ==0)? 0: inz[ (temp_output -1)+ i*llr_height ];  //llr for parity symbol
				gamma[j] += beta[ trellis_end_state[j] ][i+1];
			}
			for (j= 0; j< max_states; j++)
				tempab[j] = -MAXLOG;
			for (j = 0; j< max_trellis; j++)
				tempab[j/M_input] = ( *max_star[dec_type] )( tempab[j/M_input], gamma[j]);
            for (j = 1; j< max_states; j++)
			{
				tempab[j] = tempab[j] - tempab[0];
                if ( (stop_it == 1) &&  (((tempab[j] - beta[j][i]) > ABS_ERR ) || ((beta[j][i] - tempab[j]) > ABS_ERR ) ) )
		 		   stop_it = 0;
				beta[ j][i] = tempab[ j];
			}
			beta[0][i] = 0;
            if ((stop_it == 1) && ( cycles > 0))
				break;
						
		}


		if ((stop_it == 1) && ( cycles > 0))
			break;
		else
		{
			for (j= 0; j<max_states; j++)
				beta[j][len] = beta[j][0];
		}
		cycles++;
	}

    // alpha
	cycles = 0;
	  
	while (cycles < MAX_CYCLE )
	{
        
		for (i = 0; i<len; i++)  // calculate alpha[][i+1] based on beta[][i]
		{
			stop_it = 1; // stop iterations
			for (j = 0; j< max_trellis; j++)
			{
				temp_input = j%M_input;
				temp_output = trellis_out[j];
				gamma[j] = ( temp_input ==0)? 0: inx[ (temp_input -1)+ i*llr_height ];   //llr for systematic symbol
				gamma[j] += ( temp_output ==0)? 0: inz[ (temp_output -1)+ i*llr_height ];  //llr for parity symbol
				gamma[j] += alpha[ j/M_input ][i];
			}
			for (j= 0; j< max_states; j++)
				tempab[j] = -MAXLOG;
			for (j = 0; j< max_trellis; j++)
				tempab[trellis_end_state[j]] = ( *max_star[dec_type] )( tempab[ trellis_end_state[j]], gamma[j]);
            for (j = 1; j< max_states; j++)
			{
				tempab[j] = tempab[j] - tempab[0];
                if ( (stop_it == 1) &&  (((tempab[j] - alpha[j][i+1]) > ABS_ERR ) || ((alpha[j][i+1] - tempab[j]) > ABS_ERR ) ) )
		 		   stop_it = 0;
				alpha[ j][i+1] = tempab[ j];
			}
			alpha[0][i+1] = 0;
            if ((stop_it == 1) && ( cycles > 0))
				break;
						
		}


		if ((stop_it == 1) && ( cycles > 0))
     		break;
		else
		{
			for (j= 0; j<max_states; j++)
				alpha[j][0] = alpha[j][len];
		}
		cycles++;
	}

	// find output vectors

    for (i = 0; i< len; i++)
	{
        for (j = 0; j< max_trellis; j++)
		{
		   	temp_input = j%M_input;
			temp_output = trellis_out[j];
			gamma[j] = ( temp_input ==0)? 0: inx[ (temp_input -1)+ i*llr_height ];   //llr for systematic symbol
			gamma[j] += ( temp_output ==0)? 0: inz[ (temp_output -1)+ i*llr_height ];  //llr for parity symbol
			gamma[j] += alpha[ j/M_input ][i]+ beta[ trellis_end_state[j] ][i+1];
		}
        // output for systematic symbols
		for (j =0; j< M_input; j++)
			temp_llrout[j] = -MAXLOG;
		for (j = 0; j< max_trellis; j++)
			temp_llrout[j%M_input] = ( *max_star[dec_type] )( temp_llrout[j%M_input], gamma[j]);
		for (j = 1; j< M_input; j++)
			outx[ (j-1) + i*llr_height] = temp_llrout[j] - temp_llrout[0];
	    soft_bits[ i*m_input] = ( *max_star[dec_type] )( temp_llrout[2],temp_llrout[3]) -  ( *max_star[dec_type] )( temp_llrout[0],temp_llrout[1]);
        soft_bits[ i*m_input+1] = ( *max_star[dec_type] )( temp_llrout[1],temp_llrout[3]) -  ( *max_star[dec_type] )( temp_llrout[0],temp_llrout[2]);
        
		for (j =0; j< M_input; j++)
			temp_llrout[j] = -MAXLOG;
		for (j = 0; j< max_trellis; j++)
			temp_llrout[ trellis_out[j] ] = ( *max_star[dec_type] )( temp_llrout[ trellis_out[j] ], gamma[j]);
		for (j = 1; j< M_input; j++)
			outz[ (j-1) + i*llr_height] = temp_llrout[j] - temp_llrout[0];
	}


	for ( i = 0; i < max_states; i++)
	{
		free(alpha[i]);
		free(beta[i]);
	}	
	free( alpha);
	free( beta);
	free( gamma);
	free( tempab);
    free( temp_llrout);

}




// find the trellis for doubinary crsc code:
// int_gen is the generator vector in binary form
// M_poly is the number of the vectors
// trellis_end_state, trellis_out are both 32 by 1 vectors, 
// The i th element of trellis_end_state is the end state of the starting state floor(i/4) with input i%4,
// The i th element of trellis_out is the output of the starting state floor(i/4) with input i%4,

void find_Duobinary_trellis( int *trellis_end_state, int* trellis_out, int *int_gen, int M_poly)
{
	int start_state = 0, end_state = 0;
	int i, j, A, B, gen =5, temp;  // feedback = [1 1 0 1], removing the feedback node, we have gen = 5.
	for (i= 0; i< 32; i++)
	{
		start_state = i/4;
		A = ( (i>>1)& 1 );
		B =  i & 1;
		temp = ( parity_counter( (start_state & gen), 3) ^ A);
		end_state = (temp^B)<<2;
		temp = ((start_state>>2) & 1);
		end_state += (temp ^B)<<1;
		temp = ((start_state>>1) & 1);
		end_state += (temp ^B);
        trellis_end_state[i] = end_state;

	    temp = ((end_state & 4)<<1) + start_state;
		trellis_out[i] = 0;
	    for (j = 0; j< M_poly; j++)
		    trellis_out[i] +=  parity_counter( (temp & int_gen[j] ), 4) << (M_poly-1-j);
    }
}



/* Gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
  int     len,dec_type, M_poly, N_poly, i,j;
  int *int_gen, trellis_end_state[32], *trellis_out[32];     
  double *inx, *inz, *outx, *outz, *poly_vec,  *soft_bits;

  float *inx_float, *inz_float, *outx_float, *outz_float, *soft_float;
  if ( (nrhs!=4) || (nlhs>3) )
    mexErrMsgTxt(" [outx, outz, soft_bits]= DuobinaryCRSCDecode( inx, inz, poly, dec_type)");
    
  inx=mxGetPr(prhs[0]);                         // systematic couples input (couples for duo RSC)  in GF(4)
  inz=mxGetPr(prhs[1]);                         // parity couples input
  poly_vec=mxGetPr(prhs[2]);                         // polynomials
  dec_type=*(mxGetPr(prhs[3]));                
  
  if ( ( mxGetM(prhs[0])!= 3) ||( mxGetM(prhs[1]) !=3) )
	  mexErrMsgTxt(" The input llrs should have 3*N form");
  len = mxGetN( prhs[0]);
  if (mxGetN(prhs[1]) != len)
	  mexErrMsgTxt(" The systematic llrs and parity llrs should have the same length");
  
  M_poly = mxGetM( prhs[2]);
  N_poly = mxGetN( prhs[2]);
  
  if ( (M_poly != 2) || (N_poly != 4) ) 
	  mexErrMsgTxt(" Parity generator has two polynomials. Each has 4 elements"); 
  
  int_gen = malloc( sizeof(int)* M_poly);
  
  for (i =0; i < M_poly; i++)
  {
	  int_gen[i] = 0;
	  for (j = 0; j<N_poly; j++)
		  int_gen[i] += ( ((int)poly_vec[i+j*M_poly]) & 1 ) << (N_poly-1-j);
  }
  
  find_Duobinary_trellis( trellis_end_state, trellis_out, int_gen, M_poly);  // find the end state of the trellis, and the output associated with the polynomials.
  
//  for (i = 0; i< 32; i++)
 //   printf( " starting: %d, input %d, ending %d, output %d\n", i/4, i%4, trellis_end_state[i], trellis_out[i]);
  free( int_gen);
  
  inx_float = malloc(sizeof(int) * 3*len);
  inz_float = malloc(sizeof(int) * 3*len);
  outx_float = malloc(sizeof(int) * 3*len);
  outz_float = malloc(sizeof(int) * 3*len);
  soft_float = malloc(sizeof(int) * 2*len);
  
  for (i = 0; i<3*len; i++)
  {
	  inx_float[i] = (float) inx[i];
      inz_float[i] = (float) inz[i];
  }

  Duobinary_SISO_wtrellis( inx_float, inz_float, outx_float , outz_float, soft_float, len, trellis_end_state, trellis_out ,dec_type);

    
  plhs[0]=mxCreateDoubleMatrix(3, len, mxREAL);
  plhs[1]=mxCreateDoubleMatrix(3, len, mxREAL);
  plhs[2]=mxCreateDoubleMatrix(2, len, mxREAL);
  outx = mxGetPr(plhs[0]);
  outz = mxGetPr(plhs[1]);
  soft_bits = mxGetPr( plhs[2]);

  for (i = 0; i< 3*len; i++)
  {
	  outx[i] = (double) outx_float[i];
      outz[i] = (double) outz_float[i];
  }
  
  for (i = 0;i<2*len; i++)
	  soft_bits[i] = (double) soft_float[i];

  free( inx_float);
  free( inz_float);
  free( outx_float);
  free( outz_float);
  free( soft_float);

  

}
