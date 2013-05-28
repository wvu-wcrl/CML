% DvbRand.m
% Test random generation of LDPC H-matrices.

% determine where your root directory is
load( 'CmlHome.mat' );


% determine where to store your files
base_name = 'DvbRand';


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
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 16200;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 50;
sim_param(record).filename = strcat( data_directory, 'DvbRand_1.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).ldpc_param.dv = [ 2 3 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = effective_rate;
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'DNC TWRC, DVB-S2: R = 3/5 N = 16200 K = 9720, [2 3 19]';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 3*60;



record = 2;
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 16200;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 50;
sim_param(record).filename = strcat( data_directory, 'DvbRand_2.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = 'random';
sim_param(record).ldpc_param.dv = [ 2 3 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = str2num(effective_rate);
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'DNC TWRC, DVB-S2: R = 3/5 N = 16200 K = 9720, [ 2 14 19 ]';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 3*60;






%%% reproduce results from xingyu 2012 tcom
record = 3;
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [5:0.05:6];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 32;
sim_param(record).framesize = 64800;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 100;
sim_param(record).filename = strcat( data_directory, 'DvbRand_3.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).modulation = 'APSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix =  strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).channel = 'AWGN';
sim_param(record).comment = 'P2P, Standard DVB-S2, N=64800, K=38880, BICM=1';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'b';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'DVB';
sim_param(record).topology = 'p2p';
sim_param(record).MaxRunTime = 60;


%%% reproduce results from xingyu 2012 tcom
record = 4;
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [5:0.05:6];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 32;
sim_param(record).framesize = 64800;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 100;
sim_param(record).filename = strcat( data_directory, 'DvbRand_4.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).modulation = 'APSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = 'random';
sim_param(record).ldpc_param.dv = [ 2 4 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = str2num(effective_rate);
sim_param(record).channel = 'AWGN';
sim_param(record).comment = 'P2P, DVB-S2, N=64800, K=38880, dv = [ 2 4 19 ], BICM=1';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'DVB';
sim_param(record).topology = 'p2p';
sim_param(record).MaxRunTime = 60;




%%% reproduce results from xingyu 2012 tcom
record = 5;
effective_rate = '3/5'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [5:0.05:6];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 32;
sim_param(record).framesize = 64800;
sim_param(record).bicm = 2;
sim_param(record).max_iterations = 100;
sim_param(record).filename = strcat( data_directory, 'DvbRand_5.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).modulation = 'APSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = 'random';
sim_param(record).ldpc_param.dv = [ 2 4 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = str2num(effective_rate);
sim_param(record).channel = 'AWGN';
sim_param(record).comment = 'P2P, DVB-S2, N=64800, K=38880, dv = [2 4 19], BICM=2';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'r';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 20;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'DVB';
sim_param(record).topology = 'p2p';
sim_param(record).MaxRunTime = 60;




% test random code generation and loading
record = 6;
effective_rate = '3/5'; 
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 64800;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 10;
sim_param(record).filename = strcat( data_directory, 'DvbRand_6.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = 'random';
sim_param(record).ldpc_param.dv = [ 2 4 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = str2num(effective_rate);
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'DNC TWRC, DVB-S2, N=64800, K=38880, dv = [2 4 19], BICM=1';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;



record = 7;
effective_rate = '3/5'; 
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 64800;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 10;
sim_param(record).filename = strcat( data_directory, 'DvbRand_7.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = 'DvbRand_6_hmat.mat';
sim_param(record).ldpc_param.dv = [ 2 4 19 ];
sim_param(record).ldpc_param.dv_dist = [ 0.4 0.52 0.08 ];
sim_param(record).ldpc_param.constraint = 'dvbs2';  % 'eira' or 'unconstrained'
sim_param(record).ldpc_param.rate = str2num(effective_rate);
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'DNC TWRC, DVB-S2, N=64800, K=38880, dv = [2 4 19], BICM=1';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;


