% File CcsdsScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the turbo code
% used by the CCSDS standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'CCSDS';
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
sim_param(record).comment = 'CCSDS, r=1/2, K=1784';
sim_param(record).framesize = 1784;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 0 1 0];
sim_param(record).tail_pattern2 = [0 0 0 0
    0 1 0 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 2;
sim_param(record).comment = 'CCSDS, r=1/3, K=1784';
sim_param(record).framesize = 1784;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1 ];
sim_param(record).pun_pattern2= [0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 3;
sim_param(record).comment = 'CCSDS, r=1/4, K=1784';
sim_param(record).framesize = 1784;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    0
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    0 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    0 0 0 0
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    0 0 0 0];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 4;
sim_param(record).comment = 'CCSDS, r=1/6, K=1784';
sim_param(record).framesize = 1784;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 5;
sim_param(record).comment = 'CCSDS, r=1/2, K=3568';
sim_param(record).framesize = 3568;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 0 1 0];
sim_param(record).tail_pattern2 = [0 0 0 0
    0 1 0 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 6;
sim_param(record).comment = 'CCSDS, r=1/3, K=3568';
sim_param(record).framesize = 3568;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1 ];
sim_param(record).pun_pattern2= [0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 7;
sim_param(record).comment = 'CCSDS, r=1/4, K=3568';
sim_param(record).framesize = 3568;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    0
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    0 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    0 0 0 0
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    0 0 0 0];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 8;
sim_param(record).comment = 'CCSDS, r=1/6, K=3568';
sim_param(record).framesize = 3568;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 9;
sim_param(record).comment = 'CCSDS, r=1/2, K=7136';
sim_param(record).framesize = 7136;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 0 1 0];
sim_param(record).tail_pattern2 = [0 0 0 0
    0 1 0 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 10;
sim_param(record).comment = 'CCSDS, r=1/3, K=7136';
sim_param(record).framesize = 7136;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1 ];
sim_param(record).pun_pattern2= [0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 11;
sim_param(record).comment = 'CCSDS, r=1/4, K=7136';
sim_param(record).framesize = 7136;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    0
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    0 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    0 0 0 0
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    0 0 0 0];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 12;
sim_param(record).comment = 'CCSDS, r=1/6, K=7136';
sim_param(record).framesize = 7136;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 13;
sim_param(record).comment = 'CCSDS, r=1/2, K=8920';
sim_param(record).framesize = 8920;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 0];
sim_param(record).pun_pattern2= [0 0
    0 1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 0 1 0];
sim_param(record).tail_pattern2 = [0 0 0 0
    0 1 0 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 14;
sim_param(record).comment = 'CCSDS, r=1/3, K=8920';
sim_param(record).framesize = 8920;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1 ];
sim_param(record).pun_pattern2= [0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 15;
sim_param(record).comment = 'CCSDS, r=1/4, K=8920';
sim_param(record).framesize = 8920;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    0
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    0 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    0 0 0 0
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    0 0 0 0];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 16;
sim_param(record).comment = 'CCSDS, r=1/6, K=8920';
sim_param(record).framesize = 8920;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [-1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).code_interleaver = ...
    strcat( 'CreateCcsdsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 0 1 1
    1 1 0 1 1
    1 0 1 0 1
    1 1 1 1 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 
    1
    1
    1 ];
sim_param(record).pun_pattern2= [0 
    1 
    0 
    1 ];
sim_param(record).tail_pattern1 = [1 1 1 1
    1 1 1 1
    1 1 1 1
    1 1 1 1];
sim_param(record).tail_pattern2 = [0 0 0 0
    1 1 1 1
    0 0 0 0
    1 1 1 1];
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'CCSDSrate1by', ...
    int2str( floor( ( sum( sum( sim_param(record).pun_pattern1 ) ) + sum( sum( sim_param(record).pun_pattern2) ) )/size(sim_param(record).pun_pattern1,2) ) ), ...
    sim_param(record).channel, int2str( sim_param(record).framesize), '.mat' );
sim_param(record).reset = 0;;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name,
% int2str(record), '.mat' );