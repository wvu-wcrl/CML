% File UncodedScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for uncoded modulation.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'uncoded';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% uncoded modulation in AWGN
record = 1;
sim_param(record).comment = 'Uncoded BPSK in AWGN';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:11];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BPSKAWGN.mat');
sim_param(record).reset = 1;
sim_param(record).max_trials = 100000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 60*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;

record = 2;
sim_param(record).comment = 'Uncoded QPSK in AWGN';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:11];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSKAWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 210*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 3;
sim_param(record).comment = 'Uncoded 16-QAM in AWGN w/ gray labeling';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 220*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 4;
sim_param(record).comment = 'Uncoded 16-QAM in AWGN w/ SP';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'SP';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16AWGN_SP.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 170*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 5;
sim_param(record).comment = 'Uncoded 16-HEX in AWGN';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'HEX';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'c:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HEX16AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 205*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 6;
sim_param(record).comment = 'Uncoded 16-APSK in AWGN';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'APSK';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'APSK16AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% uncoded in Rayleigh fading
record = 7;
sim_param(record).comment = 'Uncoded BPSK in Rayleigh fading';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).mapping = [];
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'g-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BPSKRayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 60*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 8;
sim_param(record).comment = 'Uncoded QPSK in Rayleigh fading';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QPSK';
sim_param(record).mod_order = 4;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QPSKRayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 9;
sim_param(record).comment = 'Uncoded 16-QAM in Rayleigh fading';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM16Rayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 205*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 10;
sim_param(record).comment = 'Uncoded 16-HEX in Rayleigh fading';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'HEX';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'c-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HEX16Rayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 205*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 11;
sim_param(record).comment = 'Uncoded 16-APSK in Rayleigh fading';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:60];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 100000;
sim_param(record).modulation = 'APSK';
sim_param(record).mod_order = 16;
sim_param(record).mapping = 'quasigray';
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'APSK16Rayleigh.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 10000*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

record = 12;
sim_param(record).comment = 'Uncoded 64-QAM in AWGN w/ gray labeling';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 1e4;
sim_param(record).modulation = 'QAM';
sim_param(record).mod_order = 64;
sim_param(record).mapping = 'gray';
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'QAM64AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e5*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 20*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );