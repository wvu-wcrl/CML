% File CapacityScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% These simulations compute EXIT charts for the digital-network-coded
%  two-way relay channel.
%
% Last updated on 11/17/2012

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'exittwrc';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory );
end

trials=10;

% EXIT analysis in AWGN
% 2-FSK
record = 1;
sim_param(record).comment = 'EXIT analysis - detector characteristic';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 32400;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 4;
sim_param(record).csi_flag = 1;
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'exit_1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.exit_phase = 'detector';  % detector characteristic
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.requested_IA = 0.1:0.1:0.9;
sim_param(record).MaxRunTime = 3*60;
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';







record = 2;
sim_param(record).comment = 'EXIT analysis of 16-QAM in AWGN';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 32400;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'exit_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.exit_phase = 'decoder';  % decoder characteristic
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.dv = [2 4 19];
sim_param(record).exit_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).exit_param.dc = 11;
sim_param(record).exit_param.requested_IA = 0.1:0.1:0.9;
sim_param(record).exit_param.det_scenario = 'ExitTWRC';
sim_param(record).exit_param.det_record = 1;
sim_param(record).MaxRunTime = 3*60;






% EXIT analysis in AWGN
% 2-FSK
record = 3;
sim_param(record).comment = 'EXIT analysis - detector characteristic';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 32400;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 4;
sim_param(record).csi_flag = 1;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'exit_3.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.exit_phase = 'detector';  % detector characteristic
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.requested_IA = 0.1:0.1:0.9;
sim_param(record).MaxRunTime = 3*60;
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';







record = 4;
sim_param(record).comment = 'EXIT analysis of 16-QAM in AWGN';
sim_param(record).sim_type = 'exit';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 32400;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 4;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'exit_4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).exit_param.exit_type = 'ldpc';
sim_param(record).exit_param.exit_phase = 'decoder';  % decoder characteristic
sim_param(record).exit_param.rate = 0.6;
sim_param(record).exit_param.dv = [2 4 19];
sim_param(record).exit_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).exit_param.dc = 11;
sim_param(record).exit_param.requested_IA = 0.1:0.1:0.9;
sim_param(record).exit_param.det_scenario = 'ExitTWRC';
sim_param(record).exit_param.det_record = 3;
sim_param(record).MaxRunTime = 3*60;






