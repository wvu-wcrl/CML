% File HsdpaScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the turbo code
% used by the UMTS/HSDPA standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'HSDPA';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end


% AWGN, H-SET 1, First block, QPSK
record = 1;
sim_param(record).comment = 'HSET-1 in AWGN with QPSK and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -4:0.2:6;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKawgn1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0];
sim_param(record).P = 5;

% AWGN, H-SET 1, Second block, QPSK
record = 2;
sim_param(record).comment = 'HSET-1 in AWGN with QPSK and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:6;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKawgn2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2];
sim_param(record).P = 5;

% AWGN, H-SET 1, Third block, QPSK
record = 3;
sim_param(record).comment = 'HSET-1 in AWGN with QPSK and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:6;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKawgn3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5];
sim_param(record).P = 5;

% AWGN, H-SET 1, Fourth block, QPSK
record = 4;
sim_param(record).comment = 'HSET-1 in AWGN with QPSK and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:6;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKawgn4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5 6];
sim_param(record).P = 5;

% AWGN, H-SET 1, First block, QAM
record = 5;
sim_param(record).comment = 'HSET-1 in AWGN with QAM and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMawgn1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6];
sim_param(record).P = 4;

% AWGN, H-SET 1, Second block, QAM
record = 6;
sim_param(record).comment = 'HSET-1 in AWGN with QAM and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMawgn2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2];
sim_param(record).P = 4;

% AWGN, H-SET 1, Third block, QAM
record = 7;
sim_param(record).comment = 'HSET-1 in AWGN with QAM and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMawgn3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1];
sim_param(record).P = 4;

% AWGN, H-SET 1, Fourth block, QAM
record = 8;
sim_param(record).comment = 'HSET-1 in AWGN with QAM and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMawgn4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1 5];
sim_param(record).P = 4;


% Fading, H-SET 1, First block, QPSK
record = 9;
sim_param(record).comment = 'HSET-1 in ergodic fading with QPSK and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKfade1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0];
sim_param(record).P = 5;

% Fading, H-SET 1, Second block, QPSK
record = 10;
sim_param(record).comment = 'HSET-1 in ergodic fading with QPSK and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKfade2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2];
sim_param(record).P = 5;

% Fading, H-SET 1, Third block, QPSK
record = 11;
sim_param(record).comment = 'HSET-1 in ergodic fading with QPSK and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKfade3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5];
sim_param(record).P = 5;

% Fading, H-SET 1, Fourth block, QPSK
record = 12;
sim_param(record).comment = 'HSET-1 in ergodic fading with QPSK and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QPSKfade4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5 6];
sim_param(record).P = 5;

% Fading, H-SET 1, First block, QAM
record = 13;
sim_param(record).comment = 'HSET-1 in ergodic fading with QAM and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMfade1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6];
sim_param(record).P = 4;

% Fading, H-SET 1, Second block, QAM
record = 14;
sim_param(record).comment = 'HSET-1 in ergodic fading with QAM and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMfade2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2];
sim_param(record).P = 4;

% Fading, H-SET 1, Third block, QAM
record = 15;
sim_param(record).comment = 'HSET-1 in ergodic fading with QAM and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMfade3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1];
sim_param(record).P = 4;

% Fading, H-SET 1, Fourth block, QAM
record = 16;
sim_param(record).comment = 'HSET-1 in ergodic fading with QAM and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1;
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset1QAMfade4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 45*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1 5];
sim_param(record).P = 4;

% AWGN, H-SET 6, First block, QPSK
record = 17;
sim_param(record).comment = 'HSET-6 in AWGN with QPSK and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKawgn1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0];
sim_param(record).P = 5;

% AWGN, H-SET 6, Second block, QPSK
record = 18;
sim_param(record).comment = 'HSET-6 in AWGN with QPSK and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKawgn2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2];
sim_param(record).P = 5;

% AWGN, H-SET 6, Third block, QPSK
record = 19;
sim_param(record).comment = 'HSET-6 in AWGN with QPSK and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKawgn3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5];
sim_param(record).P = 5;

% AWGN, H-SET 6, Fourth block, QPSK
record = 20;
sim_param(record).comment = 'HSET-6 in AWGN with QPSK and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKawgn4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5 6];
sim_param(record).P = 5;

% AWGN, H-SET 6, First block, QAM
record = 21;
sim_param(record).comment = 'HSET-6 in AWGN with QAM and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMawgn1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6];
sim_param(record).P = 4;

% AWGN, H-SET 6, Second block, QAM
record = 22;
sim_param(record).comment = 'HSET-6 in AWGN with QAM and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMawgn2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2];
sim_param(record).P = 4;

% AWGN, H-SET 6, Third block, QAM
record = 23;
sim_param(record).comment = 'HSET-6 in AWGN with QAM and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMawgn3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1];
sim_param(record).P = 4;

% AWGN, H-SET 6, Fourth block, QAM
record = 24;
sim_param(record).comment = 'HSET-6 in AWGN with QAM and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMawgn4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1 5];
sim_param(record).P = 4;

% Fading, H-SET 6, First block, QPSK
record = 25;
sim_param(record).comment = 'HSET-6 in ergodic fading with QPSK and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKfade1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0];
sim_param(record).P = 5;

% Fading, H-SET 6, Second block, QPSK
record = 26;
sim_param(record).comment = 'HSET-6 in ergodic fading with QPSK and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKfade2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2];
sim_param(record).P = 5;

% Fading, H-SET 6, Third block, QPSK
record = 27;
sim_param(record).comment = 'HSET-6 in ergodic fading with QPSK and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKfade3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5];
sim_param(record).P = 5;

% Fading, H-SET 6, Fourth block, QPSK
record = 28;
sim_param(record).comment = 'HSET-6 in ergodic fading with QPSK and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -5:0.1:10;
sim_param(record).framesize = 6438; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QPSKfade4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [0 2 5 6];
sim_param(record).P = 5;

% Fading, H-SET 6, First block, QAM
record = 29;
sim_param(record).comment = 'HSET-6 in ergodic fading with QAM and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMfade1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6];
sim_param(record).P = 4;

% Fading, H-SET 6, Second block, QAM
record = 30;
sim_param(record).comment = 'HSET-6 in ergodic fading with QAM and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMfade2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2];
sim_param(record).P = 4;

% Fading, H-SET 6, Third block, QAM
record = 31;
sim_param(record).comment = 'HSET-6 in ergodic fading with QAM and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMfade3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1];
sim_param(record).P = 4;

% Fading, H-SET 6, Second block, QAM
record = 32;
sim_param(record).comment = 'HSET-6 in ergodic fading with QAM and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:14;
sim_param(record).framesize = 9377; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'Rayleigh';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 14;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset6QAMfade4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1 5];
sim_param(record).P = 4;

% Block fading, H-SET 1, First block, QPSK
record = 33;
sim_param(record).comment = 'HSET-1 in block fading with QPSK (First block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QPSK1block.mat' );
sim_param(record).X_set = [0];
sim_param(record).linetype = 'k-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 5;

% Block fading, H-SET 1, Second block, QPSK
record = 34;
sim_param(record).comment = 'HSET-1 in block fading with QPSK (Second block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QPSK2block.mat' );
sim_param(record).X_set = [0 2];
sim_param(record).linetype = 'r-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 5;

% Block fading, H-SET 1, Third block, QPSK
record = 35;
sim_param(record).comment = 'HSET-1 in block fading with QPSK (Third block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QPSK3block.mat' );
sim_param(record).X_set = [0 2 5];
sim_param(record).linetype = 'b-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 5;

% Block fading, H-SET 1, Fourth block, QPSK
record = 36;
sim_param(record).comment = 'HSET-1 in block fading with QPSK (Fourth block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QPSK4block.mat' );
sim_param(record).X_set = [0 2 5 6];
sim_param(record).linetype = 'm-';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 3202; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 5;

% AWGN, QPSK, rate 7/8
record = 37;
sim_param(record).comment = 'Rate 7/8 QPSK in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.1:10;
sim_param(record).framesize = 5040; % size of data, not including the CRC
sim_param(record).mod_order = 4; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 0;
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSKRate7by8AWGN.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 55*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 15204;
sim_param(record).X_set = [0];
sim_param(record).P = 6;

% AWGN, 16-QAM, rate 7/16
record = 38;
sim_param(record).comment = 'Rate 7/16 QAM in AWGN';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.1:10;
sim_param(record).framesize = 5040; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 0;
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r-';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAMRate7by16AWGN.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 30*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 15204;
sim_param(record).X_set = [6];
sim_param(record).P = 6;

% Block fading, H-SET 1, First block, QAM
record = 39;
sim_param(record).comment = 'HSET-1 in block fading with QAM (First block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QAM1block.mat' );
sim_param(record).X_set = [6];
sim_param(record).linetype = 'k:';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 4;

% Block fading, H-SET 1, Second block, QAM
record = 40;
sim_param(record).comment = 'HSET-1 in block fading with QAM (Second block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QAM2block.mat' );
sim_param(record).X_set = [6 2];
sim_param(record).linetype = 'r:';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 4;

% Block fading, H-SET 1, Third block, QAM
record = 41;
sim_param(record).comment = 'HSET-1 in block fading with QAM (Third block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QAM3block.mat' );
sim_param(record).X_set = [6 2 1];
sim_param(record).linetype = 'b:';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 4;

% Block fading, H-SET 1, Fourth block, QAM
record = 42;
sim_param(record).comment = 'HSET-1 in block fading with QAM (Fourth block)';
sim_param(record).filename = strcat( data_directory, 'Hset1QAM4block.mat' );
sim_param(record).X_set = [6 2 1 5];
sim_param(record).linetype = 'm:';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -10:30;
sim_param(record).framesize = 4664; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'block';
sim_param(record).decoder_type = 0; % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-3; 
sim_param(record).max_frame_errors = 1.3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;      
sim_param(record).N_IR = 9600;
sim_param(record).blocks_per_frame = length( sim_param(record).X_set );
sim_param(record).P = 4;

% AWGN, H-SET 7, First block, QAM
record = 43;
sim_param(record).comment = 'HSET-7 in AWGN with QAM and max-log-MAP decoding (First block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 14411; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'k:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset7QAMawgn1block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6];
sim_param(record).P = 4; % this is per turbo codeword

% AWGN, H-SET 7, Second block, QAM
record = 44;
sim_param(record).comment = 'HSET-7 in AWGN with QAM and max-log-MAP decoding (Second block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 14411; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'r:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset7QAMawgn2block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2];
sim_param(record).P = 4;

% AWGN, H-SET 7, Third block, QAM
record = 45;
sim_param(record).comment = 'HSET-7 in AWGN with QAM and max-log-MAP decoding (Third block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 14411; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'b:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset7QAMawgn3block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1];
sim_param(record).P = 4;

% AWGN, H-SET 7, Fourth block, QAM
record = 46;
sim_param(record).comment = 'HSET-7 in AWGN with QAM and max-log-MAP decoding (Fourth block)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 3; % HSDPA
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).SNR = -1:0.1:10;
sim_param(record).framesize = 14411; % size of data, not including the CRC
sim_param(record).mod_order = 16; % Can be 4 or 16
sim_param(record).channel = 'awgn';
sim_param(record).decoder_type = 1; % max-log-map
sim_param(record).max_iterations = 8;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).linetype = 'm:';
sim_param(record).demod_type = 0; 
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Hset7QAMawgn4block.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 50*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
% HSDPA specific parameters
sim_param(record).N_IR = 9600;
sim_param(record).X_set = [6 2 1 5];
sim_param(record).P = 4;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );