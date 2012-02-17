/* File: LdpcEncode.c

   Description: Encodes a single LDPC codeword.  Code must be an "eIRA-LDPC" type code,
                such as the one in the DVB-S2 standard or WiMax standard.

   The calling syntax is:
   codeword    = LdpcEncode( data, H_rows, [P])

   Where:
      codeword = the encoded codeword

      data   = a row vector containing the data
      H_rows = a M-row matrix containing the indices of the non-zero rows of H excluding the dual-diagonal part.
      P      = (optional) z times z matrix used to generate the first z check bits for WiMax (default =[])

   Copyright (C) 2005-2007, Rohit Iyer Seshadri and Matthew C. Valenti

   Last updated on June. 23, 2007

   Function LdpcEncode is part of the Iterative Solutions 
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
# include<mex.h>
# include<stdio.h>
# include<math.h>
# include<stdlib.h>

void encode(double u[],double H_rows[],double *c_in,int nldpc,int kldpc,int mldpc, int wid_Hrows, double P[], int shift)
{
	int count,i,j, k,sum,temp, cnt;
	int *x,*sum2, *sum_tmp, *tmp;   
	
	x       =(int*)calloc((mldpc+1),sizeof(int));
	sum2    =(int*)calloc(shift,sizeof(int));
    sum_tmp =(int*)calloc(shift,sizeof(int));
    tmp     =(int*)calloc(shift,sizeof(int));
    
	
	for (i=0;i<kldpc;i++){
		c_in[i]=u[i];
 	 } 
	for (i=0;i<mldpc;i++){
        c_in[kldpc+i]=0; 
	}			
	
	if (shift ==0){
		sum=0;	 
         for(i=0;i<mldpc;i++){		
	  	    for(k=1;k<=wid_Hrows;k++){
			   if(H_rows[i+mldpc*(k-1)]!=0){
			    	count=(int)H_rows[i+mldpc*(k-1)];
				    x[i]=((int)c_in[count-1])^((int)x[i]) ;
			   }
		   }
	    	c_in[kldpc+i]=x[i]^sum; /* Differential encoding */
		    sum=c_in[kldpc+i];
	}
	   
}		
    else{	 
	    for (j=0;j<kldpc/shift;j++){
	       cnt=0;
	       for (i =0;i<mldpc;i++){
	          
	           for(k=1;k<=wid_Hrows;k++){
			       if(H_rows[i+mldpc*(k-1)]!=0){			      
			          if (((int)H_rows[i+mldpc*(k-1)]>j*shift )&&((int)H_rows[i+mldpc*(k-1)]<=(j+1)*shift)){
				         count=(int)H_rows[i+mldpc*(k-1)];
				         tmp[cnt]=((int)c_in[count-1])^((int)tmp[cnt]) ;
			          }
	    	       }  
	    	   }
	     
	          sum_tmp[cnt]=sum_tmp[cnt]^tmp[cnt];
	          tmp[cnt]=0;
	          if (((i+1) % shift) ==0){
	              cnt=0;
	          }
	          else{	      
	             cnt++;      
	          }
		   }
	   }
	   for (k=0;k<shift;k++){
	         sum=0;
	         for (i =0;i<shift;i++){
	             sum=sum^(((int)P[k+(i)*shift])*sum_tmp[i]);              
	          }
	         c_in[kldpc+k]=sum;
	     }
	     
	   cnt=0;
       for(i=0;i<mldpc-shift;i++){		
           for(k=1;k<=wid_Hrows;k++){
			   if(H_rows[i+mldpc*(k-1)]!=0){
				   count=(int)H_rows[i+mldpc*(k-1)];
				   x[i]=((int)c_in[count-1])^((int)x[i]) ;
			   }
	    	}  
	        c_in[kldpc+shift+i]=x[i]^sum2[cnt]; /* Differential encoding */
	        sum2[cnt]=c_in[kldpc+i+shift];
	            if (((i+1)%shift)==0){
	                cnt=0;
	            }
	            else{
	                 cnt=cnt+1;
	            }	       	       
	   } 
	        
	 }
     
	free(x);
    free(sum2);
    free(sum_tmp);
    free(tmp);
    return;	
}


void mexFunction(int nlhs,mxArray *plhs[],int nrhs, const mxArray *prhs[])
{
	double *u,*c_in, *H_rows, *P;
	int index,nldpc,kldpc,mldpc,wid_Hrows,shift;
	
	/* Error checks	*/
	if ((nrhs <2)||(nrhs >3)){
		mexErrMsgTxt(" Usage:    codeword    = LdpcEncode( data, H_rows, [P]) \n");
	}
	else if (nlhs >1){
		mexErrMsgTxt(" only 1 output ");
	}	
	
	
   /* default values */
   shift=0;
   P= (int*)calloc(shift,sizeof(int));

	/* Assign the variables to corresp. mlab pointers */
	u=mxGetPr(prhs[0]);
	H_rows=mxGetPr(prhs[1]);
	
	if (nrhs >2) {
	    P=mxGetPr(prhs[2]);
	    shift=mxGetM(prhs[2]);
	}

	kldpc=mxGetN(prhs[0]);
	mldpc= mxGetM(prhs[1]);
	wid_Hrows=mxGetN(prhs[1]);
	nldpc=kldpc+mldpc;
 	 
	/* create output m array */
	plhs[0]= mxCreateDoubleMatrix(1,nldpc,mxREAL);
	
	/* create output m array */
	c_in=mxGetPr(plhs[0]);
	encode(u,H_rows,c_in,nldpc,kldpc,mldpc, wid_Hrows,P,shift);
}