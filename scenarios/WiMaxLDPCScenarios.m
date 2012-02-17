% File WiMaxLDPCScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the LDPC code
% used by the IEEE 802.16e / Mobile-WiMax standard
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'WiMaxLDPC';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

MINBER = 1e-5;
num_errors = 60;

% L=2304, R=5/6
record = 1;
rate = '5/6'; 
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R5by6_L', int2str( sim_param(record).framesize), '_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:3 3.1:0.1:4];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=2304, R=3/4 A
record = 2;
rate = '3/4'; 
ind = '0'; %A
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R3by4_L', int2str( sim_param(record).framesize), 'A_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'A in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'A' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:2.4 2.5:0.1:3.5];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=2304, R=3/4 B
record = 3;
rate = '3/4'; 
ind = '1'; %B
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R3by4_L', int2str( sim_param(record).framesize), 'B_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'B in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'B' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:2.4 2.5:0.1:3.5];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r--';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=2304, R=2/3 A
record = 4;
rate = '2/3'; 
ind = '0'; %A
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R2by3_L', int2str( sim_param(record).framesize), 'A_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'A in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'A' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:1.6 1.7:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=2304, R=3/4 B
record = 5;
rate = '2/3'; 
ind = '1'; %B
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R2by3_L', int2str( sim_param(record).framesize), 'B_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'B in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'B');
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:1.6 1.7:0.1:3];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b--';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=2304, R=1/2
record = 6;
rate = '1/2'; 
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R1by2_L', int2str( sim_param(record).framesize), '_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:1 1.1:0.1:2];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 200;

% L=576, R=5/6
record = 7;
rate = '5/6'; 
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R5by6_L', int2str( sim_param(record).framesize), '_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=3/4 A
record = 8;
rate = '3/4'; 
ind = '0'; %A
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R3by4_L', int2str( sim_param(record).framesize), 'A_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'A in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'A' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=3/4 B
record = 9;
rate = '3/4'; 
ind = '1'; %B
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R3by4_L', int2str( sim_param(record).framesize), 'B_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'B in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'B' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r--';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=2/3 A
record = 10;
rate = '2/3'; 
ind = '0'; %A
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R2by3_L', int2str( sim_param(record).framesize), 'A_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'A in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'A' );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];;
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=3/4 B
record = 11;
rate = '2/3'; 
ind = '1'; %B
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R2by3_L', int2str( sim_param(record).framesize), 'B_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ',', ind, ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), 'B in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize), 'B');
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b--';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=1/2
record = 12;
rate = '1/2'; 
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R1by2_L', int2str( sim_param(record).framesize), '_AWGN_BPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ BPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;  % min sum
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=2304, R=1/2, MIN-SUM DECODING
record = 13;
rate = '1/2'; 
sim_param(record).framesize = 2304;
sim_param(record).filename = strcat( data_directory, 'R1by2_L', int2str( sim_param(record).framesize), '_AWGN_BPSK_MinSum.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ BPSK (MIN SUM)' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:1.6 1.7:0.1:2.5];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 1; % min-sum
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 400;

% L=576, R=1/2 and QPSK
record = 14;
rate = '1/2'; 
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R1by2_L', int2str( sim_param(record).framesize), '_AWGN_QPSK.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ QPSK' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [-1:0.2:6];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;  % sum-product
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% L=576, R=1/2 and 16-QAM
record = 15;
rate = '1/2'; 
sim_param(record).framesize = 576;
sim_param(record).filename = strcat( data_directory, 'R1by2_L', int2str( sim_param(record).framesize), '_AWGN_16QAM.mat');
sim_param(record).parity_check_matrix = strcat( 'InitializeWiMaxLDPC(', rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).comment =  strcat( 'r=', ' ', rate, ' L=', int2str( sim_param(record).framesize ), ' in AWGN w/ 16-QAM' );
sim_param(record).legend = strcat( 'r=', ' ', rate, ' L=', int2str(sim_param(record).framesize) );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).SNR = [0:4 4.2:0.2:10];
sim_param(record).SNR_type = 'Eb/No in dB';
 sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-';
sim_param(record).max_iterations = 100;
sim_param(record).decoder_type = 0;  % sum-product
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 250;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );