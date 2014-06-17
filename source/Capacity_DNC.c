/* File: Capacity_DNC.c

   Description: Computes capacity at relay in two-way relay channel using
   physical layer network coding.

   The calling syntax is:
   [capacity] = Capacity_DNC( sym_lh, mod_order, nc_bits )

   Where:
   capacity  = instaneous capacity for this frame

   inputs
   1   sym_lh          symbol likelihoods. see [1] in Demod_PNC_FSK.c for details
   logarithm assumed base e
   2   mod_order       modulation order
   3   nc_bits         network coded bits for this frame, used to reconstruct symbols


   Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti

   Last updated on July 22, 2012
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


double * read_nc_bits( const mxArray *prhs ){
  return mxGetPr( prhs );
}


double compute_hx(int M){
  return (double)log2(M);
}



int get_cur_nc_sym( double* nc_bits, int m, int k ){
  float cur_sym;
  int i;
  int exp;
  int ind_first, ind_last;

  /* compute index of first and last nc bit */
  ind_first = m*k;
  ind_last = m*k + (m-1);

  /* compute nc sym by the base 10 value of the bits */
  exp = (m-1);
  cur_sym = 0;
  for( i = ind_first; i <= ind_last; i++ ){
    cur_sym = cur_sym + nc_bits[i]*pow(2,exp);
    exp = exp - 1;
  }

  return (int)cur_sym;
}




void get_cur_logp( double * logp_nc_sym, double * sll, int nc_sym, int M, int k ){
  int i,j;


  for(i=0; i < M; i++){
    j = i^nc_sym;
    logp_nc_sym[i] = sll[k*M*M + i*M + j]; 
  }
}


double compute_recursive_maxstar( double* logp_vec, int vec_length){
  double msn;
  int i;


  msn = max_star4( logp_vec[0] , logp_vec[1] );
  for(i=2;i < vec_length;i++)
    msn = max_star4( msn, logp_vec[i] );

  return msn;
}


double compute_maxstar_numerator( double * sll, int M, int m, int L, double *nc_bits, double* logp_nc_sym, int k ){

  int nc_sym;
  double msn;

  int i;
  
  /* determine transmitted nc symbol */
  nc_sym = get_cur_nc_sym( nc_bits, m, k );

  /* extract log-probabilities based on the network-coded symbol */
  get_cur_logp( logp_nc_sym, sll, nc_sym, M, k );

  /* compute max-star */
  msn = compute_recursive_maxstar( logp_nc_sym, M );
  return msn;
}



void get_all_logp( double * logp_nc_sym, double * sll, int M, int k ){
  int i;

  for(i=0; i < M*M; i++){
    logp_nc_sym[i] = sll[k*M*M + i]; 
  }
}



double compute_maxstar_denominator( double * sll, int M, double* logp_nc_sym, int k ){

  double msn;
  
  get_all_logp( logp_nc_sym, sll, M, k );

  msn = compute_recursive_maxstar( logp_nc_sym, M*M );
 
  return msn;
}



double compute_hxy( double * sll, int M, int L, int m, double * nc_bits ){
  int k;
  double hxy, hxy_sum;
  double maxstar_numerator;
  double maxstar_denominator;
  double *logp_nc_sym;

  double log_e_2;  /* factor to convert base e to base 2 */


  logp_nc_sym = calloc( M*M, sizeof( double ) );   /* allocate memory for temporary logps */

  log_e_2 = log(2);
  
  hxy_sum = 0;
  for( k = 0; k < L; k++ ){
    
    maxstar_numerator =   compute_maxstar_numerator( sll, M, m, L, nc_bits, logp_nc_sym, k ); 
    
    maxstar_denominator = compute_maxstar_denominator( sll, M, logp_nc_sym, k );

    hxy_sum = hxy_sum + ( -maxstar_numerator + maxstar_denominator )/log_e_2; 
    
  }


  hxy = hxy_sum/(double)L;
  
  free( logp_nc_sym );  
  return hxy;

}


double compute_capacity( double * sll, int M, int L, int m, double * nc_bits){   /* compute mutual information */
  double hx;
  double hxy;
  double C;


  hx = compute_hx(M); 
  hxy = compute_hxy( sll, M, L, m, nc_bits ); 
  C = hx - hxy;

  C = C/(double)log2(M); /* normalize by modulation order */
                         /* capacity will take values 0 < C < 1 */
                         /* this is consistent with the point-to-point
                          *   capacity function */  
  return C;
}









void mexFunction(
		 int            nlhs,
		 mxArray       *plhs[],
		 int            nrhs,
		 const mxArray *prhs[] )
{

  /***** inputs ****/
  double  *sll;             /* symbol log-likelihoods */
  int     M;                /* modulation order */
  double  *nc_bits;         /* network-coded bits for this frame */

  /**** derived parameters ****/
  int     L;                 /* number of symbols */
  int     m;                 /* bits per symbol */
  
  /**** outputs ****/
  double C;                  /* capacity for this frame */
  double  *output_p;         /* output variable containing capacity */



  /** Read inputs: M-ary symbol probablities and modulation order **/
  if( nrhs != 3 )
    mexErrMsgTxt("Usage: [capacity] = Capacity_DNC( [sym_log_likelihood], [mod_order],  [nc_bits] )");

  sll         = read_symbol_likelihoods( prhs[0] );
  M           = read_modulation_order( prhs[1] );
  L           = read_symbol_likelihood_length( prhs[0], M );
  m           = compute_bits_per_symbol(M);
  nc_bits     = read_nc_bits( prhs[2] );
  /***************************************************************/


  /** Prepare output: single scalar containing capacity **/
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL );   /* prepare output variables */
  output_p = mxGetPr(plhs[0]);
   
    
  /** Compute capcaity and return **/
  C = compute_capacity( sll, M, L, m, nc_bits ); 
  output_p[0] = C; 
  return;
}
