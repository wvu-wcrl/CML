/* InitState_mx.c

   Description: Initializes Tanner Graph state prior to first decoding
                iteration for a received codeword.

   The calling syntax is:
      InitState_mx( input_decoder_c, row_one, col_one, 
                    v_nodes, c_nodes, NumberParityBits);
  
   Where:
      input_decoder_c  = vector of bit log-likelihoods from SOMAP
	  row_one          = 
	  col_one          = 
	  v_nodes          = Tanner Graph variable nodes
      c_nodes          = Tanner Graph check nodes
      NumberParityBits = Number of parity bits per codeword

   Copyright (C) 2012, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti

   Last updated on 11/14/2012
*/


#include <stdlib.h>
#include <mex.h>
#include <matrix.h>
#include <math.h>
#include "ldpc-util.h"
#include "math-supp.h"


/* set c-node indices */
void SetCnInd( c_node *c_nodes, int NumberParityBits, double *row_one )
{
    int i, j;
    for (i=0;i<NumberParityBits;i++) {
        for (j=0;j<*c_nodes[i].degree;j++){
            c_nodes[i].index[j] = (int) (row_one[i+j*NumberParityBits]);
        }
    }
}


/* set v-node state */
void SetVnSt( v_node *v_nodes, c_node * c_nodes,
        int CodeLength, double *col_one,
        int NumberCodeBits, double *input_decoder_c)
{
    int i, j;
    int c_index;
    
    for (i=0;i<CodeLength;i++) {
        
        *v_nodes[i].initial_value = input_decoder_c[i];
        for (j=0;j< *v_nodes[i].degree;j++) {
            
            v_nodes[i].index[j]=(int) (col_one[i+j*NumberCodeBits]);
            
            for (c_index=0;c_index<*c_nodes[ v_nodes[i].index[j] ].degree;c_index++)
                if ( c_nodes[ v_nodes[i].index[j] ].index[c_index] == i ) {
                v_nodes[i].socket[j] = c_index;
                break;
                }
            
            v_nodes[i].message[j] = phi0( fabs(input_decoder_c[i]) );
            
            if (input_decoder_c[i] < 0)
                v_nodes[i].sign[j] = 1;
            else
                v_nodes[i].sign[j] = 0;
        }
    }  
    
}


/* set c-node sockets */
void SetCnSock( c_node *c_nodes, v_node *v_nodes,
        int NumberParityBits )
{
    int i, j;
    int v_index;
    
    for (i=0;i<NumberParityBits;i++) {
        for (j=0;j<*c_nodes[i].degree;j++) {
            for (v_index=0; v_index < *v_nodes[ c_nodes[i].index[j] ].degree; v_index++)
                if (v_nodes[ c_nodes[i].index[j] ].index[v_index] == i ) {
                c_nodes[i].socket[j] = v_index;
                break;
                }
        }
    }
}


void mexFunction( int nlhs,
        mxArray *plhs[],
        int nrhs,
        const mxArray *prhs[])
{
    const mxArray *input_decoder_c_mx;      /* named MX pointers to inputs */
    const mxArray *row_one_mx;
    const mxArray *col_one_mx;
    const mxArray *v_nodes_mx;
    const mxArray *c_nodes_mx;
    
    double *input_decoder_c;                /* named C pointers to inputs */
    double *row_one;
    double *col_one;
    v_node *v_nodes;
    c_node *c_nodes;
    
    int CodeLength;                  /* derived parameters */
    int NumberParityBits;
    int NumberCodeBits;
    
    
    input_decoder_c_mx = prhs[0];           /* assign input pointers */
    row_one_mx = prhs[1];
    col_one_mx = prhs[2];
    v_nodes_mx = prhs[3];
    c_nodes_mx = prhs[4];
    
    
    input_decoder_c = mxGetPr( input_decoder_c_mx );  /* read inputs and derived params */
    CodeLength = mxGetN( input_decoder_c_mx );
    
    row_one = mxGetPr( row_one_mx );
    NumberParityBits = mxGetM( row_one_mx );
    
    col_one = mxGetPr( col_one_mx );
    NumberCodeBits   = mxGetM( col_one_mx );
    
    
    v_nodes = calloc( CodeLength, sizeof(v_node) );  /* assign mx structs to c structs */
    GetVnPtrs( CodeLength, v_nodes_mx, v_nodes );
    c_nodes = calloc( NumberParityBits, sizeof(c_node) );
    GetCnPtrs( NumberParityBits, c_nodes_mx, c_nodes );
    
    
    SetCnInd( c_nodes, NumberParityBits, row_one );    /* initialize tanner graph state */
    SetVnSt( v_nodes, c_nodes, CodeLength, col_one, NumberCodeBits, input_decoder_c );
    SetCnSock( c_nodes, v_nodes, NumberParityBits );
    
    
    free(v_nodes);                                           /* free allocated memory */
    free(c_nodes);
    
    return;
}



/*
   Function InitState_mx is part of the Iterative Solutions 
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
