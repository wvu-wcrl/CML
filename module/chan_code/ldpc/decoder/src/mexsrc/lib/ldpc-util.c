/* ldpc-util.c

   Description: Implementation of supporting functions for LDPC
                 decoder mex functions.  

   Copyright (C) 2012, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti

   Last updated on 11/14/2012
*/


#include <mex.h>
#include <matrix.h>
#include "ldpc-util.h"

/* assign v-node MATLAB structure pointers to C structure pointers */
void GetVnPtrs( int CodeLength, const mxArray *v_nodes_mx, v_node *v_nodes )
{
    int i;
    
    for(i=0; i< CodeLength; i++){
        v_nodes[i].degree = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 0) );
        v_nodes[i].initial_value = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 1) );
        v_nodes[i].index = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 2) );
        v_nodes[i].socket = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 3) );
        v_nodes[i].message = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 4) );
        v_nodes[i].sign = mxGetData( mxGetFieldByNumber(v_nodes_mx, i, 5) );
    }
    
}

/* assign c-node MATLAB structure pointers to C structure pointers */
void GetCnPtrs( int NumberParityBits, const mxArray *c_nodes_mx, c_node *c_nodes )
{
    int i;
    
    for(i=0; i< NumberParityBits; i++){
        c_nodes[i].degree = mxGetData( mxGetFieldByNumber(c_nodes_mx, i, 0) );
        c_nodes[i].index = mxGetData( mxGetFieldByNumber(c_nodes_mx, i, 1) );
        c_nodes[i].message = mxGetData( mxGetFieldByNumber(c_nodes_mx, i, 2) );
        c_nodes[i].socket = mxGetData( mxGetFieldByNumber(c_nodes_mx, i, 3) );
    }
    
}



/*
   Library ldpc-util is part of the Iterative Solutions 
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
