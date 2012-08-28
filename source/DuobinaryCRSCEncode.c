/* file: DuobinaryCRSCEncode.c

   Description: Convolutionally encode using a duobinary tailbiting
                convolutional code.

   The calling syntax is:

      [outz,Sc] = DuobinaryCRSCEncode(x, poly)

   Inputs:
       x    = the input couples
       poly = polynomials for parity bits, 
              use [1 0 1 1; 1 0 0 1] for DVB and Wimax CTC Code, 
              note that the feedback vector is [1 1 0 1] by default.
 
   Outputs:
       outz = output parity bits
       Sc   = circular state 

   Copyright (C) 2005-2007, Matthew C. Valenti and Shi Cheng

   Last updated on Oct. 12, 2007

   Function DuobinaryCRSCEncode is part of the Iterative Solutions 
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
// #include ".\include\turbo.h"

int find_circular_state( double *x, int len)
{
  // Circular_state Matrix
  int Matrix_Sc[6][8] = { {0, 6, 4, 2, 7, 1, 3, 5}, {0, 3, 7, 4, 5, 6, 2, 1}, {0, 5, 3, 6, 2, 7, 1, 4}, {0, 4, 1, 5, 6, 2, 7, 3}, {0, 2, 5, 7, 1, 3, 4, 6}, {0, 7, 6, 1, 3, 4, 5, 2}};
  int temp = 0, A, B;
  int gen = 5; // feedback = [1 1 0 1], removing the feedback node, we have gen = 5.
  
  int state = 0, newstate = 0, i = 0;
  for ( i = 0; i< len; i++)
  {
	  A = (int)x[ 2*i] & 1;
	  B = (int)x[ 2*i+1 ] & 1;
	  temp = ( parity_counter( (state & gen), 3) ^ A);
      newstate = (temp^B)<< 2;
	  temp = ((state>>2) & 1);
	  newstate += (temp ^B)<<1;
	  temp = ((state>>1) & 1);
	  newstate += (temp ^B);

	  state = newstate;
  }
  return ( Matrix_Sc[len%7-1][state]);
}

void Duobinary_Encode_wSc( double *x, double *z, int len, int *int_gen, int M_poly, int Sc)
{
  int temp = 0, A, B;
  int gen = 5; // feedback = [1 1 0 1], removing the feedback node, we have gen = 5.
  
  int state = Sc, newstate = 0, i = 0, j = 0;
  for ( i = 0; i< len; i++)
  {
	  A = (int)x[ 2*i] & 1;
	  B = (int)x[ 2*i+1 ] & 1;
	  temp = ( parity_counter( (state & gen), 3) ^ A);
      newstate = (temp^B)<< 2;
	  temp = ((state>>2) & 1);
	  newstate += (temp ^B)<<1;
	  temp = ((state>>1) & 1);
	  newstate += (temp ^B);
      
	  temp = ((newstate & 4)<<1) + state;
	  for (j = 0; j< M_poly; j++)
		  z[ M_poly*i + j ] =  parity_counter( (temp & int_gen[j] ), 4);
	  state = newstate;
  }


}



/* Gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
  int     len,  N, M_poly, N_poly, Sc;
  double *srcx,  *poly_vec, *codoutz;
  double *oct_vec;
  int *int_gen;
  int i, j;
  if ( (nrhs!=2) || (nlhs > 2) )
      mexErrMsgTxt(" Usage: [outz,Sc]= DuobinaryCRSCEncode(x, poly);");

  srcx=mxGetPr(prhs[0]);
  poly_vec=mxGetPr(prhs[1]);
  M_poly = mxGetM( prhs[1]);
  N_poly = mxGetN( prhs[1]);

  if ( (M_poly != 2) || (N_poly != 4) ) 
	  mexErrMsgTxt(" Parity generator has two polynomials. Each has 4 elements"); 
  N = mxGetM( prhs[0]) * mxGetN(prhs[0] );
  len = N/2;
  if ( N != 2*len)
	  mexErrMsgTxt(" Input must have even length. ");
  
  int_gen = malloc( sizeof(int)* M_poly);
  
  plhs[0]=mxCreateDoubleMatrix(2, len, mxREAL);
  plhs[1]=mxCreateDoubleMatrix(1,1,mxREAL);
  
  Sc = find_circular_state( srcx, len);
  *( mxGetPr(plhs[1]) ) = Sc;
  codoutz = mxGetPr( plhs[0]);
  //printf("%d", Sc);
  for (i =0; i < M_poly; i++)
  {
	  int_gen[i] = 0;
	  for (j = 0; j<N_poly; j++)
		  int_gen[i] += ( ((int)poly_vec[i+j*M_poly]) & 1 ) << (N_poly-1-j);
//	  printf("int_gen  %d\n", int_gen[i]);
  }
  
  Duobinary_Encode_wSc( srcx, codoutz, len, int_gen, M_poly, Sc);
  

  free( int_gen, len);


}