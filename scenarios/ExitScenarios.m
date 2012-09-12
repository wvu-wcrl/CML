% File CapacityScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the Shannon capacity
% under modulation constraints.
%
% Last updated on July 4, 2006

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'capacity';
if ispc
    data_directory = strcat( cml_home, '\output\', base_name, '\' );
else
    data_directory = strcat( cml_home, '/output/', base_name, '/' );
end
if ~exist( data_directory, 'dir' )
    mkdir(data_directory);
end

trials=10;

% EXIT analysis in AWGN
% QPSK
record = 1;
sim_param(record).comment = 'EXIT analysis of QPSK in AWGN';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [0 5 8 10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800;
sim_param(record).modulation = 'PSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.dv = [2 4 19];
sim_param(record).exit_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).exit_param.dc = 11;
sim_param(record).exit_param.requested_IA = 0.1:0.1:0.9;


record = 2;
sim_param(record).comment = 'EXIT analysis of 16-QAM in AWGN';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16_irr.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).mapping = [ 8, 13, 12, 9, 15, 10, 11, 14, 4, 1, 0, 5, 3, 6, 7, 2];
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.dv = [2 4 19];
sim_param(record).exit_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).exit_param.dc = 11;
sim_param(record).exit_param.requested_IA = 0.999*(0:01/(101-1):1)+0.0001;



record = 3;
sim_param(record).comment = 'EXIT analysis of 16-QAM in AWGN';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16_irr.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).mapping = [ 8, 13, 12, 9, 15, 10, 11, 14, 4, 1, 0, 5, 3, 6, 7, 2];
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.rate = 0.5;
sim_param(record).exit_param.dv = [10 ];
sim_param(record).exit_param.dv_dist = [ 1 ];
sim_param(record).exit_param.dc = 20;
sim_param(record).exit_param.requested_IA = 0.999*(0:01/(101-1):1)+0.0001;

