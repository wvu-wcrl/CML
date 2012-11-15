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
base_name = 'TestNewLdpcImpl';
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
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [50:0.1:60];
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
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_newimpl.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;




% Short
record = 2;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'old';   % test new ldpc implementation
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
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_oldimpl.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;




% Short
record = 3;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [50:0.1:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 10;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_newimpl_bicm2_highsnr.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;



record = 4;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 10;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_newimpl_bicm2_lowsnr.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;




record = 5;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'old';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).max_iterations = 10;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_oldimpl_bicm1_lowsnr.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;


record = 6;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 10;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_newimpl_bicm2_lowsnr_bugfix1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;



record = 7;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ BPSK in AWGN' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).max_iterations = 10;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_BPSK_newimpl_bicm1_lowsnr_bugfix1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;





record = 8;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ 16FSK in AWGN BICM' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).csi_flag = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_16FSK_newimpl_bicm1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 100*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;




record = 9;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).comment = strcat( 'Rate= ', ' ', effective_rate, ' short DVB-S2 LDPC code w/ 16FSK in AWGN BICMID' );
sim_param(record).legend = strcat( 'Short r=', ' ', effective_rate );
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % test new ldpc implementation
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).csi_flag = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'DVBS2shortRate1by4_16FSK_newimpl_bicm2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 100*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;