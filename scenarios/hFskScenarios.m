% File FskScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for CPFSK modulation.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'fsk';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

num_errors = 30;
BER = 8e-6;

dt16 = [0 7 9 14 3 4 10 13 6 1 15 8 5 2 12 11];
alt16 =[0 9 13 4 5 12 8 1 11 2 6 15 14 7 3 10];
    
% BICM-ID: Turbo coded 8FSK modulation in AWGN w/ BICM-ID: mv mapping
record = 1;
sim_param(record).comment = 'reverse-dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_mv_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN w/ BICM-ID: dt mapping
record = 2;
sim_param(record).comment = 'dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_dt_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN w/ BICM-ID: natural mapping
record = 3;
sim_param(record).comment = 'natural mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_natural_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN w/ BICM-ID: reverse gray mapping
record = 4;
sim_param(record).comment = 'reverse-gray mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_reversegray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN w/ BICM-ID: gray mapping 
record = 5;
sim_param(record).comment = 'gray mapped 8 CPFSK bicm-id';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_gray_bicmid_corrected.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in AWGN: mv mapping
record = 6;
sim_param(record).comment = 'mv mapped 8 CPFSK bicm';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:8 8.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'm:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_mv_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in AWGN: dt mapping
record = 7;
sim_param(record).comment = 'dt mapped 8 CPFSK bicm';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:8 8.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_dt_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in AWGN: natural mapping
record = 8;
sim_param(record).comment = 'natural mapped 8 CPFSK bicm';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:6 6.5:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_natural_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN: reverse gray mapping
record = 9;
sim_param(record).comment = 'reverse gray mapped 8 CPFSK bicm';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'g:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_reversegray_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in AWGN: gray mapping and bicm
record = 10;
sim_param(record).comment = 'gray mapped 8 CPFSK bicm';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_AWGN_gray_bicm_corrected.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Convolutionally coded 8FSK modulation in AWGN: mv mapping
record = 11;
sim_param(record).comment = 'reverse-dt mapping, r=1/2 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_mv_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in AWGN: dt mapping
record = 12;
sim_param(record).comment = 'dt mapping, r=1/2 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_dt_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in AWGN: natural mapping
record = 13;
sim_param(record).comment = 'natural mapping, r=1/2 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.25:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_natural_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in AWGN: reverse gray mapping
record = 14;
sim_param(record).comment = 'reverse-gray mapping, r=1/2 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.25:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_reversegray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in AWGN: gray mapping
record = 15;
sim_param(record).comment = 'gray mapping, r=1/2 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.25:0.25:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_gray_bicmid_corrected.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in AWGN: mv mapping, rate 8/15
record = 16;
sim_param(record).comment = 'reverse-dt mapping, r=8/15 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_mv_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in AWGN: dt mapping
record = 17;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_dt_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in AWGN: natural mapping
record = 18;
sim_param(record).comment = 'natural mapping, r=8/15 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_natural_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in AWGN: reverse gray mapping
record = 19;
sim_param(record).comment = 'reverse-gray mapping, r=8/15 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_reversegray_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in AWGN: gray mapping
record = 20;
sim_param(record).comment = 'gray mapping, r=8/15 CC, K = 7, q=8, h=0.32, AWGN';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_gray_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K = 4) 8FSK modulation in AWGN: mv mapping
record = 21;
sim_param(record).comment = 'reverse-dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_mv_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in AWGN: dt mapping
record = 22;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, AWGN';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_dt_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in AWGN: natural mapping
record = 23;
sim_param(record).comment = 'natural mapping, r=8/15 CC, K = 4, q=8, h=0.32, AWGN';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_natural_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in AWGN: reverse gray mapping
record = 24;
sim_param(record).comment = 'reverse-gray mapping, r=8/15 CC, K = 4, q=8, h=0.32, AWGN';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_reversegray_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in AWGN: gray mapping
record = 25;
sim_param(record).comment = 'gray mapping, r=8/15 CC, K = 4, q=8, h=0.32, AWGN';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_AWGN_gray_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM-ID: Turbo coded 8FSK modulation in Fading w/ BICM-ID: mv mapping
record = 26;
sim_param(record).comment = 'reverse-dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_mv_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading w/ BICM-ID: dt mapping
record = 27;
sim_param(record).comment = 'dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = 8; %sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_dt_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading w/ BICM-ID: natural mapping
record = 28;
sim_param(record).comment = 'natural mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_natural_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading w/ BICM-ID: reverse gray mapping
record = 29;
sim_param(record).comment = 'reverse-gray mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayeleigh_reversegray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading w/ BICM-ID: gray mapping 
record = 30;
sim_param(record).comment = 'gray mapped 8 CPFSK bicm-id';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.1:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = 8; %sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_gray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in Fading: mv mapping
record = 31;
sim_param(record).comment = 'mv mapped 8 CPFSK bicm';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:8 8.1:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'm:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_mv_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in Fading: dt mapping
record = 32;
sim_param(record).comment = 'dt mapped 8 CPFSK bicm';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:8 8.1:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_dt_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Turbo coded 8FSK modulation in Fading: natural mapping
record = 33;
sim_param(record).comment = 'natural mapped 8 CPFSK bicm';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'r:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_natural_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading: reverse gray mapping
record = 34;
sim_param(record).comment = 'reverse gray mapped 8 CPFSK bicm';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'g:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_reversegray_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 8FSK modulation in Fading: gray mapping and bicm
record = 35;
sim_param(record).comment = 'gray mapped 8 CPFSK bicm';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS
sim_param(record).SNR = [0:5 5.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_r2048by3840_Rayleigh_gray_bicm.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER; 
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Convolutionally coded 8FSK modulation in Fading: mv mapping
record = 36;
sim_param(record).comment = 'reverse-dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.5:0.5:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_mv_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in Fading: dt mapping
record = 37;
sim_param(record).comment = 'dt mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.5:0.5:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_dt_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in Fading: natural mapping
record = 38;
sim_param(record).comment = 'natural mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.5:0.5:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_natural_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in Fading: reverse gray mapping
record = 39;
sim_param(record).comment = 'reverse-gray mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.5:0.5:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_reversegray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in Fading: gray mapping
record = 40;
sim_param(record).comment = 'gray mapping';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.5:0.5:6 6.5:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_gray_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 8FSK modulation in Fading: mv mapping, rate 8/15
record = 41;
sim_param(record).comment = 'reverse-dt mapping, r=8/15 CC, K = 7, q=8, h=0.32, Fading';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_mv_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in Fading: dt mapping
record = 42;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 7, q=8, h=0.32, Fading';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_dt_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = 8; %[1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in Fading: natural mapping
record = 43;
sim_param(record).comment = 'natural mapping, r=8/15 CC, K = 7, q=8, h=0.32, Fading';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_natural_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in Fading: reverse gray mapping
record = 44;
sim_param(record).comment = 'reverse-gray mapping, r=8/15 CC, K = 7, q=8, h=0.32, Fading';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_reversegray_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15) 8FSK modulation in Fading: gray mapping
record = 45;
sim_param(record).comment = 'gray mapping, r=8/15 CC, K = 7, q=8, h=0.32, Fading';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_gray_bicmid_8r15.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K = 4) 8FSK modulation in Fading: mv mapping
record = 46;
sim_param(record).comment = 'reverse-dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'reverse-dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_mv_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: dt mapping
record = 47;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_dt_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = 8; %[1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: natural mapping
record = 48;
sim_param(record).comment = 'natural mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_natural_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: reverse gray mapping
record = 49;
sim_param(record).comment = 'reverse-gray mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'reverse-gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:15];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5];
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_reversegray_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;  
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: gray mapping
record = 50;
sim_param(record).comment = 'gray mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:4 4.2:0.1:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_gray_bicmid_8r15_K4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 8];

% Old 16-FSK results ... still need to determine optimal h and R
% BICM: Convolutionally coded 16FSK modulation in AWGN: reverse gray mapping
record = 51;
sim_param(record).comment = 'reverse gray mapped 16 CPFSK convolutional';
sim_param(record).legend = 'alternate mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:0.4:6.8 6.9:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = [0 1 3 2 7 6 4 5 15 14 12 13 8 9 11 10];
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h032_convolutional_AWGN_reversegray_bicmid_corrected.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 16FSK modulation in AWGN: natural mapping
record = 52;
sim_param(record).comment = 'natural mapped 16 CPFSK convolutional';
sim_param(record).legend = 'natural mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:0.4:4.4 4.5:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h032_convolutional_AWGN_natural_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 16FSK modulation in AWGN: dt mapping
record = 53;
sim_param(record).comment = 'dt mapped 16 CPFSK convolutional';
sim_param(record).legend = 'dt mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:0.4:6.8 6.9:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h032_convolutional_AWGN_dt_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = 45*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 16FSK modulation in AWGN: gray mapping
record = 54;
sim_param(record).comment = 'gray mapped 16 CPFSK convolutional';
sim_param(record).legend = 'gray mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:0.4:6.8 6.9:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h032_convolutional_AWGN_gray_bicmid_corrected.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded 16FSK modulation in AWGN: mv mapping
record = 55;
sim_param(record).comment = 'mv mapping';
sim_param(record).legend = 'mv mapping';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:0.4:3 3.2:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'mv';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 8;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h032_convolutional_AWGN_mv_bicmid.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;
sim_param(record).plot_iterations = [1 8];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: dt mapping
% Large Interleaver
record = 56;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'dt mapping (100k)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:3 3.9:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100e3;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm--';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 30;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_dt_bicmid_8r15_K4_100k.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 30];

% BICM: Convolutionally coded (r=8/15, K=4) 8FSK modulation in Fading: dt mapping
% Moderate Interleaver
record = 57;
sim_param(record).comment = 'dt mapping, r=8/15 CC, K = 4, q=8, h=0.32, Fading';
sim_param(record).legend = 'dt mapping (20k)';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [0:3 3.9:0.1:12];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 20e3;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.32;
sim_param(record).mapping = 'dt';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'm-';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [1 1 1 1 1 1 1 0
    1 1 1 1 1 1 1 1 ];
sim_param(record).tail_pattern1 = ones(2,length(sim_param(record).g1)-1);
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 30;
sim_param(record).filename = strcat( data_directory, 'CPFSK8_h032_convolutional_Rayleigh_dt_bicmid_8r15_K4_20k.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 20];

% BICM-ID: Convolutionally coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% dt mapping and 2048 bit interleaver
record = 58;
sim_param(record).comment = 'tv mapping, r=1/2 CC, K=4, q=16, h=0.21, Fading';
sim_param(record).legend = 'tv CC';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = dt16;
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_convolutional_Rayleigh_dt_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [5 10 20];

% BICM-ID: Convolutionally coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% gray mapping and 2048 bit interleaver
record = 59;
sim_param(record).comment = 'gray mapping, r=1/2 CC, K=4, q=16, h=0.21, Fading';
sim_param(record).legend = 'gray CC';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'r-';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_convolutional_Rayleigh_gray_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [5 10 20];

% BICM-ID: Convolutionally coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% natural mapping and 2048 bit interleaver
record = 60;
sim_param(record).comment = 'natural mapping, r=1/2 CC, K=4, q=16, h=0.21, Fading';
sim_param(record).legend = 'natural CC';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = 'natural';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k-';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_convolutional_Rayleigh_natural_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [5 10 20];

% BICM-ID: Turbo coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% tvmapping and 2048 bit interleaver
record = 61;
sim_param(record).comment = 'tv mapping, r=1/2 TC, q=16, h=0.21, Fading';
sim_param(record).legend = 'tv turbo';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS turbo
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 2*2048; % rate 1/2
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = dt16;
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_turbo_Rayleigh_dt_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [20];

% BICM-ID: Turbo coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% gray mapping and 2048 bit interleaver
record = 62;
sim_param(record).comment = 'gray mapping, r=1/2 TC, q=16, h=0.21, Fading';
sim_param(record).legend = 'gray turbo';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 4; % UMTS turbo
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 2*2048; % rate 1/2
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = 'gray';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_turbo_Rayleigh_gray_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [20];


% BICM-ID: Convolutionally coded (r=1/2, K=3) 16FSK modulation (h=0.21) in Fading: 
% dt mapping and 2048 bit interleaver
record = 63;
sim_param(record).comment = 'tv mapping, r=1/2 CC, K=3, q=16, h=0.21, Fading';
sim_param(record).legend = 'tv CC';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = dt16;
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).g1 = [1 1 1
    1 0 1];
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_convolutional_Rayleigh_dt_bicmid_1r2_K3_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 20];

% BICM-ID: Convolutionally coded (r=1/2, K=4) 16FSK modulation (h=0.21) in Fading: 
% alt mapping and 2048 bit interleaver
record = 64;
sim_param(record).comment = 'alt mapping, r=1/2 CC, K=4, q=16, h=0.21, Fading';
sim_param(record).legend = 'alt CC';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0; % Convolutional
sim_param(record).SNR = [2:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 2048;
sim_param(record).modulation = 'FSK';
sim_param(record).h = 0.21;
sim_param(record).mapping = alt16;
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % noncoherent w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % linear-log-MAP
sim_param(record).linetype = 'g-';
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type =  0;  % linear-log-MAP
sim_param(record).max_iterations = 20;
sim_param(record).filename = strcat( data_directory, 'CPFSK16_h021_convolutional_Rayleigh_alt_bicmid_1r2_K4_2048.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = BER;    
sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).plot_iterations = [1 20];