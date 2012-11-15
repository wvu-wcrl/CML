#include <stdlib.h>
#include <matrix.h>
#include <mex.h>
#include <math.h>
#include "tannergraph.h"


c_node *AllocCnodeStructMemory( int NumberParityBits ){
    return calloc( NumberParityBits, sizeof( c_node ) );
}

v_node *AllocVnodeStructMemory( int CodeLength ){
    return calloc( CodeLength, sizeof( v_node ) );
}



void SetCnodeDegree( c_node *c_nodes, int NumberParityBits,
        double *Row_one, int max_row_weight  )
{
    int i, j;
    int count;
    
    /* get max_row_weight */
    for (i=0; i<NumberParityBits; i++) {
        count = 0;
        c_nodes[i].degree = mxCalloc( 1, sizeof(int) );
        
        for (j=0;j<max_row_weight;j++) {
            if ( Row_one[i+j*NumberParityBits] > -1 )
                count++;
            
        }
        *c_nodes[i].degree = count;
    }
}



void AllocCnodeNodeMemory( c_node *c_nodes, int NumberParityBits )
{
    int i, j;
    for (i=0;i<NumberParityBits;i++) {
        
        c_nodes[i].index =  mxCalloc( *c_nodes[i].degree, sizeof( int ) );
        c_nodes[i].message= mxCalloc( *c_nodes[i].degree, sizeof( float ) );
        c_nodes[i].socket = mxCalloc( *c_nodes[i].degree, sizeof( int ) );
        
        /* goes to InitState
         * for (j=0;j<c_nodes[i].degree;j++){
         * c_nodes[i].index[j] = (int) (Row_one[i+j*NumberParityBits]);
         *
         * }
         */
    }
}


void SetVnodeDegree( v_node *v_nodes, int CodeLength,
        double *Col_one, int max_col_weight, int NumberCodeBits ){
    
    int i,j;
    int count;
    
    
    for(i=0; i<CodeLength; i++){
        count=0;
        v_nodes[i].degree = mxCalloc(1, sizeof( int ) );
        for (j=0;j<max_col_weight;j++) {
            if ( Col_one[i+j*NumberCodeBits] > -1 ) {
                count++;
            }
        }
        *v_nodes[i].degree = count;
        
    }
}



void AllocVnodeNodeMemory( v_node *v_nodes, int CodeLength )
{
    
    int i, j;
    int count;
    int c_index;
    
    for (i=0;i<CodeLength;i++) {
        v_nodes[i].index = mxCalloc( *v_nodes[i].degree, sizeof( int ) );
        v_nodes[i].message = mxCalloc( *v_nodes[i].degree, sizeof( float ) );
        v_nodes[i].sign = mxCalloc( *v_nodes[i].degree, sizeof( int ) );
        v_nodes[i].socket = mxCalloc( *v_nodes[i].degree, sizeof( int ) );
        
        v_nodes[i].initial_value = mxCalloc( 1, sizeof( float ) );
    }
    
    
}



ConvertVnodeCStruct2MatStruct( v_node *v_nodes, int CodeLength, mxArray **v_nodes_mx ){
    int i;
    
    
    int num_fields = 6;
    const char *field_names[] = {"degree", "initial_value",
    "index", "socket",
    "message", "sign"};
    mwSize dims[2];
    mxArray *v_nodes_mat;
    
    mxArray *mxIntPtr;
    mxArray *mxFloatPtr;
    
    dims[0] = 1;
    dims[1] = CodeLength;
    
    *v_nodes_mx = mxCreateStructArray(2, dims, num_fields, field_names );
    
    for(i = 0; i < CodeLength; i++){
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, 1);
        mxSetData( mxIntPtr, v_nodes[i].degree );
        mxSetFieldByNumber(*v_nodes_mx, i, 0, mxIntPtr); 
        
        
        mxFloatPtr = mxCreateNumericMatrix(0,0,mxSINGLE_CLASS, mxREAL);
        mxSetM( mxFloatPtr, 1);
        mxSetN( mxFloatPtr, 1);
         mxSetData( mxFloatPtr, v_nodes[i].initial_value ); 
        mxSetFieldByNumber(*v_nodes_mx, i, 1, mxFloatPtr); 
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, *v_nodes[i].degree);
        mxSetData( mxIntPtr, v_nodes[i].index ); 
        mxSetFieldByNumber(*v_nodes_mx, i, 2, mxIntPtr); 
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, *v_nodes[i].degree);
         mxSetData( mxIntPtr, v_nodes[i].socket ); 
        mxSetFieldByNumber(*v_nodes_mx, i, 3, mxIntPtr); 
        
        mxFloatPtr = mxCreateNumericMatrix(0,0,mxSINGLE_CLASS, mxREAL);
        mxSetM( mxFloatPtr, 1);
        mxSetN( mxFloatPtr, *v_nodes[i].degree);
        mxSetData( mxFloatPtr, v_nodes[i].message ); 
        mxSetFieldByNumber(*v_nodes_mx, i, 4, mxFloatPtr); 
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, *v_nodes[i].degree);
        mxSetData( mxIntPtr, v_nodes[i].sign );
        mxSetFieldByNumber(*v_nodes_mx, i, 5, mxIntPtr ); 
        
    }
    
    
}


ConvertCnodeCStruct2MatStruct( c_node *c_nodes, int NumberParityBits, mxArray **c_nodes_mx ){
    int i;
    
    int num_fields = 4;
    const char *field_names[] = {"degree", "index", "message", "socket"};
    mwSize dims[2];
    
    mxArray *mxIntPtr;
    mxArray *mxFloatPtr;
    
    dims[0] = 1;
    dims[1] = NumberParityBits;
    
    *c_nodes_mx = mxCreateStructArray(2, dims, num_fields, field_names );
    
    for(i = 0; i < NumberParityBits; i++){
        
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, 1);
        
        mxSetData( mxIntPtr, c_nodes[i].degree );
        mxSetFieldByNumber(*c_nodes_mx, i, 0, mxIntPtr); 
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, *c_nodes[i].degree);
        mxSetData( mxIntPtr, c_nodes[i].index ); 
        mxSetFieldByNumber(*c_nodes_mx, i, 1, mxIntPtr); 
        
        mxFloatPtr = mxCreateNumericMatrix(0,0,mxSINGLE_CLASS, mxREAL);
        mxSetM( mxFloatPtr, 1);
        mxSetN( mxFloatPtr, *c_nodes[i].degree);
        mxSetData( mxFloatPtr, c_nodes[i].message ); 
        mxSetFieldByNumber(*c_nodes_mx, i, 2, mxFloatPtr);
        
        
        mxIntPtr = mxCreateNumericMatrix(0,0,mxINT32_CLASS, mxREAL);
        mxSetM( mxIntPtr, 1);
        mxSetN( mxIntPtr, *c_nodes[i].degree);
         mxSetData( mxIntPtr, c_nodes[i].socket ); 
        mxSetFieldByNumber(*c_nodes_mx, i, 3, mxIntPtr); 
        
        
    }
    
    
}


void CreateTannerGraph(const mxArray *CodeLength_mx, const mxArray *Row_one_mx, const mxArray *Col_one_mx,
        mxArray **c_nodes_mx, mxArray **v_nodes_mx){
    
    double *CodeLengthIn;
    int CodeLength;
    
    double *Row_one;
    int NumberParityBits;
    int max_row_weight;
    
    double *Col_one;
    int NumberCodeBits;
    int max_col_weight;
    
    
    v_node *v_nodes;
    c_node *c_nodes;
    
    
    /* deriving inputs */
    CodeLengthIn = mxGetPr( CodeLength_mx );
    CodeLength = (int) *CodeLengthIn;
    
    
    Row_one = mxGetPr( Row_one_mx );
    NumberParityBits = mxGetM( Row_one_mx );
    max_row_weight = mxGetN( Row_one_mx );
    
    Col_one = mxGetPr( Col_one_mx );  /* third input is H_cols matrix */
    NumberCodeBits   = mxGetM( Col_one_mx );
    max_col_weight = mxGetN( Col_one_mx );
    
    
    /* allocating memory */
    c_nodes = AllocCnodeStructMemory( NumberParityBits );
    SetCnodeDegree( c_nodes, NumberParityBits, Row_one, max_row_weight );
    AllocCnodeNodeMemory( c_nodes, NumberParityBits );
    
    v_nodes = AllocVnodeStructMemory( CodeLength );
    SetVnodeDegree( v_nodes, CodeLength, Col_one, max_col_weight, NumberCodeBits );
    AllocVnodeNodeMemory( v_nodes, CodeLength );
    
    /* create matlab structures */    
    ConvertVnodeCStruct2MatStruct( v_nodes, CodeLength, v_nodes_mx );
    ConvertCnodeCStruct2MatStruct( c_nodes, NumberParityBits, c_nodes_mx );
    
}


void mexFunction(int nlhs, mxArray *plhs[0],
        int nrhs, const mxArray *prhs[0] ){
    
    /* input to mex function */
    const mxArray *CodeLength_mx;
    const mxArray *Row_one_mx;
    const mxArray *Col_one_mx;
    
    /* output of mex function */
    mxArray *c_nodes_mx;
    mxArray *v_nodes_mx;
    
    CodeLength_mx = prhs[0];
    Row_one_mx = prhs[1];
    Col_one_mx = prhs[2];
    
    
    CreateTannerGraph(CodeLength_mx, Row_one_mx, Col_one_mx,
            &c_nodes_mx, &v_nodes_mx);
    
    
    /* pass tanner graph structures as output */
    plhs[0] = v_nodes_mx;
    plhs[1] = c_nodes_mx;
    
    
    return;
}