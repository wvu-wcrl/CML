% File DVBS2Scenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the LDPC code
% used by the DVB-S2 standard
%
% Last updated on July 4, 2006

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'DVBS2';
if ispc
    data_directory = strcat( cml_home, '\output\', base_name, '\' );
else
    data_directory = strcat( cml_home, '/output/', base_name, '/' );
end
if ~exist( data_directory, 'dir' )
    mkdir(data_directory);
end

MINBER = 1e-5;

% Short
record = 1;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 2;
effective_rate = '1/4'; 
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate1by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 3;
effective_rate = '1/3'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by3_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 4;
effective_rate = '1/3'; 
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate1by3_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 5;
effective_rate = '2/5'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate2by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 6;
effective_rate = '2/5'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate2by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 7;
effective_rate = '1/2'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-0.5:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by2_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 8;
effective_rate = '1/2'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-0.5:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate1by2_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 9;
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate3by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 10;
effective_rate = '3/5'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate3by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 11;
effective_rate = '2/3'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate2by3_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 12;
effective_rate = '2/3'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r:';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate2by3_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 13;
effective_rate = '3/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k--';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate3by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 14;
effective_rate = '3/4'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-.';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate3by4_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 15;
effective_rate = '4/5'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0.5:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm--';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate4by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 16;
effective_rate = '4/5'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0.5:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-.';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate4by5_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 17;
effective_rate = '5/6'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [1:0.1:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g--';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate5by6_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 18;
effective_rate = '5/6'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [1:0.1:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-.';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate5by6_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Short
record = 19;
effective_rate = '8/9'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [1.5:0.1:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b--';
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate8by9_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 20;
effective_rate = '8/9'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [1.5:0.1:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-.';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate8by9_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

% Long
record = 21;
effective_rate = '9/10'; 
sim_param(record).comment = strcat( 'Rate=', ' ', effective_rate, ' long DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [1.5:0.1:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-.';
sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2longRate9by10_BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;

  % Long with QPSK
  record = 22;
  effective_rate = '1/4'; 
  sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' long DVB-S2 LDPC code w/ QPSK in AWGN' );
  sim_param(record).sim_type = 'coded';
  sim_param(record).code_configuration = 2; % LDPC
  sim_param(record).SNR = [-1.5:0.5:-0.5];
  sim_param(record).SNR_type = 'Eb/No in dB';
  sim_param(record).framesize = 64800; 
  sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
  sim_param(record).modulation = 'QPSK';
  sim_param(record).mod_order = 4;
  sim_param(record).channel = 'AWGN';
  sim_param(record).bicm = 0;
  sim_param(record).demod_type = 0; 
  sim_param(record).linetype = 'k:';
  sim_param(record).legend = strcat( 'Long r=', ' ', effective_rate );
  sim_param(record).max_iterations = 100;
  sim_param(record).decoder_type = 0;
  sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
  sim_param(record).reset = 0;
  sim_param(record).max_trials = 1e6*ones( size(sim_param(record).SNR) );
  sim_param(record).minBER = 1e-6; 
  sim_param(record).max_frame_errors = 100*ones( size(sim_param(record).SNR) );
  sim_param(record).plot_iterations = sim_param(record).max_iterations;
  % uncomment the line below to see performance after 1,10,50, and 100 iterations
  % sim_param(record).plot_iterations = [1 10 50 sim_param(record).max_iterations];
  sim_param(record).save_rate = 5;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );