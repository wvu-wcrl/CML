/* Iterate_mx.c

   Description: Perform a single iteration of LDPC decoding.

   The calling syntax is:
    [output_decoder_c detected_data] = 
        Iterate_mx( input_decoder_c, v_nodes, c_nodes, NumberParityBits )
  
   Where:
      output_decoder_c = vector of bit log-likelihoods resulting from decoding
      detected_data    = vector of data bits decoded in this iteration
  
      input_decoder_c  = vector of bit log-likelihoods from SOMAP
	  v_nodes          = Tanner Graph variable nodes
      c_nodes          = Tanner Graph check nodes
      NumberParityBits = Number of parity bits per codeword

   Copyright (C) 2012, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti

   Last updated on 11/14/2012
*/



#include <math.h>
#include <mex.h>
#include <matrix.h>
#include <stdlib.h>
#include "ldpc-util.h"
#include "math-supp.h"


/* primary decoding function */
static void SumProduct(
        double input_decoder_c[],  /* inputs */
        c_node c_nodes[],
        v_node v_nodes[],
        int	  CodeLength,
        int	  NumberParityBits,
        
        int    DecodedBits[],	   /* outputs */
        double *output_decoder_c) {
    
    int i, j;
    float phi_sum;
    int sign;
    float temp_sum;
    double *Qi_cur;
    float Qi_new;
    
    
    /* update r */
    for (j=0;j<NumberParityBits;j++) {
        sign = v_nodes[ c_nodes[j].index[0] ].sign[ c_nodes[j].socket[0] ];
        phi_sum = v_nodes[ c_nodes[j].index[0] ].message[ c_nodes[j].socket[0] ];
        
        for (i=1;i<*c_nodes[j].degree;i++) {
            phi_sum += v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ];
            sign ^= v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ];
        }
        
        for (i=0;i<*c_nodes[j].degree;i++) {
            if ( sign^v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ] ) {
                c_nodes[j].message[i] = -phi0( phi_sum - v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] );
            } else
                c_nodes[j].message[i] = phi0( phi_sum - v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] );
        }
    }    
    
    
    /* update q  */
    for (i=0;i<CodeLength;i++) {        
        Qi_new = 0;
        for (j=0;j<*v_nodes[i].degree;j++) {
            Qi_new += c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
        }        
        
        output_decoder_c[i] =  input_decoder_c[i] - Qi_new ;   /* ext llr out of decoder */        
        
        if (output_decoder_c[i] > 0)
            DecodedBits[i] = 1;
        else
            DecodedBits[i] = 0;
    }
    
    
    /* now subtract to get the extrinsic information */
    for (i=0;i<CodeLength;i++) {
        for (j=0;j<*v_nodes[i].degree;j++) {
            temp_sum = -output_decoder_c[i]  - c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
            v_nodes[i].message[j] = phi0( fabs( temp_sum ) );
            
            if (temp_sum > 0)
                v_nodes[i].sign[j] = 0;
            else
                v_nodes[i].sign[j] = 1;
        }
    }
    
}



void mexFunction(int     nlhs,
        mxArray *plhs[],
        int     nrhs,
        const mxArray *prhs[])
{
    const mxArray *v_nodes_mx;
    const mxArray *c_nodes_mx;
    double *input_decoder_c;
    int    CodeLength;
    double *NumberParityBitsIn;
    int    NumberParityBits;
    
    c_node *c_nodes;
    v_node *v_nodes;
    
    int    *DecodedBits;
    double *DecodedBitsOut;
    double *output_decoder_c;
    
    int i;
    
    
    input_decoder_c = mxGetPr( prhs[0] );       /* process inputs */
    CodeLength  = mxGetN ( prhs[0] );
    v_nodes_mx = prhs[1];
    c_nodes_mx = prhs[2];
    NumberParityBitsIn = mxGetPr(prhs[3]);
    NumberParityBits = (int) *NumberParityBitsIn;
    
    
    v_nodes = calloc( CodeLength, sizeof(v_node) );      /* assign mx structs to c structs */
    GetVnPtrs( CodeLength, v_nodes_mx, v_nodes );
    c_nodes = calloc( NumberParityBits, sizeof(c_node) );
    GetCnPtrs( NumberParityBits, c_nodes_mx, c_nodes );
    
    
    plhs[0] = mxCreateDoubleMatrix(1, CodeLength, mxREAL);  /* prepare llr outputs */
    output_decoder_c = mxGetPr(plhs[0]);
    
    DecodedBits = calloc( CodeLength, sizeof( int ) );     /* perform decoding */
    SumProduct( input_decoder_c, c_nodes, v_nodes,
            CodeLength, NumberParityBits, DecodedBits,
            output_decoder_c);
    
    
    plhs[1] = mxCreateDoubleMatrix(1, CodeLength, mxREAL);  /* assign decoded bits to output */
    DecodedBitsOut = mxGetPr( plhs[1] );
    for(i = 0; i < CodeLength; i++)
        DecodedBitsOut[i] = DecodedBits[i];
    
    
    free( DecodedBits );       /* free memory */
    free( c_nodes );
    free( v_nodes );
    return;
}




/*
   Function Iterate_mx is part of the Iterative Solutions 
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
