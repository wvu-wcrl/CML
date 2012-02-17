/* File: srandom.h

   Description: Creates an S-random interleaver

   The calling syntax is:
      CreateSRandomInterleaver( int N, int S, int *alpha )

   Where:
		N         = The size of the interleaver
		S         = The S-parameter.  The design insures that adjacent bits
		            at the input to the interleaver are mapped to positions
			        that are at least distance S apart
	    alpha     = array containing the interleaver indices   
	  
   Note, adjust parameter max_swaps to tradeoff between performance and run-time.

   Copyright (C) 2005-2006, Matthew C. Valenti and Yufei Wu

   Last updated on Jan. 11, 2006

   Function CreateSRandomInterleaver, ran2, and genrand 
   are part of the Iterative Solutions Coded Modulation Library
   The Iterative Solutions Coded Modulation Library is free software;
   you can redistribute it and/or modify it under the terms of 
   the GNU Lesser General Public License as published by the 
   Free Software Foundation; either version 2.1 of the License, 
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
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/types.h>

#define TRUE 	1
#define FALSE	0

#define IM1 (2147483563)
#define IM2 (2147483399)
#define AM	(1.0/IM1)
#define IMM1	(IM1-1)
#define IA1	(40014)
#define IA2	(40692)
#define IQ1	(53668)
#define IQ2 (52774)
#define IR1 (12211)
#define IR2 (3791)
#define NTAB 	(32)
#define NDIV	(1+IMM1/NTAB)
#define EPS	(1.2e-7)
#define RNMX (1.0-EPS)

/**************************/
static int first = 1;	/* True = 1 */
/**************************/

double ran2(long *idum)
/* Generate random number between 0 and 1 
(not including 0 or 1) */
{
	int j;
   long k;
   static long idum2 = 123456789;
   static long iy = 0;
   static long iv[NTAB];
   double temp;

   /****************************/
   if(first) {
	   idum2 = 123456789;
		iy = 0;
		for(j=0;j<NTAB;j++) iv[j] = 0;
   }
   /****************************/

   if( *idum <= 0 ){
   	if( -(*idum)<1 ) *idum = 1;
      else *idum = -(*idum);
      idum2 = (*idum);
      for(j=NTAB+7;j>=0;j--) {
      	k = (*idum)/IQ1;
         *idum = IA1*(*idum-k*IQ1) - k*IR1;
         if(*idum<0) *idum+=IM1;
         if(j<NTAB) iv[j] = *idum;
      }
      iy = iv[0];
   }
   k = (*idum)/IQ1;
   *idum = IA1*(*idum-k*IQ1)-k*IR1;
   if(*idum<0)	*idum += IM1;
   k = idum2/IQ2;
   idum2 = IA2*(idum2-k*IQ2)-k*IR2;
   if (idum2<0) idum2 += IM2;
   j = (int)(iy/NDIV);
   iy = iv[j] - idum2;
   iv[j] = *idum;
   if (iy<1) iy += IMM1;
   if((temp = AM*iy) > RNMX) return(RNMX);
   else return (temp);
}

double genrand()
/* THIS SUBROUTINE GENERATES A RANDOM NUMBER UNIFORMLY DISTRIBUTED BETWEEN 0 AND 1 */
{
	double noise;
   static long idum;
   /* INITIALIZE THE RANDOM NUMBER GENERATOR WITH THE LOCAL TIME */
   if(first){
     	time_t t1;
      struct tm *tmptr;
      t1 = time((time_t *) 0);
      tmptr = localtime(&t1);
      idum = -(tmptr->tm_mon + tmptr->tm_mday + tmptr->tm_hour + tmptr->tm_min + tmptr->tm_sec);
      ran2(&idum);
      first = FALSE;
   }

   noise = ran2(&idum);

   return(noise);
}

void CreateSRandomInterleaver( 
		int N, /* size of interleaver */
		int S, /* S-random parameter */
		int *alpha )
{
	int spacing, i, offset, index, block;
	int max_swaps, num_swaps;
	int index_1, index_2, value_1, value_2, test, start, stop;
	
	max_swaps= 10*N;
	num_swaps = 0;
	/* determine initial spacing */
	spacing = floor( sqrt( N ) );
	/* printf( "Spacing = %d\n", spacing ); */

	/* create the initial interleaver */
	offset = 0;
	block = 0;
	for (i=0;i<N;i++) {
		index = spacing*offset + block;
		if (index >= N) {
			offset = 0;
			block++;
		}
		alpha[i] = spacing*offset + block;
		offset++;
	}

	/* now start swapping positions */
	while (num_swaps < max_swaps ) {
		/* pick two positions at random */
		index_1 = (int)floor( N * genrand() );
		index_2 = (int)floor( N * genrand() );
		
		/* try again if they are the same */
		if (index_1 != index_2){
			test = 1;
			/* first test */
			value_1 = alpha[index_2];
				
			if (index_1 < S)			
				start = 0;
			else
				start = index_1 - S;
			if (index_1 >= N - S)
				stop = N;
			else
				stop = index_1 + S;
		
			for ( i=start;i<stop;i++ ) {			
				if (abs( value_1 - alpha[i] ) < S) {				
					test = 0;						
					break;
				}
			}
			if ( test ) {
				/* second test */
				value_2 = alpha[index_1];

				if (index_2 < S)					
					start = 0;
				else			
					start = index_2 - S;
				if (index_2 >= N - S)
					stop = N;
				else
					stop = index_2 + S;
		
				for ( i=start;i<stop;i++ ) {
					if (abs( value_2 - alpha[i] ) < S) {
						test = 0;			
						break;
					}
				}
				if (test) {		
					/* passed both tests: swap */
					/* printf( "Swapping alpha[%d] = %d with alpha[%d] = %d\n", index_1, value_2, index_2, value_1 ); */
					alpha[index_1] = value_1;
					alpha[index_2] = value_2;
					num_swaps++;
				}
			}
		}
	}
}

		


