% File WiMaxLDPCScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the convolutional turbo
% code used by the mobile WiMAX standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'WiMaxCTC';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

MINBER = 3e-6;
num_errors = 200;
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
              

% (12,6) QPSK
record = 1;
sim_param(record).framesize = 6*8;
sim_param(record).code_bits_per_frame = 12*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize); % save every million data bits
sim_param(record).linetype = 'k-';

% (24,12) QPSK
record = 2;
sim_param(record).framesize = 12*8;
sim_param(record).code_bits_per_frame = 24*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (36,18) QPSK
record = 3;
sim_param(record).framesize = 18*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (48,24) QPSK
record = 4;
sim_param(record).framesize = 24*8;
sim_param(record).code_bits_per_frame = 48*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (60,30) QPSK
record = 5;
sim_param(record).framesize = 30*8;
sim_param(record).code_bits_per_frame = 60*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (72,36) QPSK
record = 6;
sim_param(record).framesize = 36*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (96,48) QPSK
record = 7;
sim_param(record).framesize = 48*8;
sim_param(record).code_bits_per_frame = 96*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (108,54) QPSK
record = 8;
sim_param(record).framesize = 54*8;
sim_param(record).code_bits_per_frame = 108*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (120,60) QPSK
record = 9;
sim_param(record).framesize = 60*8;
sim_param(record).code_bits_per_frame = 120*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k-';

% (12,9) QPSK (rate 3/4)
record = 10;
sim_param(record).framesize = 9*8;
sim_param(record).code_bits_per_frame = 12*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.5:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (24,18) QPSK (rate 3/4)
record = 11;
sim_param(record).framesize = 18*8;
sim_param(record).code_bits_per_frame = 24*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (36,27) QPSK (rate 3/4)
record = 12;
sim_param(record).framesize = 27*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (48,36) QPSK (rate 3/4)
record = 13;
sim_param(record).framesize = 36*8;
sim_param(record).code_bits_per_frame = 48*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (60,45) QPSK (rate 3/4)
record = 14;
sim_param(record).framesize = 45*8;
sim_param(record).code_bits_per_frame = 60*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (72,54) QPSK (rate 3/4)
record = 15;
sim_param(record).framesize = 54*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
    int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'k--';

% (24,12) 16-QAM
record = 16;
sim_param(record).framesize = 12*8;
sim_param(record).code_bits_per_frame = 24*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r-';

% (48,24) 16-QAM
record = 17;
sim_param(record).framesize = 24*8;
sim_param(record).code_bits_per_frame = 48*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r-';

% (72,36) 16-QAM
record = 18;
sim_param(record).framesize = 36*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r-';

% (96,48) 16-QAM
record = 19;
sim_param(record).framesize = 48*8;
sim_param(record).code_bits_per_frame = 96*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r-';

% (120,60) 16-QAM
record = 20;
sim_param(record).framesize = 60*8;
sim_param(record).code_bits_per_frame = 120*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r-';

% (24,18) 16-QAM
record = 21;
sim_param(record).framesize = 18*8;
sim_param(record).code_bits_per_frame = 24*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r--';

% (48,36) 16-QAM
record = 22;
sim_param(record).framesize = 36*8;
sim_param(record).code_bits_per_frame = 48*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r--';

% (72,54) 16-QAM
record = 23;
sim_param(record).framesize = 54*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = mapping_16;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'r--';

% (36,18) 64-QAM
record = 24;
sim_param(record).framesize = 18*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b-';

% (72,36) 64-QAM
record = 25;
sim_param(record).framesize = 36*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b-';

% (108,54) 64-QAM
record = 26;
sim_param(record).framesize = 54*8;
sim_param(record).code_bits_per_frame = 108*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b-';

% (36,24) 64-QAM (rate 2/3)
record = 27;
sim_param(record).framesize = 24*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b:';

% (72,48) 64-QAM (rate 2/3)
record = 28;
sim_param(record).framesize = 48*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b:';

% (36,27) 64-QAM (rate 3/4)
record = 29;
sim_param(record).framesize = 27*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:13];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b--';

% (72,54) 64-QAM (rate 3/4)
record = 30;
sim_param(record).framesize = 54*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b--';

% (36,30) 64-QAM (rate 5/6)
record = 31;
sim_param(record).framesize = 30*8;
sim_param(record).code_bits_per_frame = 36*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.25:14];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b-.';

% (72,60) 64-QAM (rate 5/6)
record = 32;
sim_param(record).framesize = 60*8;
sim_param(record).code_bits_per_frame = 72*8;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = mapping_64;
sim_param(record).channel = 'AWGN';
sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, '.mat');
sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/8, sim_param(record).framesize/8, ...
    sim_param(record).modulation, sim_param(record).channel  );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 5; % Wimax CTC
sim_param(record).SNR = [0:0.2:13];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % linear-log-MAP demapper
sim_param(record).decoder_type = 0; % linear-log-MAP demapper
sim_param(record).max_iterations = 10;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = floor(1e6/sim_param(record).framesize);
sim_param(record).linetype = 'b-.';

% now repeat using the max-log-MAP algorithm
record_offset = 32;
for record=1:32
    sim_param(record+record_offset) = sim_param(record);
    sim_param(record+record_offset).decoder_type = 1;
    sim_param(record+record_offset).filename = strcat( data_directory, sim_param(record).modulation, int2str( sim_param(record).mod_order), ...
    'N', int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
    sim_param(record).channel, 'MAXLOG.mat');  
    sim_param(record+record_offset).linetype = strcat( sim_param(record).linetype, '+' );    
end
    
    


% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );