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

trials=100;

% CM capacity in AWGN
% BPSK
record = 1;
sim_param(record).comment = 'Capacity of BPSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% QPSK
record = 2;
sim_param(record).comment = 'CM capcity of QPSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSK.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 3;
sim_param(record).comment = 'CM capacity of 16-QAM in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 4;
sim_param(record).comment = 'CM capacity of 16-HEX in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'HEX';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'c-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HEX16CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 250*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 5;
sim_param(record).comment = 'CM capacity of 16-APSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'APSK';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'APSK16CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 250*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 6;
sim_param(record).comment = 'CM capacity of 32-QAM in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 32;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM32CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 7;
sim_param(record).comment = 'CM capacity of 32-APSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'APSK';
sim_param(record).mod_order = 32;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'APSK32CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 250*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% BICM capacity in AWGN
% BPSK
record = 8;
sim_param(record).comment = 'BICM Capacity of BPSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 4; % does not matter for binary modulation
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BPSK_BICM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 9;
sim_param(record).comment = 'BICM capacity of 16-QAM in AWGN w/ gray labeling';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 4;
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16BICMAWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 350*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 10;
sim_param(record).comment = 'BICM capacity of 16-QAM in AWGN w/ SP';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 4;
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16BICMAWGN_SP.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 350*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 11;
sim_param(record).comment = 'BICM capacity of 16-APSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'APSK';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 4; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'APSK16BICMAWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 200*ones( 1, length(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% Capacity in Rayleigh fading
record = 12;
sim_param(record).comment = 'Ergodic Capacity of BPSK in Rayleigh fading';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-30:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BPSKRayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 13;
sim_param(record).comment = 'Ergodic CM Capacity of QPSK in Rayleigh fading';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-30:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = [];
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSKRayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

record = 14;
sim_param(record).comment = 'Ergodic CM Capacity of 16-QAM in Rayleigh fading';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-30:0.5:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16CMRayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 100*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% BICM Capacity of HSDPA's QPSK in AWGN
% New on Dec. 17, 2005
record = 15;
sim_param(record).comment = 'BICM capcity of QPSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'HSDPA';
sim_param(record).mod_order = 4;
sim_param(record).mapping = [];
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; 
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSK_BICM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 250*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 25;

record = 16;
sim_param(record).comment = 'CM capacity of 64-QAM in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 1000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM64CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 17;
sim_param(record).comment = 'BICM capacity of 16-QAM in AWGN w/ SP';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 4;
sim_param(record).linetype = 'bx';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16BICMAWGN_SP_rerun.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 40*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 18;
sim_param(record).comment = 'CM capacity of 8-PSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'PSK';
sim_param(record).mod_order = 8;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'PSK8CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 19;
sim_param(record).comment = 'CM capacity of 16-PSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'PSK';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'PSK16CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 20;
sim_param(record).comment = 'CM capacity of 32-PSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'PSK';
sim_param(record).mod_order = 32;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'PSK32CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 21;
sim_param(record).comment = 'CM capacity of 64-PSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'PSK';
sim_param(record).mod_order = 64;
sim_param(record).mapping = 'gray'; % does not matter if not BICM
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 4; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'PSK64CM.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = trials*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );