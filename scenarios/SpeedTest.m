% File SpeedTest
%
% These simulations are used to test 
% with and without coding.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'SpeedTest';
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
sim_param(record).comment = 'short running test for functionality';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 't_bersim_1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 3*60; 
sim_param(record).timing_sample_rate = 30;


record = 2;
sim_param(record).comment = 'moderate length test for timing test';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:7];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 't_bersim_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 3*60; 
sim_param(record).timing_sample_rate = 30; 


record = 3;
sim_param(record).comment = 'UMTS-TC, BPSK, AWGN, rate 2048/3840';
sim_param(record).SNR = 0:0.25:25;
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
sim_param(record).filename = 't_BerSim_3.mat';
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
sim_param(record).MaxRunTime = 3*60; 
sim_param(record).timing_sample_rate = 30;
