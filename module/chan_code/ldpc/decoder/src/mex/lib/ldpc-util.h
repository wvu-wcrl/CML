/* ldpc-util.h

   Description: Defines supporting data structures and functions
                 for LDPC mex functions.

  
   Copyright (C) 2012, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti

   Last updated on 11/14/2012
*/

#ifndef LPDCUTIL_H
#define LDPCUTIL_H

typedef struct v_node {        /* tanner graph structure definitions */
    int *degree;
    float *initial_value;
    int *index;  /* the index of a c_node it is connected to */
    int *socket; /* socket number at the c_node */
    float *message;
    int *sign;
} v_node;

typedef struct c_node {
    int *degree;
    int *index;
    float *message;
    int *socket; /* socket number at the v_node */
} c_node;


void GetCnPtrs( int NumberParityBits, const mxArray *c_nodes_mx, c_node *c_nodes );
void GetVnPtrs( int CodeLength, const mxArray *v_nodes_mx, v_node *v_nodes );

#endif



/*
   Header ldpc-util is part of the Iterative Solutions 
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
