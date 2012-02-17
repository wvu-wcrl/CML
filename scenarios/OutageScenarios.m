% File OutageScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the information outage
% probability - independent Rayleigh-faded blocks
%
% NOTE: - In order to run OutageScenarios under modulation contraints, 
%       the desired modulation should have been simulated in an AWGN 
%       channel using the CML Library, (i.e. run
%       [sim_param, sim_state] = CmlSimulate( 'CapacityScenarios', record_no)
%       where the record_no is for the desired modulation )
%       - Use the filename that was entered in the previous record as the 
%         input_filename for the 'OutageScenarios' simulation record.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'outage';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
    % where are the AWGN capacity curves? (changed on Oct. 12, 2007 to relative)
    data_directory_input = strcat( '\output\capacity\');
else
    data_directory = strcat( '/output/', base_name, '/' );
    % where are the AWGN capacity curves? (changed on Oct. 12, 2007 to relative)
    data_directory_input = strcat( '/output/capacity/');
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end



% 2-D UGI, R=2, L=1
record = 1;
sim_param(record).comment = '2-D UGI, CC, r = 2, L = 1';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL1r2.mat');
sim_param(record).linetype = 'r:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, R=2, L=2
record = 2;
sim_param(record).comment = '2-D UGI, CC, r = 2, L = 2';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL2r2.mat');
sim_param(record).linetype = 'b:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, R=2, L=3
record = 3;
sim_param(record).comment = '2-D UGI, CC, r = 2, L = 3';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL3r2.mat');
sim_param(record).linetype = 'k:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, R=2, L=4
record = 4;
sim_param(record).comment = '2-D UGI, CC, r = 2, L = 4';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL4r2.mat');
sim_param(record).linetype = 'c:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, R=2, L=10
record = 5;
sim_param(record).comment = '2-D UGI, CC, r = 2, L = 10';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 10;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL10r2.mat');
sim_param(record).linetype = 'm:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D gray-coded 16QAM, R=2, L=1
record = 6;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 2, L = 1';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL1r2.mat');
sim_param(record).linetype = 'r-.+';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D gray-coded 16QAM, R=2, L=2
record = 7;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 2, L = 2';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL2r2.mat');
sim_param(record).linetype = 'b-.+';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D gray-coded 16QAM, R=2, L=3
record = 8;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 2, L = 3';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL3r2.mat');
sim_param(record).linetype = 'k-.+';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D gray-coded 16QAM, R=2, L=4
record = 9;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 2, L = 4';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL4r2.mat');
sim_param(record).linetype = 'c-.+';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D gray-coded 16QAM, R=2, L=10
record = 10;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 2, L = 10';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 10;
sim_param(record).rate = 2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL10r2.mat');
sim_param(record).linetype = 'm-.+';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:50];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 3e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, R=3.5, L=1
record = 11;
sim_param(record).comment = '2-D UGI, CC, r = 3.5, L = 1';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL1r7by2.mat');
sim_param(record).linetype = 'r:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 1e-4;
sim_param(record).trial_size = 1000;

% 2-D UGI, R=3.5, L=2
record = 12;
sim_param(record).comment = '2-D UGI, CC, r = 3.5, L = 2';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL2r7by2.mat');
sim_param(record).linetype = 'b:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 1e-4;
sim_param(record).trial_size = 1000;

% 2-D UGI, R=3.5, L=3
record = 13;
sim_param(record).comment = '2-D UGI, CC, r = 3.5, L = 3';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL3r7by2.mat');
sim_param(record).linetype = 'k:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 1e-4;
sim_param(record).trial_size = 1000;

% 2-D UGI, R=3.5, L=10
record = 14;
sim_param(record).comment = '2-D UGI, CC, r = 3.5, L = 10';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 10;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL10r7by2.mat');
sim_param(record).linetype = 'm:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 1e-4;
sim_param(record).trial_size = 1000;

% 2-D gray-coded 16QAM, R=3.5, L=1
record = 15;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 3.5, L = 1';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL1r7by2.mat');
sim_param(record).linetype = 'r-.';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 5e-4;
sim_param(record).trial_size = 1000;

% 2-D gray-coded 16QAM, R=3.5, L=2
record = 16;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 3.5, L = 2';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL2r7by2.mat');
sim_param(record).linetype = 'b-.';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10000;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 5e-4;
sim_param(record).trial_size = 1000;

% 2-D gray-coded 16QAM, R=3.5, L=3
record = 17;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 3.5, L = 3';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL3r7by2.mat');
sim_param(record).linetype = 'k-.';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10001;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 5e-4;
sim_param(record).trial_size = 1000;

% 2-D gray-coded 16QAM, R=3.5, L=10
record = 18;
sim_param(record).comment = 'Gray coded 16-QAM, CC, r = 3.5, L = 10';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 10;
sim_param(record).rate = 7/2;
sim_param(record).filename = strcat( data_directory, 'QAM2DCCL10r7by2.mat');
sim_param(record).linetype = 'm-.';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [0:1:40];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e7*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10001;
sim_param(record).max_frame_errors = 2100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 5e-4;
sim_param(record).trial_size = 1000;

% 2-D UGI, L=1, R=3202/2400/L (compare against QPSK H-SET 1)
record = 19;
sim_param(record).comment = '2-D UGI, CC, L = 1, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL1r3202by2400L.mat');
sim_param(record).linetype = 'r:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=2, R=3202/2400/L (compare against QPSK H-SET 1)
record = 20;
sim_param(record).comment = '2-D UGI, CC, L = 1, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL2r3202by2400L.mat');
sim_param(record).linetype = 'b:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=3, R=3202/2400/L (compare against QPSK H-SET 1)
record = 21;
sim_param(record).comment = '2-D UGI, CC, L = 3, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL3r3202by2400L.mat');
sim_param(record).linetype = 'k:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=4, R=3202/2400/L (compare against QPSK H-SET 1)
record = 22;
sim_param(record).comment = '2-D UGI, CC, L = 4, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL4r3202by2400L.mat');
sim_param(record).linetype = 'c:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QPSK, L=1, R=3202/2400/L (H-SET 1)
record = 23;
sim_param(record).comment = 'QPSK, CC, L = 1, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QPSKCCL1r3202by2400L.mat');
sim_param(record).linetype = 'r-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 4;
sim_param(record).input_filename = strcat( data_directory_input, 'QPSK_BICM.mat');
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QPSK, L=2, R=3202/2400/L (H-SET 1)
record = 24;
sim_param(record).comment = 'QPSK, CC, L = 2, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QPSKCCL2r3202by2400L.mat');
sim_param(record).linetype = 'b-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 4;
sim_param(record).input_filename = strcat( data_directory_input, 'QPSK_BICM.mat');
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QPSK, L=3, R=3202/2400/L (H-SET 1)
record = 25;
sim_param(record).comment = 'QPSK, CC, L = 3, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QPSKCCL3r3202by2400L.mat');
sim_param(record).linetype = 'k-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 4;
sim_param(record).input_filename = strcat( data_directory_input, 'QPSK_BICM.mat');
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QPSK, L=4, R=3202/2400/L (H-SET 1)
record = 26;
sim_param(record).comment = 'QPSK, CC, L = 4, R=3202/2400/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 3202/2400/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QPSKCCL4r3202by2400L.mat');
sim_param(record).linetype = 'c-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 4;
sim_param(record).input_filename = strcat( data_directory_input, 'QPSK_BICM.mat');
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=1, R=4664/1920/L (compare against QAM H-SET 1)
record = 27;
sim_param(record).comment = '2-D UGI, CC, L = 1, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL1r4664by1920L.mat');
sim_param(record).linetype = 'r:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=2, R=4664/1920/L (compare against QAM H-SET 1)
record = 28;
sim_param(record).comment = '2-D UGI, CC, L = 2, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL2r4664by1920L.mat');
sim_param(record).linetype = 'b:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=3, R=4664/1920/L (compare against QAM H-SET 1)
record = 29;
sim_param(record).comment = '2-D UGI, CC, L = 3, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL3r4664by1920L.mat');
sim_param(record).linetype = 'k:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% 2-D UGI, L=4, R=4664/1920/L (compare against QAM H-SET 1)
record = 30;
sim_param(record).comment = '2-D UGI, CC, L = 4, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'UGI2DCCL4r4664by1920L.mat');
sim_param(record).linetype = 'c:';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0;
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QAM, L=1, R=4664/1920/L (H-SET 1)
record = 31;
sim_param(record).comment = 'QAM, CC, L = 1, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 1;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QAMCCL1r4664by1920L.mat');
sim_param(record).linetype = 'r-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QAM, L=2, R=4664/1920/L (H-SET 1)
record = 32;
sim_param(record).comment = 'QAM, CC, L = 2, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 2;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QAMCCL2r4664by1920L.mat');
sim_param(record).linetype = 'b-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QAM, L=3, R=4664/1920/L (H-SET 1)
record = 33;
sim_param(record).comment = 'QAM, CC, L = 3, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 3;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QAMCCL3r4664by1920L.mat');
sim_param(record).linetype = 'k-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QAM, L=4, R=4664/1920/L (H-SET 1)
record = 34;
sim_param(record).comment = 'QAM, CC, L = 4, R=4664/1920/L';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 4664/1920/sim_param(record).blocks_per_frame;
sim_param(record).filename = strcat( data_directory, 'QAMCCL4r4664by1920L.mat');
sim_param(record).linetype = 'c-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 16;
sim_param(record).input_filename = strcat( data_directory_input, 'QAM16BICMAWGN' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 7.02e3*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 2e-5;
sim_param(record).trial_size = 1e4;

% QAM, L=4, R=4664/1920/L (H-SET 1)
record = 35;
sim_param(record).comment = 'A test';
sim_param(record).sim_type = 'outage';
sim_param(record).blocks_per_frame = 4;
sim_param(record).rate = 2;
sim_param(record).linetype = 'c-';
sim_param(record).combining_type = 'code';
sim_param(record).SNR = [-10:1:30];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).mod_order = 0; %UGI
sim_param(record).filename = strcat( data_directory_input, 'test' );
sim_param(record).legend = sim_param(record).comment;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 1e6;
sim_param(record).max_frame_errors = 100*ones( 1, length(sim_param(record).SNR) );
sim_param(record).minFER = 1e-4;
sim_param(record).trial_size = 1e4;

% To add a new record, cut and paste one of the above records.
% Change record number to be one higher than the last used.
% Modify parameters as desired.
%
% Important: Each record must have a unique filename.  It is recommended
% that for each new record you set
% sim_param(record).filename = strcat( data_directory, base_name, int2str(record), '.mat' );