% test_ldpc_decoder.m
%
%  Complete test of LDPC decoder class for three BICM decoding iterations.
%
%  The following decoder functions are demonstrated:
%   1. Instantiate LDPC decoder object
%   2. Create Tanner Graph
%   3. Initialize LDPC decoder state
%   4. Perform decoding iteration 

clear all;


% set paths 
home_dir = pwd;
cd ..; cd ..; cd src;
cls_dir = pwd;
cd mex;
cmex_dir = pwd;

addpath(cls_dir);
addpath(cmex_dir);

cd(home_dir);


% make cmex files
cd(cmex_dir); make; cd(home_dir);


% load test state - H_rows and H_cols captured from DVBS2Scenarios, record
% 1
load test_input.mat
[row_one col_one] = PostProcessH( code_param.H_rows, code_param.H_cols );
CodeLength = length( input_decoder_c );





% instantiate LDPC decoder
ldpc_decoder = LdpcDecoder();


% create tanner graph
ldpc_decoder = ldpc_decoder.CreateTannerGraph(row_one, col_one, CodeLength);


% initialize decoder state
ldpc_decoder = ldpc_decoder.InitState( input_decoder_c );


% iterate
[ldpc_decoder output_decoder_c detected_data] = ldpc_decoder.Iterate( input_decoder_c, 1 );

[ldpc_decoder output_decoder_c detected_data] = ldpc_decoder.Iterate( input_decoder_c, 2 );

[ldpc_decoder output_decoder_c detected_data] = ldpc_decoder.Iterate( input_decoder_c, 3 );
