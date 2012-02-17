% File CapacityScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the Shannon capacity
% under FSK modulation constraints.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'capacity';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

few_trials = 20;
many_trials = 200;

epsilon = 1e-3;

% AWGN+8FSK

% CM Capacity (coherent)
record = 1; % coherent
sim_param(record).comment = 'CM Capacity of 8-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_8FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 501*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 2; % non-coherent (CSI)
sim_param(record).comment = 'CM Capacity of 8-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_8NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 501*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 3; % non-coherent (no CSI)
sim_param(record).comment = 'CM Capacity of 8-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_8NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% BICM (log-MAP)
record = 4; % coherent
sim_param(record).comment = 'BICM-MAP Capacity of 8-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'k--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_8FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 5; % non-coherent (CSI)
sim_param(record).comment = 'BICM-MAP Capacity of 8-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'b--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_8NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 6; % non-coherent (no CSI)
sim_param(record).comment = 'CM Capacity of 8-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'r--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_8NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% BICM (max-log-MAP)
record = 7; % coherent
sim_param(record).comment = 'BICM-MLM Capacity of 8-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_8FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 8; % non-coherent (CSI)
sim_param(record).comment = 'BICM-MLM Capacity of 8-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_8NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 9; % non-coherent (no CSI)
sim_param(record).comment = 'BICM-MLM Capacity of 8-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 8;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_8NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 10; % coherent
sim_param(record).comment = 'CM Capacity of 16-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_16FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 11; % non-coherent (CSI)
sim_param(record).comment = 'CM Capacity of 16-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_16NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 12; % non-coherent (no CSI)
sim_param(record).comment = 'CM Capacity of 16-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 0;
sim_param(record).demod_type = 0; % does not matter if not BICM
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'CM_16NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% BICM (log-MAP)
record = 13; % coherent
sim_param(record).comment = 'BICM-MAP Capacity of 16-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'k--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_16FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 14; % non-coherent (CSI)
sim_param(record).comment = 'BICM-MAP Capacity of 16-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'b--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_16NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 15; % non-coherent (no CSI)
sim_param(record).comment = 'CM Capacity of 16-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % MAP
sim_param(record).linetype = 'r--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MAP_16NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

% BICM (max-log-MAP)
record = 16; % coherent
sim_param(record).comment = 'BICM-MLM Capacity of 16-FSK in AWGN';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 0; %coherent
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'k:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_16FSK_AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 17; % non-coherent (CSI)
sim_param(record).comment = 'BICM-MLM Capacity of 16-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 1; % noncoherent (CSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_16NFSK_AWGN_CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

record = 18; % non-coherent (no CSI)
sim_param(record).comment = 'BICM-MLM Capacity of 16-NFSK in AWGN (NCSI)';
sim_param(record).sim_type = 'capacity';
sim_param(record).SNR = [-20:0.5:20];
sim_param(record).SNR_type = 'Es/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2; % noncoherent (NCSI)
sim_param(record).mod_order = 16;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % ML-MAP
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'BICM_MLM_16NFSK_AWGN_NCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 500*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;

