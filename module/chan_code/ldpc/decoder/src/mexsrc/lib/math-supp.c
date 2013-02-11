/* math-supp.c

   Description: Implementation of supporting mathematical functions
                 for LDPC mex functions.
  
   Copyright (C) 2012, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti

   Last updated on 11/14/2012
*/


#include <math.h>
#include "math-supp.h"

float phi0( float x ) {
    float z;
    
    if (x>10)
        return( 0 );
    else if (x< 9.08e-5 )
        return( 10 );
    else if (x > 9)
        return( 1.6881e-4 );
    /* return( 1.4970e-004 ); */
    else if (x > 8)
        return( 4.5887e-4 );
    /* return( 4.0694e-004 ); */
    else if (x > 7)
        return( 1.2473e-3 );
    /* return( 1.1062e-003 ); */
    else if (x > 6)
        return( 3.3906e-3 );
    /* return( 3.0069e-003 ); */
    else if (x > 5)
        return( 9.2168e-3 );
    /* return( 8.1736e-003 ); */
    else {
        z = (float) exp(x);
        return( (float) log( (z+1)/(z-1) ) );
    }
}



/*
   Library math-supp is part of the Iterative Solutions 
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