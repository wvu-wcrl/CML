% File TailbitingScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for tail-biting convolutional codes.
%
% Last updated on May 22, 2008

% determine where to store your files
base_name = 'tailbiting';
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

MINBER = 1e-5;  % 1e-5
MAXTRIALS = 1e9;  
MAXERRORS = 160;  % 100
SAVERATE = 1e5;

% QAM mappings
mapping_16 = [13  9  1  5 ...
              12  8  0  4 ...
              14 10  2  6 ...
              15 11  3  7];
          
mapping_64 = [59 51 35 43 11  3 19 27 ...
              58 50 34 42 10  2 18 26 ...
              56 48 32 40  8  0 16 24 ...
              57 49 33 41  9  1 17 25 ...
              61 53 37 45 13  5 21 29 ...
              60 52 36 44 12  4 20 28 ...
              62 54 38 46 14  6 22 30 ...
              63 55 39 47 15  7 23 31];

% Rate 1/2, QPSK, 6 Bytes, depth 0
record = 1;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 0';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 0;      % tb decoding wrap depth
sim_param(record).linetype = 'm--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth0.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 1
record = 2;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 1';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 1;      % tb decoding wrap depth
sim_param(record).linetype = 'b--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 2
record = 3;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 2';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 2;      % tb decoding wrap depth
sim_param(record).linetype = 'r--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 3
record = 4;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 3';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 3;      % tb decoding wrap depth
sim_param(record).linetype = 'c--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth3.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 4
record = 5;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 4';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 4;      % tb decoding wrap depth
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 5
record = 6;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 5';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 5;      % tb decoding wrap depth
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth5.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 6
record = 7;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 7
record = 8;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 7';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 7;      % tb decoding wrap depth
sim_param(record).linetype = 'c-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth7.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 6 Bytes, depth 8
record = 9;
sim_param(record).comment = 'Rate 1/2, QPSK, 6 Bytes, depth 8';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 6*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 8;      % tb decoding wrap depth
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_6bytes_AWGN_depth8.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 12 Bytes, depth 6
record = 10;
sim_param(record).comment = 'Rate 1/2, QPSK, 12 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 12*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_12bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 18 Bytes, depth 6
record = 11;
sim_param(record).comment = 'Rate 1/2, QPSK, 18 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 18*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_18bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 24 Bytes, depth 6
record = 12;
sim_param(record).comment = 'Rate 1/2, QPSK, 24 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 24*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'c-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_24bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 30 Bytes, depth 6
record = 13;
sim_param(record).comment = 'Rate 1/2, QPSK, 30 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 30*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'g-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_30bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, QPSK, 36 Bytes, depth 6
record = 14;
sim_param(record).comment = 'Rate 1/2, QPSK, 36 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 36*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_QPSK_36bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, 16-QAM, 12 Bytes, depth 6
record = 15;
sim_param(record).comment = 'Rate 1/2, 16-QAM, 12 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 12*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'b--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_16QAM_12bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, 16-QAM, 24 Bytes, depth 6
record = 16;
sim_param(record).comment = 'Rate 1/2, 16-QAM, 24 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 24*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'c--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_16QAM_24bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, 16-QAM, 36 Bytes, depth 6
record = 17;
sim_param(record).comment = 'Rate 1/2, 16-QAM, 36 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 36*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'k--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_16QAM_36bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, 64-QAM, 18 Bytes, depth 6
record = 18;
sim_param(record).comment = 'Rate 1/2, 64-QAM, 18 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 18*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_64QAM_18bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 1/2, 64-QAM, 36 Bytes, depth 6
record = 19;
sim_param(record).comment = 'Rate 1/2, 64-QAM, 36 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 36*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate1by2_64QAM_36bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 2/3, 64-QAM, 24 Bytes, depth 6
record = 20;
sim_param(record).comment = 'Rate 2/3, 64-QAM, 24 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:14];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 24*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'c:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0
    1 1];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate2by3_64QAM_24bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, QPSK, 9 Bytes, depth 6
record = 21;
sim_param(record).comment = 'Rate 3/4, QPSK, 9 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 9*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'r-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_QPSK_9bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, QPSK, 18 Bytes, depth 6
record = 22;
sim_param(record).comment = 'Rate 3/4, QPSK, 18 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 18*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'm-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_QPSK_18bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, QPSK, 27 Bytes, depth 6
record = 23;
sim_param(record).comment = 'Rate 3/4, QPSK, 27 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 27*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'c-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_QPSK_27bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, QPSK, 36 Bytes, depth 6
record = 24;
sim_param(record).comment = 'Rate 3/4, QPSK, 36 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 36*8; 
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'k-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_QPSK_36bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, 16-QAM, 18 Bytes, depth 6
record = 25;
sim_param(record).comment = 'Rate 3/4, 16-QAM, 18 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 18*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'm--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_16QAM_18bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, 16-QAM, 36 Bytes, depth 6
record = 26;
sim_param(record).comment = 'Rate 3/4, 16-QAM, 36 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 36*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'k-*';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_16QAM_36bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% Rate 3/4, 64-QAM, 27 Bytes, depth 6
record = 27;
sim_param(record).comment = 'Rate 3/4, 64-QAM, 27 Bytes, depth 6';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.25:18];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 27*8; 
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).depth = 6;      % tb decoding wrap depth
sim_param(record).linetype = 'g:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 1 1 1 0 0 1
    1 0 1 1 0 1 1 ];
sim_param(record).nsc_flag1 = 2;  % 2 for tail-biting
sim_param(record).pun_pattern1 = [1 0 1
    1 1 0];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = -1; % Viterbi
sim_param(record).filename = strcat( data_directory, 'tb_rate3by4_64QAM_27bytes_AWGN_depth6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = SAVERATE;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );