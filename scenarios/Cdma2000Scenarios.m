% File Cdma2000Scenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the turbo code
% used by the cdma2000 standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'cdma2000';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end


record = 1;
sim_param(record).comment = 'Rate 1/4 cdma2000 turbo code w/ BPSK in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = []; % the intereleaver determines the framesize
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = 'load(''imap12282'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1
    1 1 ];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k12282rate1by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10 16];
sim_param(record).save_rate = 20;

record = 2;
sim_param(record).comment = 'Rate 1/4 cdma2000 turbo code w/ gray coded 16-QAM in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = []; % the intereleaver determines the framesize
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = 'load(''imap12282'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1
    1 1 ];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k12282rate1by4_QAMgray.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10 16];
sim_param(record).save_rate = 20;

record = 3;
sim_param(record).comment = 'Rate 1/4 cdma2000 turbo code w/ SP-16-QAM in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:0.1:7];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = []; % the intereleaver determines the framesize
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = 'load(''imap12282'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1
    1 1 ];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k12282rate1by4_QAMsp.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10 16];
sim_param(record).save_rate = 20;

% turbo BICM-ID
record = 4;
sim_param(record).comment = 'Rate 1/4 cdma2000 turbo code w/ SP-16-QAM in AWGN w/ BICM-ID';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:0.1:6];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = []; % the intereleaver determines the framesize
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = 'load(''imap12282'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1
    1 1 ];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k12282rate1by4_QAMsp_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 51*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = [1 2 5 10 16];
sim_param(record).save_rate = 20;

record = 5;
sim_param(record).comment = 'Rate 1/5, length 1530 cdma2000 turbo code w/ BPSK in AWGN';
sim_param(record).legend = 'r=1/5,k=1530';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).code_interleaver = 'load(''imap1530'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1
    1 1 ];
sim_param(record).tail_pattern1 = [3 3 3 
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k1530rate1by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 5e-6;  
sim_param(record).max_frame_errors = 51*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 1e3;

record = 6;
sim_param(record).comment = 'Rate 1/4, length 1530 cdma2000 turbo code w/ BPSK in AWGN';
sim_param(record).legend = 'r=1/4,k=1530';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r:';
sim_param(record).code_interleaver = 'load(''imap1530'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1
    1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1
    1 1 ];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k1530rate1by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 5e-6;  
sim_param(record).max_frame_errors = 51*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 1e3;

record = 7;
sim_param(record).comment = 'Rate 1/3, length 1530 cdma2000 turbo code w/ BPSK in AWGN';
sim_param(record).legend = 'r=1/3,k=1530';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).code_interleaver = 'load(''imap1530'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1];
sim_param(record).tail_pattern1 = [2 2 2
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k1530rate1by3_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 5e-6;  
sim_param(record).max_frame_errors = 51*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 1e3;

record = 8;
sim_param(record).comment = 'Rate 1/2, length 1530 cdma2000 turbo code w/ BPSK in AWGN';
sim_param(record).legend = 'r=1/2,k=1530';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).code_interleaver = 'load(''imap1530'')';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).max_iterations = 16;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'cdma2k1530rate1by2_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 5e-6;  
sim_param(record).max_frame_errors = 51*ones( 1, length(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 1e3;



% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );