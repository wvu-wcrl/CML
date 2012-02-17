% File ConvolutionalScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for convolutional codes.
%
% Last updated on Oct. 12, 2007

% determine where to store your files
base_name = 'convolutional';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

% determine where your root directory is
load( 'CmlHome.mat' );
full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% Convolutional codes w/ BICM
record = 1;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ BPSK in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 2;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ gray-coded QAM in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_QAMgray.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 205*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 3;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ SP-QAM in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:13];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_QAMsp.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 151*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% Convlutional codes with BICM-ID
record = 4;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ SP-coded QAM in AWGN w/ BICM-ID';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:3 4:0.1:6 6.25:0.25:7 7.5:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; %BICM-ID
sim_param(record).max_iterations = 10;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_QAMsp_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 70*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10];
sim_param(record).save_rate = 50;

record = 5;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ gray-coded QAM in AWGN w/ BICM-ID';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; %BICM-ID
sim_param(record).max_iterations = 10;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_QAMgray_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 61*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10];
sim_param(record).save_rate = 50;

record = 6;
sim_param(record).comment = 'Rate 2/3 K=7 NSC convolutional code w/ SP-coded QAM in AWGN w/ BICM-ID';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:5 5.1:0.1:6 6.25:0.25:14];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; %BICM-ID
sim_param(record).max_iterations = 10;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).tail_pattern1 = ones(2,6);
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'convR2by3K7AWGN_QAMsp_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 61*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10];
sim_param(record).save_rate = 50;

% Viterbi Decoding (NSC)
record = 7;
sim_param(record).comment = 'Rate 1/2 K=7 NSC convolutional code w/ BPSK in AWGN';
sim_param(record).legend = 'Viterbi decoding (NSC)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0;
sim_param(record).linetype = 'r:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  -1;  % Viterbi
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_Viterbi.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% Viterbi Decoding (RSC)
record = 8;
sim_param(record).comment = 'Rate 1/2 K=7 RSC convolutional code w/ BPSK in AWGN';
sim_param(record).legend = 'Viterbi decoding (RSC)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0;  
sim_param(record).linetype = 'b:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 0;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'convR1by2K7AWGN_Viterbi_RSC.mat');
sim_param(record).reset = 1;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% UMTS convolutional code (rate 1/2)
record = 9;
sim_param(record).comment = 'Rate 1/2 K=9 NSC convolutional code w/ BPSK in AWGN';
sim_param(record).legend = 'K= 9 Viterbi decoding (NSC)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 504; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0;
sim_param(record).linetype = 'r:';
sim_param(record).g1 = [1 0 1 1 1 0 0 0 1
    1 1 1 1 0 1 0 1 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  -1;  % Viterbi
sim_param(record).filename = strcat( data_directory, 'UMTSconvR1by2K9AWGN_Viterbi.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6;
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR));
sim_param(record).save_rate = 50;

% convolutional code (rate 1/2)
record = 10;
sim_param(record).comment = 'Rate 1/2 K=3 NSC convolutional code w/ BPSK in AWGN';
sim_param(record).legend = 'K =3 Viterbi decoding (NSC)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 504; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0;
sim_param(record).linetype = 'k-';
sim_param(record).g1 = [1 0 1
                        1 1 1 ];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  -1;  % Viterbi
sim_param(record).filename = strcat( data_directory, 'convR1by2K3AWGN_Viterbi.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6;
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR));
sim_param(record).save_rate = 50;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );