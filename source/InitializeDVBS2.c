/* File: InitializeDVBS2.c

   Description: Initializes the DVB-S2 LDPC encoder/decoder

   The calling syntax is:
      [H_rows, H_cols, [P]] = InitializeDVBS2( rate, size )

   Where:
      H_rows = a M-row matrix containing the indices of the non-zero rows of H.
	  H_cols = a (N-M)-row matrix containing the indices of the non-zeros rows of H.
	  P      = (optional) empty matrix. (for consistency with IntializeWiMaxLDPC)

      rate = the code rate
	  size = the size of the code (number of code bits):
	       = 64,800 for normal (n=64,800)
		   = 16,200 for short  (n=16,200)

   Copyright (C) 2005-2007, Rohit Iyer Seshadri and Matthew C. Valenti

   Last updated on July 10, 2007.

   Function InitializeDVBS2 is part of the Iterative Solutions 
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

#include<mex.h>
#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include "./include/DVBS2lookup.h"
#define epsilon 1e-2

                   
void initalize(int *u,mxArray *plhs[],int nldpc,int kldpc,int mldpc,int Q, int index)
{
    
	int r,col_ind,row_ind,count,i,j, k,state,op,sum,t,temp,*temp_count, *x, ind; /* used dynamic mem. alloc 4/27 */
	int rows, cols,nrows, ncols, *col_index, *row_index, max_col, max_row;
	double *H_rows_tmp,*H_cols_tmp,*H_rows, *H_cols;
    
	temp_count=(int*)calloc((mldpc+5),sizeof(int));
	x=(int*)calloc((mldpc+5),sizeof(int));
	col_index=(int*)calloc((kldpc+5),sizeof(int));
	row_index=(int*)calloc((mldpc+5),sizeof(int));
	H_rows_tmp=(double*)calloc((mldpc*40),sizeof(double));
	H_cols_tmp=(double*)calloc((kldpc*40),sizeof(double));

	
	rows=165;
	cols =15;

	
	Q=T_short[index][164][14];
	 
	/* Accumulate data bits at specific parity locations  */
	count=0;
	i=0;
	while ((i < 165) && (T_short[index][i][1]!=0)){
		
		for (j=0; j< 360;j++){
			for (k=1;k<=15;k++){
				if ((T_short[index][i][k-1]!=0) || (k==1)){
					if (T_short[index][i][1]!=0){
						temp=fmod((T_short[index][i][k-1]+(fmod(j,360))*Q),mldpc);/* find the correct parity bit location */
						x[temp]=((int)u[count])^((int)x[temp]); /* Accumulate the correponding data bit  at that location */
						H_cols_tmp[(count)+kldpc*(k-1)]=temp+1;
						temp_count[temp]= temp_count[temp]+1;
						ind=temp_count[temp];
						H_rows_tmp[(temp)+mldpc*(ind-1)]=count+1;
						row_index[temp]=ind-1;
						col_index[count]=k-1;						
					}
				}				
			}
			count++;
		}			       
		i++;
	}
		
	max_col=col_index[0];
	max_row=row_index[0];
	
	for (i=1;i<=kldpc;i++){
		if (max_col <=col_index[i-1]){
			max_col=col_index[i-1];
		}		
	}
	
	for (i=1;i<=mldpc;i++){
		if (max_row <=row_index[i-1]){
			max_row=row_index[i-1];
		}
	}
	
	plhs[0]= mxCreateDoubleMatrix(mldpc,max_row+1,mxREAL);
	plhs[1]= mxCreateDoubleMatrix(kldpc,max_col+1,mxREAL);
	
	/* create output arrays */
    H_rows=mxGetPr(plhs[0]);
    H_cols=mxGetPr(plhs[1]);   

	for (i=1;i<=kldpc;i++)	{
		for (j=1;j<=max_col+1;j++){  
			H_cols[(i-1)+kldpc*(j-1)]=H_cols_tmp[(i-1)+kldpc*(j-1)];
		}
   	}
	
	for (i=1;i<=mldpc;i++)	{
		for (j=1;j<=max_row+1;j++) {   
			H_rows[(i-1)+mldpc*(j-1)]=H_rows_tmp[(i-1)+mldpc*(j-1)];
		}
	}	
	
	free(temp_count);
	free(u);
	free(col_index);
	free(row_index);
	free(H_rows_tmp);
	free(H_cols_tmp);
	
	return;

}


void mexFunction(int nlhs,mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
	double *H_rows,*H_cols,*param,rate,d, *P;
	int index,nldpc,kldpc,mldpc,Q,R,*u,i,size;
	
	/* Error checks	*/
	if (nrhs !=2) {
		mexErrMsgTxt("2 inputs needed\n");
    } else if ((nlhs >3) || (nlhs <2)) {
		mexErrMsgTxt(" 2  or 3 outputs needed\n ");	
    }
	   
	/* Assign the variables to corresp. mlab pointers    */
	rate= mxGetScalar(prhs[0]);
	size= mxGetScalar(prhs[1]);  
	nldpc=size;
		
	if (nlhs ==3)
	 {
	 	plhs[2]= mxCreateDoubleMatrix(0,0,mxREAL);
	 	P=mxGetPr(plhs[2]);
	 }

	if (size==16200) {
		if (fabs(rate - 1.0/4.0) < epsilon ){				
			kldpc = (int) nldpc*(1.0/5.0);
			index = 11;
        } else if (fabs(rate - 1.0/3.0) < epsilon ){				
			kldpc = (int) nldpc*(1.0/3.0);        
			index = 12;
        } else if (fabs(rate - 2.0/5.0) < epsilon ){	
			kldpc = (int) nldpc*(2.0/5.0);
			index = 13;
		} else if (fabs(rate - 1.0/2.0) < epsilon ){	  
			kldpc = (int) nldpc*(4.0/9.0);
			index = 14;
		} else if (fabs(rate - 3.0/5.0) < epsilon ){	  
			kldpc = (int) nldpc*(3.0/5.0);
			index = 15;
		} else if (fabs(rate - 2.0/3.0) < epsilon ){	
			kldpc = (int) nldpc*(2.0/3.0);
			index = 16;
		} else if (fabs(rate - 3.0/4.0) < epsilon ){	 
			kldpc = (int) nldpc*(11.0/15.0);
			index = 17;
		} else if (fabs(rate - 4.0/5.0) < epsilon ){	
			kldpc = (int) nldpc*(7.0/9.0);
			index = 18;
		} else if (fabs(rate - 5.0/6.0) < epsilon ){	
			kldpc = (int) nldpc*(37.0/45.0);
			index = 19;
		} else if (fabs(rate - 8.0/9.0) < epsilon ){			
			kldpc = (int) nldpc*(8.0/9.0);
			index = 20;
		} else {
			mexErrMsgTxt( "This rate is not supported" );
		}		
	} else if (size==64800) {
       if (fabs(rate - 1.0/4.0) < epsilon ){			
			index = 0;
        } else if (fabs(rate - 1.0/3.0) < epsilon ){				 
			index = 1;
        } else if (fabs(rate - 2.0/5.0) < epsilon ){	       
			index = 2;
		} else if (fabs(rate - 1.0/2.0) < epsilon ){	
			index = 3;
		} else if (fabs(rate - 3.0/5.0) < epsilon ){	
			index = 4;
		} else if (fabs(rate - 2.0/3.0) < epsilon ){	
			index = 5;
		} else if (fabs(rate - 3.0/4.0) < epsilon ){	
			index = 6;
		} else if (fabs(rate - 4.0/5.0) < epsilon ){	
			index = 7;
		} else if (fabs(rate - 5.0/6.0) < epsilon ){	
			index = 8;
		} else if (fabs(rate - 8.0/9.0) < epsilon ){
			index = 9;
		} else if (fabs(rate - 9.0/10.0) < epsilon ){
			index = 10;
		} else {
			mexErrMsgTxt( "This rate is not supported" );
		}
		kldpc = (int) nldpc*rate;
	} else {
		mexErrMsgTxt( "Only lengths 16200 and 64800 are supported" );
	}
	
	mldpc=nldpc-kldpc;
	u=(int*)calloc((kldpc+5),sizeof(int));
	initalize(u,plhs,nldpc,kldpc,mldpc,Q,index);

	
 }
