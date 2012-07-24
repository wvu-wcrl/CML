% File FskScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for FSK modulation
% with and without coding.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 't_bersim';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% uncoded 8NFSK modulation in AWGN
record = 1;
sim_param(record).comment = 'Uncoded 8-NFSK in AWGN (CSI), local';
sim_param(record).SimLocation = 'local';
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
sim_param(record).max_sim_time = 5;


record = 2;
sim_param(record).comment = 'Uncoded 8-NFSK in AWGN (CSI), cluster';
sim_param(record).SimLocation = 'cluster';
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
sim_param(record).filename = strcat( data_directory, 't_bersim_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).max_sim_time = 1;
