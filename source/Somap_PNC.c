/* File: Somap_PNC.c

   Description: Computes network-coded bits using received symbol log-likelihoods and extrinsic information
                from decoder

   The calling syntax is:
   [output] = Somap_PNC( sym_lh, mod_order, demod_type, extrinsic_info )

   Where:
   output  = updated extrinsic information for network coded bits

   input   =
   1   sym_lh          symbol likelihoods. see [1] in Demod_PNC_FSK.c for details
   2   mod_order       modulation order
   3   demod_type      0-4, specifies max-star implementation
   4   extrinsic_info  extrinsic information from decoder

   Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti

   Last updated on June 1, 2012


*/




#include <mex.h>    /* required matlab include for c-mex */
#include <stdio.h>
#include <math.h>

#include "./include/maxstar.h"




double* read_symbol_likelihoods(const mxArray *prhs){
  /* only required input is M-ary symbols for conversion and modulation order */
  double *sll;
  sll = mxGetPr(prhs);	
}


int read_symbol_likelihood_length( const mxArray *prhs, int M ){
  int L;
  
  L = mxGetN(prhs)/(M*M);  /* number of symbols */
  /* dimensionality of input is M*M*N */
  /* see Demod_PNC_FSK.c [1] for details */
  return L;
}



int read_modulation_order(const mxArray *prhs){
  int M;
  M   = (int)*mxGetPr(prhs);	      
  return M;
}


int read_demod_type( const mxArray *prhs ){
  int demod_type;
  demod_type = (int) *mxGetPr( prhs );
  
  if ( (demod_type < 0)||(demod_type > 4) )
    mexErrMsgTxt("demod_type must be be 0 through 4");
  return demod_type;      
}


int read_extrinsic_info_length( const mxArray *prhs ){
  int N_e;
  N_e = mxGetN(prhs);
  return N_e;
}		



float * read_extrinsic_info( const mxArray *prhs, int N, int N_e ){
  int k;
  double* ei_in;
  float* ei;


  
  if ( N_e > N )
    mexErrMsgTxt("Too many a prior LLR inputs");
  
  ei_in = mxGetPr(prhs);

  ei = calloc( N, sizeof(float) );  /* llr input defaults to all-zeros */
  
  for ( k=0; k < N_e; k++ ) 
    ei[k] = (float) ei_in[k];		
  
  return ei;
}



int compute_total_number_of_bits( int L, int m ){
  int N;
  N = m*L; /* total number of bits */
  return N;
}



/* return bits per symbol given modulation order */
int compute_bits_per_symbol(int M){
  int m;
  int temp_int;

  m = 0;
  temp_int = M;
  while (temp_int>1) {
    temp_int = temp_int/2;
    m++;
  }
  return m;
}



void allocate_temporary_memory( float** den, float** num, float **sll_supp, int M, int m ){
  *den = calloc( m, sizeof(float) );
  *num = calloc( m, sizeof(float) );
  *sll_supp = calloc( M*M, sizeof(float) ); /* temporary variable storing max-star metrics */
}





/* given indicies into symbol matrix, generate appropriate nc bits 
 * assuming natural mapping
 */
int gen_nc_bits(int i, int j){
  return i^j;
}



/* compute extrinsic info for this symbol */
float compute_extrinsic_info(float *ei, int nc_bits, int s, int m){
  float ei_tmp;
  int g;
  int mask2;

  ei_tmp = 0;

  for( g = 0; g < m; g++ ){
    mask2 = (nc_bits >> g)&1;
    ei_tmp = ei_tmp + mask2 * ei[s*m + m-(g+1)];
  }
  return ei_tmp;
}
















void mexFunction(
		 int            nlhs,
		 mxArray       *plhs[],
		 int            nrhs,
		 const mxArray *prhs[] )
{

  /***** inputs ****/
  double  *sll;             /* symbol log-likelihood */
  int     M;                /* modulation order */
  int     demod_type;       /* max star implementation to use, 0-4 */


  /**** derived parameters ****/
  int     L;                 /* number of symbols */
  int     m;                 /* bits per symbol */
  int     N;                 /* codeword length */
  int     N_e;               /* number of extrinsic information llrs */
  float   *ei;               /* extrinsic info */

  
  /**** outputs ****/
  double  *output_p;   /* updated extrinsic llrs */


  /* iterators */
  int i, j, k, s, g, o;


  /**** temporary variables ****/
  float *sll_supp;
  float ei_tmp;
  float metric_tmp;
  float *den, *num;
  int nc_bits, mask, mask2;




  /* put the different max_star functions into array so easy to call */
  float (*max_star[])(float, float) =
    { 
      max_star0, max_star1, max_star2, max_star3, max_star4
    };



  /** Read inputs: M-ary symbol probablities and modulation order **/
  if ( nrhs == 0 ) 
    mexErrMsgTxt("Usage: [bit_llr] = Somap_PNC( [sym_log_likelihood], [mod_order],  [demod_type], [extrinsic_info] )");

  if ( nrhs == 1 ) 
    mexErrMsgTxt("Usage: [bit_llr] = Somap_PNC( [sym_log_likelihood], [mod_order],  [demod_type], [extrinsic_info] )"); 	

  if ( nrhs > 1 ) {
    sll         = read_symbol_likelihoods( prhs[0] );
    M           = read_modulation_order( prhs[1] );
    L           = read_symbol_likelihood_length( prhs[0], M );
    m           = compute_bits_per_symbol(M);
    N           = compute_total_number_of_bits( L, m );
  } 	

  if ( nrhs > 2 ) 
    demod_type  = read_demod_type( prhs[2] );

  if ( nrhs > 3 ) {
    N_e = read_extrinsic_info_length( prhs[3] );
    ei = read_extrinsic_info( prhs[3], N, N_e );
  }

  
  /* temporary variable memory */
  allocate_temporary_memory( &den, &num, &sll_supp, M, m );

  
  /* prepare output  pointer */
  plhs[0] = mxCreateDoubleMatrix(1, N, mxREAL );
  output_p = mxGetPr(plhs[0]);	



  
  /* primary computation loop */			
  for ( s=0; s < L; s++) { 
    for (k=0; k < m; k++) {		
      num[k] = -1000000;	 
      den[k] = -1000000;			
    }
      for(i = 0; i < M; i++){
	for(j = 0; j < M; j++){
	  nc_bits = gen_nc_bits(i,j);
	  ei_tmp = compute_extrinsic_info(ei, nc_bits, s, m);
	  sll_supp[i*M + j] = sll[s*M*M + i*M + j] + ei_tmp;
	}
      }  
    for(k = 0; k < m; k++){
      mask = 1 << (m-k-1);
      for(i = 0; i < M; i++){
	for(j = 0; j < M; j++){
	  nc_bits = gen_nc_bits(i,j);
	  if( (mask & nc_bits) > 0 ){
	    metric_tmp = sll_supp[ i*M + j ] - ei[s*m + k];
	    num[k] = ( *max_star[demod_type] )( num[k], metric_tmp );
	  }
	  if( (mask & nc_bits) == 0 ){
	    metric_tmp = sll_supp[i*M + j];
	    den[k] = ( *max_star[demod_type] )( den[k], metric_tmp );
	  }
	}
      }
    }
    for ( k=0 ; k < m ; k++) {
      output_p[s*m+k] = num[k] - den[k];
    }
  }
  


  /* free memory */
  free( den );
  free( num );
  free( sll_supp );
  
  if( nrhs > 3 )
    free( ei );


  return;
}
