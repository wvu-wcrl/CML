/* file: MpDecode.c

   Description: Decode a block code using the message passing algorithm. 

   The calling syntax is:

      [output, errors] = MpDecode(input, H_rows, H_cols, [max_iter], [dec_type], [r_scale_factor], [q_scale_factor], [data] )

      output = matrix of dimension maxiter by N that has the decoded code bits for each iteration 
	  errors = (optional) column vector showing the number of (data bit) errors after each iteration.

      input  = the decoder input in LLR form
	  H_cols = a N row matrix specifying the locations of the nonzero entries in each column of the H matrix.
	           The number or columns in the matrix is the max column weight.
	           OR
	           a (K + shift) row matrix specifying locations of the nonzero entries in each coulmn of an extended IRA type 
	           sparse H1 matrix
	           
	  H_rows = a N-K row matrix specifying the locations of the nonzero entries in each row of the H matrix.
	           The number or columns in the matrix is the max row weight, unless this is for an H1 matrix,
			   in which case the last n-k-shift columns of the H matrix are equal to a known H2 matrix.
	  max_iter = (optional) the maximum number of decoder iterations (default = 30).
	  dec_type = (optional) the decoder type:
			   = 0 Sum-product (default)
			   = 1 Min-sum 
			   = 2 Approximate-min-star
	  r_scale_factor = (optional) amount to scale extrinsic output of c-nodes in min-sum decoding (default = 1) 
      q_scale_factor = (optional) amount to scale extrinsic output of v-nodes in min-sum decoding (default = 1)
	  data = (optional) a vector containing the data bits (used for counting errors and for early halting) (default all zeros)
	
   Copyright (C) 2006-2007, Matthew C. Valenti and Rohit Iyer Seshadri

   Last updated on Aug. 8, 2007

   Function MpDecode is part of the Iterative Solutions 
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

/* Input Arguments */
#define INPUT       prhs[0]
#define HROWS		prhs[1]
#define HCOLS		prhs[2]
#define MAXITER     prhs[3]
#define DECTYPE     prhs[4]
#define RSCALEFACTOR prhs[5]
#define QSCALEFACTOR prhs[6]
#define DATA prhs[7]

/* Output Arguments */
#define OUTPUT      plhs[0]
#define	ERRORS      plhs[1]

struct v_node {
    int degree;
	float initial_value;
    int *index;  /* the index of a c_node it is connected to */
	int *socket; /* socket number at the c_node */
    float *message;     
	int *sign;
};

struct c_node {
    int degree;
    int *index;                     
    float *message;     
	int *socket; /* socket number at the v_node */
};

/* Phi function */
static float phi0(
					  float x )
{
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

static float correction(
					  float xinput )
{
	if (xinput > 2.625 )
		return( 0 );
	else if (xinput < 1 )
		return( -0.375*xinput + 0.6825 );
	else 
		return( -0.1875*xinput + 0.5 );

}

static float LambdaAPPstar(	float mag1,
				float mag2 )
{
	if (mag1 > mag2)
		return( fabs( mag2 + correction( mag1 + mag2 ) - correction( mag1 - mag2 ) ) );
	else
		return( fabs( mag1 + correction( mag1 + mag2 ) - correction( mag2 - mag1 ) ) );
}

/* function for doing the MP decoding */
static void ApproximateMinStar(	 int	  BitErrors[],
						 int      DecodedBits[],
						 struct c_node c_nodes[],
						 struct v_node v_nodes[],
						 int	  CodeLength,
						 int	  NumberParityBits,
						 int	  max_iter )
{
	int i,j, iter;
	int sign;
	float temp_sum;
	float Qi;

	float delta, minval, deltaAPP;
	int mink;

	for (iter=0;iter<max_iter;iter++) {
		/* update r */
		for (j=0;j<NumberParityBits;j++) {	
			/* start new code for approximate-min-star */
			mink = 0;
			sign = v_nodes[ c_nodes[j].index[0] ].sign[ c_nodes[j].socket[0] ];
			minval = v_nodes[ c_nodes[j].index[0] ].message[ c_nodes[j].socket[0] ];
		
			for (i=1;i<c_nodes[j].degree;i++) {
				/* first find the minimum magnitude input message */
				if ( v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] < minval ) {
					mink = i;
					minval = v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ];							
				}
				/* update the aggregate sign */
				sign ^= v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ];
			}

			/* find the magnitude to send out the minimum input magnitude branch */
			if ( mink == 0 ) {
				delta = v_nodes[ c_nodes[j].index[1] ].message[ c_nodes[j].socket[1] ];
				for (i=2;i<c_nodes[j].degree;i++) {
					delta = LambdaAPPstar( delta, v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] );
				}
			} else {
				delta = v_nodes[ c_nodes[j].index[0] ].message[ c_nodes[j].socket[0] ];
				for (i=1;i<c_nodes[j].degree;i++) {
					if ( i != mink )
						delta = LambdaAPPstar( delta, v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] );
				}
			}

			deltaAPP = LambdaAPPstar( delta, v_nodes[ c_nodes[j].index[mink] ].message[ c_nodes[j].socket[mink] ] );

			/* compute outgoing messages */
			for (i=0;i<c_nodes[j].degree;i++) {
				if ( i == mink ) {
					if ( sign^v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ] )
						c_nodes[j].message[i] = - delta;
					else
						c_nodes[j].message[i] = delta;
				} else {
					if ( sign^v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ] )
						c_nodes[j].message[i] = - deltaAPP;
					else
						c_nodes[j].message[i] = deltaAPP;
				}
			}		
		}

		/* update q */
		for (i=0;i<CodeLength;i++) {

			/* first compute the LLR */
			Qi = v_nodes[i].initial_value;
			for (j=0;j<v_nodes[i].degree;j++) {				
				Qi += c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
			}

			/* make hard decision */			
			if (Qi < 0) {
				DecodedBits[iter+max_iter*i] = 1;
				BitErrors[iter]++;
			}

			/* now subtract to get the extrinsic information */
			for (j=0;j<v_nodes[i].degree;j++) {
				temp_sum = Qi - c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
				
				v_nodes[i].message[j] = fabs( temp_sum );
				if (temp_sum > 0)
					v_nodes[i].sign[j] = 0;
				else
					v_nodes[i].sign[j] = 1;
			}
		}

		/* detect errors */
		if (BitErrors[iter] == 0)
			break; 
	}
}


/* function for doing the MP decoding */
static void MinSum(		 int	  BitErrors[],
						 int      DecodedBits[],
						 struct c_node c_nodes[],
						 struct v_node v_nodes[],
						 int	  CodeLength,
						 int	  NumberParityBits,
						 int	  max_iter, 
						 float    r_scale_factor,
						 float    q_scale_factor, 
						 int      data[] )
{
	int i,j, iter, i_prime, j_prime;
	float min_beta;
	int sign;
	float temp_sum;
	float Qi;

	for (iter=0;iter<max_iter;iter++) {

		/* update r */
		for (j=0;j<NumberParityBits;j++) {
			sign = 0;
			for (i=0;i<c_nodes[j].degree;i++) 
				sign ^= v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ];

			for (i=0;i<c_nodes[j].degree;i++) {
				min_beta = 1000;		
								
				for (i_prime=0;i_prime<c_nodes[j].degree;i_prime++) 
					if ( ( v_nodes[ c_nodes[j].index[i_prime] ].message[c_nodes[j].socket[i_prime]] < min_beta )&&(i_prime != i) )
						min_beta = v_nodes[ c_nodes[j].index[i_prime] ].message[c_nodes[j].socket[i_prime]];

				if ( sign^v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ] )
					c_nodes[j].message[i] = -min_beta*r_scale_factor;
				else
					c_nodes[j].message[i] = min_beta*r_scale_factor;
			}
		}

		/* update q */
		for (i=0;i<CodeLength;i++) {
			
			/* first compute the LLR */
			Qi = v_nodes[i].initial_value;
			for (j=0;j<v_nodes[i].degree;j++) {				
				Qi += c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
			}

			/* make hard decision */			
			if (Qi < 0) {
				DecodedBits[iter+max_iter*i] = 1;
			}

			/* now subtract to get the extrinsic information */
			for (j=0;j<v_nodes[i].degree;j++) {
				temp_sum = Qi - c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
				
				v_nodes[i].message[j] = fabs( temp_sum )*q_scale_factor;
				if (temp_sum > 0)
					v_nodes[i].sign[j] = 0;
				else
					v_nodes[i].sign[j] = 1;
			}
		}

		/* count data bit errors, assuming that it is systematic */
		for (i=0;i<CodeLength-NumberParityBits;i++)
			if ( DecodedBits[iter+max_iter*i] != data[i] )
				BitErrors[iter]++;

		/* detect errors */
		if (BitErrors[iter] == 0)
			break; 
	}
}


/* function for doing the MP decoding */
static void SumProduct(	 int	  BitErrors[],
						 int      DecodedBits[],
						 struct c_node c_nodes[],
						 struct v_node v_nodes[],
						 int	  CodeLength,
						 int	  NumberParityBits,
						 int	  max_iter,
						 float    r_scale_factor,
						 float    q_scale_factor, 
						 int      data[] )
{
	int i,j, iter;
	float phi_sum;
	int sign;
	float temp_sum;
	float Qi;

	for (iter=0;iter<max_iter;iter++) {
		/* update r */
		for (j=0;j<NumberParityBits;j++) {		
			sign = v_nodes[ c_nodes[j].index[0] ].sign[ c_nodes[j].socket[0] ];
			phi_sum = v_nodes[ c_nodes[j].index[0] ].message[ c_nodes[j].socket[0] ];
			
			for (i=1;i<c_nodes[j].degree;i++) {
				phi_sum += v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ];
				sign ^= v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ];
			}
			
			for (i=0;i<c_nodes[j].degree;i++) {
				if ( sign^v_nodes[ c_nodes[j].index[i] ].sign[ c_nodes[j].socket[i] ] ) {
					c_nodes[j].message[i] = -phi0( phi_sum - v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] )*r_scale_factor;
				} else
					c_nodes[j].message[i] = phi0( phi_sum - v_nodes[ c_nodes[j].index[i] ].message[ c_nodes[j].socket[i] ] )*r_scale_factor;
			}
		}

		/* update q */
		for (i=0;i<CodeLength;i++) {

			/* first compute the LLR */
			Qi = v_nodes[i].initial_value;
			for (j=0;j<v_nodes[i].degree;j++) {				
				Qi += c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
			}

			/* make hard decision */			
			if (Qi < 0) {
				DecodedBits[iter+max_iter*i] = 1;
			}

			/* now subtract to get the extrinsic information */
			for (j=0;j<v_nodes[i].degree;j++) {
				temp_sum = Qi - c_nodes[ v_nodes[i].index[j] ].message[ v_nodes[i].socket[j] ];
				
				v_nodes[i].message[j] = phi0( fabs( temp_sum ) )*q_scale_factor;
				if (temp_sum > 0)
					v_nodes[i].sign[j] = 0;
				else
					v_nodes[i].sign[j] = 1;
			}
		}

		/* count data bit errors, assuming that it is systematic */
		for (i=0;i<CodeLength-NumberParityBits;i++)
			if ( DecodedBits[iter+max_iter*i] != data[i] )
				BitErrors[iter]++;

		/* Halt if zero errors */
		if (BitErrors[iter] == 0)
			break; 

	}
}

/* main function that interfaces with MATLAB */
void mexFunction(
				 int            nlhs,
				 mxArray       *plhs[],
				 int            nrhs,
				 const mxArray *prhs[] )
{	int		max_iter, dec_type;
	int		max_row_weight, max_col_weight;
	int		NumberParityBits, CodeLength;
	double  *H_rows, *H_cols;		/* Parity check matrix info */
	double  *input;		
	int     i, j, count, v_index, c_index;
	int		*DecodedBits;	/* Output of the decoder.  Is an array of size iter by CodeLength */
	int		*BitErrors;		/* Number of errors at each iteration */
	double  *errors_p, *output_p;
	struct c_node *c_nodes;
	struct v_node *v_nodes;
	float   q_scale_factor, r_scale_factor;
	double  *data;
	int     *data_int;
	int     DataLength;
	int     NumberRowsHcols;
	int		H1;
	int     shift;
	int     cnt;
	int     k;

	/* default values */
	max_iter  = 30;
	dec_type  = 0;
	q_scale_factor = 1;
	r_scale_factor = 1;

	/* Check for proper number of arguments */
	if ( (nrhs < 3 )|(nlhs  > 2) ) {
		mexErrMsgTxt("Usage: [output, errors] = MpDecode(input, H_rows, H_cols, max_iter, dec_type, r_scale_factor, q_scale_factor, data )");
	} else {
		/* first input is the received data in LLR form */
		input = mxGetPr(INPUT);	

		/* second input is H_rows matrix */
		H_rows = mxGetPr( HROWS );

		/* third input is H_cols matrix */
		H_cols = mxGetPr( HCOLS );

		/* derive some parameters */
		CodeLength = mxGetN(INPUT); /* number of coded bits */
		NumberParityBits = mxGetM( HROWS );
		NumberRowsHcols=mxGetM( HCOLS );
		shift=(NumberParityBits+ NumberRowsHcols)-CodeLength;
		
		
		
		if (NumberRowsHcols ==CodeLength){
		      H1=0;
              shift=0;
		} else {
		       H1=1;
		}
	
		if (( CodeLength != NumberRowsHcols ) && (CodeLength-NumberParityBits + shift!= NumberRowsHcols))
		 	 mexErrMsgTxt("Error: Number of rows in H_cols must equal number of received bits or number of data bits");
		
		max_row_weight = mxGetN( HROWS );
		max_col_weight = mxGetN( HCOLS );
	} 
	
	/* initialize c-node structures */
    c_nodes = calloc( NumberParityBits, sizeof( struct c_node ) );
	
	/* first determine the degree of each c-node */
	
    if (shift ==0){	
	   for (i=0;i<NumberParityBits;i++) {
		   count = 0;
		   for (j=0;j<max_row_weight;j++) {
			   if ( H_rows[i+j*NumberParityBits] > 0 ) {
				   count++;
			   }
		   }
		  c_nodes[i].degree = count;
		  if (H1){
			    if (i==0){
			       c_nodes[i].degree=count+1;
			    } 
			   else{
			      c_nodes[i].degree=count+2;
			   }
		 }
    	}
	}	
	else{	
	    cnt=0; 
	    for (i=0;i<(NumberParityBits/shift);i++) {		
          	for (k=0;k<shift;k++){
           	   count = 0;
		       for (j=0;j<max_row_weight;j++) {
			       if ( H_rows[cnt+j*NumberParityBits] > 0 ) {
				       count++;
			        }
	    	   }
		       c_nodes[cnt].degree = count;
		       if ((i==0)||(i==(NumberParityBits/shift)-1)){
			      c_nodes[cnt].degree=count+1;
			    } 
			   else{
			       c_nodes[cnt].degree=count+2;
			   }
			   cnt++;
	        }	   
	     }	
 	}
			
	if (H1){

	   if (shift ==0){
		for (i=0;i<NumberParityBits;i++) {
		    /* now that we know the size, we can dynamically allocate memory */
			c_nodes[i].index =  calloc( c_nodes[i].degree, sizeof( int ) );
			c_nodes[i].message =calloc( c_nodes[i].degree, sizeof( float ) );
			c_nodes[i].socket = calloc( c_nodes[i].degree, sizeof( int ) );
			
			for (j=0;j<c_nodes[i].degree-2;j++) {
			     c_nodes[i].index[j] = (int) (H_rows[i+j*NumberParityBits] - 1);
			}			    
			j=c_nodes[i].degree-2;
		
			   if (i==0){
			       c_nodes[i].index[j] = (int) (H_rows[i+j*NumberParityBits] - 1);			        
		    	 }
			    else {
				    c_nodes[i].index[j] = (CodeLength-NumberParityBits)+i-1;
                }
						
			j=c_nodes[i].degree-1;			
		    c_nodes[i].index[j] = (CodeLength-NumberParityBits)+i;
		    
		    }		      
		}		
		if (shift >0){
		   cnt=0;
		   for (i=0;i<(NumberParityBits/shift);i++){		  
		  
		        for (k =0;k<shift;k++){
		            c_nodes[cnt].index =  calloc( c_nodes[cnt].degree, sizeof( int ) );
	 		        c_nodes[cnt].message =calloc( c_nodes[cnt].degree, sizeof( float ) );
			        c_nodes[cnt].socket = calloc( c_nodes[cnt].degree, sizeof( int ) );
			 		   
			  	for (j=0;j<c_nodes[cnt].degree-2;j++) {
			         c_nodes[cnt].index[j] = (int) (H_rows[cnt+j*NumberParityBits] - 1);
			    }			    
			   j=c_nodes[cnt].degree-2;
			   if ((i ==0)||(i==(NumberParityBits/shift-1))){
 			       c_nodes[cnt].index[j] = (int) (H_rows[cnt+j*NumberParityBits] - 1);	
			   }
			   else{
     			   c_nodes[cnt].index[j] = (CodeLength-NumberParityBits)+k+shift*(i);
			   }			
			    j=c_nodes[cnt].degree-1;    		     
			    c_nodes[cnt].index[j] = (CodeLength-NumberParityBits)+k+shift*(i+1);
    		   if (i== (NumberParityBits/shift-1))
			     {
			        c_nodes[cnt].index[j] = (CodeLength-NumberParityBits)+k+shift*(i);
			     }
   			    cnt++;			    
			 } 
		  }
		}
				
	} else {
		for (i=0;i<NumberParityBits;i++) {
			/* now that we know the size, we can dynamically allocate memory */
			c_nodes[i].index =  calloc( c_nodes[i].degree, sizeof( int ) );
			c_nodes[i].message =calloc( c_nodes[i].degree, sizeof( float ) );
			c_nodes[i].socket = calloc( c_nodes[i].degree, sizeof( int ) );
			for (j=0;j<c_nodes[i].degree;j++){
			    c_nodes[i].index[j] = (int) (H_rows[i+j*NumberParityBits] - 1);
			}			
		}
	}	

	/* initialize v-node structures */
	v_nodes = calloc( CodeLength, sizeof( struct v_node));
	
	/* determine degree of each v-node */
	for(i=0;i<(CodeLength-NumberParityBits+shift);i++){
        count=0;		
		for (j=0;j<max_col_weight;j++) {
			if ( H_cols[i+j*NumberRowsHcols] > 0 ) {
				count++;
			}
		}
		v_nodes[i].degree = count;
	}
	
	for(i=CodeLength-NumberParityBits+shift;i<CodeLength;i++){
		count=0;
		if (H1){
			if(i!=CodeLength-1){
				v_nodes[i].degree=2;
			}  else{
				v_nodes[i].degree=1;
			}	 
			
		} else{
			for (j=0;j<max_col_weight;j++) {
				if ( H_cols[i+j*NumberRowsHcols] > 0 ) {
					count++;
				}
			}      
			v_nodes[i].degree = count;	 	  
		}	 
	}  
	 
	if (shift>0){
	          v_nodes[CodeLength-1].degree =v_nodes[CodeLength-1].degree+1;	                   
    	}
    	
    

	for (i=0;i<CodeLength;i++) {
		/* allocate memory according to the degree of the v-node */
		v_nodes[i].index = calloc( v_nodes[i].degree, sizeof( int ) );
		v_nodes[i].message = calloc( v_nodes[i].degree, sizeof( float ) );
		v_nodes[i].sign = calloc( v_nodes[i].degree, sizeof( int ) );
		v_nodes[i].socket = calloc( v_nodes[i].degree, sizeof( int ) );
		
		/* index tells which c-nodes this v-node is connected to */
	  	 v_nodes[i].initial_value = input[i];
		 count=0;

		for (j=0;j<v_nodes[i].degree;j++) {			
			if ((H1)&& (i>=CodeLength-NumberParityBits+shift)){
				v_nodes[i].index[j]=i-(CodeLength-NumberParityBits+shift)+count;
				if (shift ==0){
				   	count=count+1;
				  }
				  else{
				   count=count+shift;
				  }
			} else  {
				v_nodes[i].index[j] = (int) (H_cols[i+j*NumberRowsHcols] - 1);
			}			
						
			/* search the connected c-node for the proper message value */
			for (c_index=0;c_index<c_nodes[ v_nodes[i].index[j] ].degree;c_index++)
				if ( c_nodes[ v_nodes[i].index[j] ].index[c_index] == i ) {
					v_nodes[i].socket[j] = c_index;
					break;
				}				
				/* initialize v-node with received LLR */			
				if ( dec_type == 1)
					v_nodes[i].message[j] = fabs(input[i]);
				else
					v_nodes[i].message[j] = phi0( fabs(input[i]) );
				
				if (input[i] < 0)
					v_nodes[i].sign[j] = 1;			
		}
	
	}
	
	
	
	/* now finish setting up the c_nodes */
	for (i=0;i<NumberParityBits;i++) {		
		/* index tells which v-nodes this c-node is connected to */
		for (j=0;j<c_nodes[i].degree;j++) {			
			/* search the connected v-node for the proper message value */
			for (v_index=0;v_index<v_nodes[ c_nodes[i].index[j] ].degree;v_index++)
				if (v_nodes[ c_nodes[i].index[j] ].index[v_index] == i ) {
					c_nodes[i].socket[j] = v_index;
					break;
				}
		}
	}
	
	
	if (nrhs > 3 ) {
		/* fourth input (optional) is maximum number of iterations */
		max_iter   = (int) *mxGetPr(MAXITER);
	} if (nrhs > 4 ) {
		/* fifth input (optional) is the decoder type */
		dec_type  = (int) *mxGetPr(DECTYPE);
	} if (nrhs > 5 ) {
		/* next input is the factor for extrinsic info scaling */
		r_scale_factor = (float) *mxGetPr(RSCALEFACTOR);
	}  if (nrhs > 6 ) {
		/* next input is the factor for extrinsic info scaling */
		q_scale_factor = (float) *mxGetPr(QSCALEFACTOR);
	}  
	
	DataLength = CodeLength - NumberParityBits;
	data_int = calloc( DataLength, sizeof(int) );
	
	if (nrhs > 7 ) {
		/* next input is the data */
		data = mxGetPr(DATA);	
		if ( DataLength != mxGetN(DATA) ) /* number of data bits */
			mexErrMsgTxt("Error: Incorrect number of data bits");
		
		/* cast the input into a vector of integers */
		for (i=0;i<DataLength;i++) {
			data_int[i] = (int) data[i];
		}
		
	}

	/* create matrices for the decoded data */		
	OUTPUT = mxCreateDoubleMatrix(max_iter, CodeLength, mxREAL );
	output_p = mxGetPr(OUTPUT);	

	/* Decode */
	DecodedBits = calloc( max_iter*CodeLength, sizeof( int ) );
	BitErrors = calloc( max_iter, sizeof(int) );

    /* Call function to do the actual decoding */
	if ( dec_type == 1) {
		MinSum( BitErrors, DecodedBits, c_nodes, v_nodes, CodeLength, 
		   NumberParityBits, max_iter, r_scale_factor, q_scale_factor, data_int );
	} else if ( dec_type == 2) {
		mexErrMsgTxt("dec_type = 2 not currently supported");
		/* ApproximateMinStar( BitErrors, DecodedBits, c_nodes, v_nodes, 
		   CodeLength, NumberParityBits, max_iter, r_scale_factor, q_scale_factor );*/
	} else {
		SumProduct( BitErrors, DecodedBits, c_nodes, v_nodes, CodeLength, 
		   NumberParityBits, max_iter, r_scale_factor, q_scale_factor, data_int ); 
	}

	/* cast to output */
    for (i=0;i<max_iter;i++) {
		for (j=0;j<CodeLength;j++) {
			output_p[i + j*max_iter] = DecodedBits[i+j*max_iter];
		}
	}
	
	if (nlhs > 1 ) {
		/* second output is a count of the number of errors */
		ERRORS = mxCreateDoubleMatrix(max_iter, 1, mxREAL);
		errors_p = mxGetPr(ERRORS);
		
		/* cast to output */    
		for (i=0;i<max_iter;i++) {
			errors_p[i] = BitErrors[i];
		}
	}
	
	/* Clean up memory */
	free( BitErrors );
	free( DecodedBits );
	free( data_int );
	
	/* printf( "Cleaning c-node elements\n" ); */
	for (i=0;i<NumberParityBits;i++) {
		free( c_nodes[i].index );
		free( c_nodes[i].message );
		free( c_nodes[i].socket );
	}
	
	/* printf( "Cleaning c-nodes \n" ); */
	free( c_nodes );
	
	/* printf( "Cleaning v-node elements\n" ); */
	for (i=0;i<CodeLength;i++) {
		free( v_nodes[i].index);
		free( v_nodes[i].sign );
		free( v_nodes[i].message );
		free( v_nodes[i].socket );
	}
	
	/* printf( "Cleaning v-nodes \n" ); */
	free( v_nodes );
	
	return;
}