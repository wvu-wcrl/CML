% File BlockcodeScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for cyclic block codes,
% with APP decoding.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'blockcode';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% A cyclic block code is a rate 1 convolutional code with trellis
% termination
record = 1; % don't change this record number
sim_param(record).comment = '(23,12) Nonsystematic Golay code';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 12; % This is k
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % does not matter for BPSK
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 0 1 1 1 0 0 0 1 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type = 0; % log-MAP decoding (i.e. APP)
% sim_param(record).filename = strcat( data_directory, 'GolayAWGN.mat');
sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 2e-5; 
sim_param(record).max_frame_errors = 301*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e3;

% (23,12) Golay code in systematic form
record = 2;  % don't change this record number
sim_param(record).comment = '(23,12) Systematic Golay code';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 12;  % This is k
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % does not matter for BPSK
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 0 1 1 1 0 0 0 1 1];
sim_param(record).nsc_flag1 = 0;
sim_param(record).decoder_type = 0; % log-MAP decoding (i.e. APP)
% sim_param(record).filename = strcat( data_directory, 'GolaySystematicAWGN.mat');
sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 2e-5;  
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e3;

record = 3; % don't change this record number
sim_param(record).comment = '(15,10) Nonsystematic Expurgated Hamming code';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10; % This is k
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % does not matter for BPSK
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 0 1 1] ;
sim_param(record).nsc_flag1 = 1;
sim_param(record).decoder_type = 0; % log-MAP decoding (i.e. APP)
%sim_param(record).filename = strcat( data_directory, 'HammingAWGN.mat');
sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 2e-5;  
sim_param(record).max_frame_errors = 301*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e3;

record = 4; % don't change this record number
sim_param(record).comment = '(15,10) Systematic Expurgated Hamming code';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10; % This is k
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % does not matter for BPSK
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).g1 = [1 0 1 0 1 1] ;
sim_param(record).nsc_flag1 = 0;
sim_param(record).decoder_type = 0; % log-MAP decoding (i.e. APP)
% sim_param(record).filename = strcat( data_directory, 'BluetoothAWGN.mat');
sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 2e-5;  
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e3;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.


