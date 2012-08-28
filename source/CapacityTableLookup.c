/* CapacityTableLookup returns the instantaneous capacity for a particular
   channel realization by using a precalculated AWGN capacity table.
   Since the table does not generally contain capacity values for the exact
   SNR, linear interpolation is used to estimate the value.

   The calling syntax is:
       cap = CapacityTableLoookup( EsNo_AWGN, capacity_AWGN, slope, gamma )

       Outputs:
       cap = The instantaneous capacity, a column vector with same number of
       rows as gamma.
 
       EsNo_AWGN = The SNR values stored in the table
       capacity_AWGN = The AWGN capacity values stored in the table.
       slope = The slope of the AWGN capacity curve.
       gamma = The instantaneous SNRs for the channel realization.
               Each row correpsonds to a distinct codeword,
               And the columns correspond to the blocks of that codeword.

   Copyright (C) 2005, Matthew C. Valenti

   Last updated on Dec. 25, 2005

   Function CapacityTableLookup is part of the Iterative Solutions 
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

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{
	/* declare variables */
	double *SNR_table, *capacity_table, *slope, *gamma, *output_p;
	int table_entries, trial_size, blocks, i, j, index_below;
	double max_SNR, min_SNR, max_cap, this_gamma, cap;


	/* Check for proper number of arguments */
	if ((nrhs < 4 )||(nlhs  > 1)) {
		mexErrMsgTxt("Usage: cap = CapacityTableLoookup( EsNo_AWGN, capacity_AWGN, slope, gamma )");
	} 		
	
	/* first input is the SNR values in the table */
	SNR_table = mxGetPr( prhs[0] );
	table_entries = mxGetN( prhs[0] );

	/* second input is the capacity values in the table */
	capacity_table = mxGetPr( prhs[1] );
	if ( mxGetN( prhs[1] ) != table_entries )
		mexErrMsgTxt( "Table sizes don't match" );

	/* third input is the slope */
	slope = mxGetPr( prhs[2] );
	if ( mxGetN( prhs[2] ) != table_entries-1 )
		mexErrMsgTxt( "slope vector is wrong size" );

	/* fourth input is the snr values */
	gamma = mxGetPr( prhs[3] );
	trial_size = mxGetM( prhs[3] );
	blocks = mxGetN( prhs[3] );

	/* create output */
	plhs[0] = mxCreateDoubleMatrix( trial_size, 1, mxREAL );
	output_p = mxGetPr( plhs[0] );

	/* determine minimum and maximum values */
	min_SNR = SNR_table[0];
	max_SNR = SNR_table[table_entries-1];
	max_cap = capacity_table[table_entries-1];

	for (j=0;j<trial_size;j++) {
		cap = 0;
		for (i=0;i<blocks;i++) {
			this_gamma = gamma[j+i*trial_size];
			/*printf( "Gamma = %f\n", this_gamma ); */
			if ( this_gamma >= max_SNR ) {
				cap += max_cap;
			} else if ( this_gamma > min_SNR ) {
				/* need to interpolate */
				index_below = 0;
				while ( SNR_table[index_below] < this_gamma )
					index_below++;
				index_below--;
				cap += capacity_table[index_below] + slope[index_below]*( this_gamma - SNR_table[index_below] );
			}
		}
		output_p[j] = cap;
	}		

	return;
}
