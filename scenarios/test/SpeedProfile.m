% File SpeedProfile
%
% These simulations are used to perform
% speed comparisons between standalone and cluster
% cml.
%
%
%  = Description of Tests=
%  Record      Description
%  1           short running ( < 20s )test for functionality
%  2           moderate running ( ~ x min ) test
%  3           long running ( ~ x min ) test
%  4           conv code, K=7
%  5           conv code, K=9
%  6           single high SNR, high trials
%
% Last updated on 10 22 2012



% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'SpeedProfile';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% short running test for functionality
record = 1;
sim_param(record).comment = 'short runtime. test for functionality';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:5];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 30;
sim_param(record).ProfileSpeed = 1;


% moderate length for timing test
record = 2;
sim_param(record).comment = 'moderate runtime';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:70];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-7; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 60; 
sim_param(record).ProfileSpeed = 1;


% long length for timing test
record = 3;
sim_param(record).comment = 'long runtime. turbo code';
sim_param(record).SNR = 0:0.25:50;
sim_param(record).framesize = 2048;
sim_param(record).code_bits_per_frame = 3840;
sim_param(record).channel = 'Rayleigh';
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
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_3.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones(size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6;
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
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 60;
sim_param(record).ProfileSpeed = 1;


% convolutional code
record = 4;
sim_param(record).comment = 'long runtime. NSC, R=1/2, K=7';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 60;
sim_param(record).ProfileSpeed = 1;



% convolutional code
record = 5;
sim_param(record).comment = 'long runtime.  NSC, R=1/2, K=9';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [ 1 0 1 1 1 0 0 0 1
   1 1 1 1 0 1 0 1 1 ];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_5.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 60;
sim_param(record).ProfileSpeed = 1;



% convolutional code
record = 6;
sim_param(record).comment = 'long runtime.  NSC, R=1/2, K=9';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [70];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114; 
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [ 1 0 1 1 1 0 0 0 1
   1 1 1 1 0 1 0 1 1 ];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'SpeedProfile_6.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e13*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-20; 
sim_param(record).max_frame_errors = 3000*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).MaxRunTime = 60; 
sim_param(record).timing_sample_rate = 60;
sim_param(record).ProfileSpeed = 1;
