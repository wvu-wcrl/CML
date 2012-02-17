% File UmtsScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the turbo code
% used by the UMTS standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );
% determine where to store your files
base_name = 'UMTS';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% AWGN
record = 1;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 40 bits, max-log-MAP';
sim_param(record).SNR = 0:0.25:4.5;
sim_param(record).framesize = 40;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).plot_iterations = [1:8];
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 2;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 40 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.25:4.5;
sim_param(record).framesize = 40;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-7; 
sim_param(record).max_frame_errors = 205*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 3;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 40 bits, log-MAP';
sim_param(record).SNR = 0:0.25:6;
sim_param(record).framesize = 40;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 4;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 190 bits, max-log-MAP';
sim_param(record).SNR = 0:0.25:3.25;
sim_param(record).framesize = 190;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-7; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 5;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 190 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.25:3.25;
sim_param(record).framesize = 190;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-7; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 6;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 190 bits, log-MAP';
sim_param(record).SNR = 0:0.25:3.25;
sim_param(record).framesize = 190;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-7; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 7;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 530 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:2.2;
sim_param(record).framesize = 530;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1000001*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 8;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 530 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:2.2;
sim_param(record).framesize = 530;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 9;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 530 bits, log-MAP';
sim_param(record).SNR = 0:0.2:2.2;
sim_param(record).framesize = 530;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 10;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 640 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:2;
sim_param(record).framesize = 640;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 150*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 11;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 640 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:2;
sim_param(record).framesize = 640;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 12;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 640 bits, log-MAP';
sim_param(record).SNR = 0:0.2:4;
sim_param(record).framesize = 640;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 13;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 1060 bits, max-log-MAP';
sim_param(record).SNR = 0:0.15:1.8;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 14;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 1060 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.15:1.8;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 15;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 1060 bits, log-MAP';
sim_param(record).SNR = 0:0.15:1.8;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 16;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 2020 bits, max-log-MAP';
sim_param(record).SNR = 0:0.125:1.5;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 17;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 2020 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.125:1.5;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 18;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 2020 bits, log-MAP';
sim_param(record).SNR = 0:0.125:1.5;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 19;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 3460 bits, max-log-MAP';
sim_param(record).SNR = 0:0.1:1.2;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 20;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 3460 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.1:1.2;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 21;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 3460 bits, log-MAP';
sim_param(record).SNR = 0:0.1:1.2;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 22;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 5114 bits, max-log-MAP';
sim_param(record).SNR = 0:0.1:1.0;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 23;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 5114 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.1:1.0;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 24;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 5114 bits, log-MAP';
sim_param(record).SNR = 0:0.1:1.0;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

% Rayleigh
record = 25;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 40 bits, max-log-MAP';
sim_param(record).SNR = 0:0.5:6;
sim_param(record).framesize = 40;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 26;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 40 bits, constant-log-MAP';
sim_param(record).SNR =  0:0.5:6;
sim_param(record).framesize = 40;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 27;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 40 bits, log-MAP';
sim_param(record).SNR =  0:0.5:6;
sim_param(record).framesize = 40;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 28;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 190 bits, max-log-MAP';
sim_param(record).SNR = 0:0.25:5;
sim_param(record).framesize = 190;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 29;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 190 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.25:5;
sim_param(record).framesize = 190;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 30;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 190 bits, log-MAP';
sim_param(record).SNR = 0:0.25:5;
sim_param(record).framesize = 190;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 9;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 31;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 530 bits, max-log-MAP';
sim_param(record).SNR = 0:0.25:4;
sim_param(record).framesize = 530;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 32;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 530 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.25:4;
sim_param(record).framesize = 530;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 33;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 530 bits, log-MAP';
sim_param(record).SNR = 0:0.25:4;
sim_param(record).framesize = 530;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 34;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 640 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 640;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 35;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 640 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 640;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 36;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 640 bits, log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 640;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 10;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 37;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 1060 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:2.6;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 38;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 1060 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:2.4;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 39;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 1060 bits, log-MAP';
sim_param(record).SNR = 0:0.2:2.4;
sim_param(record).framesize = 1060;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 11;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 40;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 2020 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 41;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 2020 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 42;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 2020 bits, log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 2020;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 43;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 3460 bits, max-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 44;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 3460 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 45;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 3460 bits, log-MAP';
sim_param(record).SNR = 0:0.2:3;
sim_param(record).framesize = 3460;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 13;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 46;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 5114 bits, max-log-MAP';
sim_param(record).SNR = 0:0.15:2.4;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 47;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 5114 bits, constant-log-MAP';
sim_param(record).SNR = 0:0.15:2.4;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 2;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 40*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 48;
sim_param(record).comment = 'UMTS-TC, BPSK, Rayleigh, 5114 bits, log-MAP';
sim_param(record).SNR = 0:0.15:2.4;
sim_param(record).framesize = 5114;
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(50000/sim_param(record).framesize);

record = 49;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 1360 bits, log-MAP';
sim_param(record).SNR = 0:0.15:5;
sim_param(record).framesize = 1360;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 50;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 1600 bits, log-MAP';
sim_param(record).SNR = 0:0.15:5;
sim_param(record).framesize = 1600;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 51;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 150 bits, log-MAP';
sim_param(record).SNR = -2:0.25:10;
sim_param(record).framesize = 150;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 52;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, 360 bits, log-MAP';
sim_param(record).SNR = 0:0.25:10;
sim_param(record).framesize = 360;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-8; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

record = 53;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, rate 2048/3840';
sim_param(record).SNR = 0:0.25:10;
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).plot_iterations = [1:12];
sim_param(record).linetype = 'm:';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), 'rate8by15.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 30*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);
% these are only required because they are defined in the other records
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );

record = 54;
sim_param(record).comment = 'UMTS-TC, QPSK, AWGN, 150 bits, log-MAP';
sim_param(record).SNR = -2:0.25:10;
sim_param(record).framesize = 150;
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 3;
sim_param(record).max_iterations = 12;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).plot_iterations = [1:12];
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'umts', int2str(sim_param(record).framesize ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '_qpsk.mat') );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 30*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = ceil(511400/sim_param(record).framesize);

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
