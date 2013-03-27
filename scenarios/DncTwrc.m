% DncTwrc.m
% Testing basic functionality of digital network coding
%  in the two-way relay channel.

% determine where your root directory is
load( 'CmlHome.mat' );


% determine where to store your files
base_name = 'DncTwrc';


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
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 1;
sim_param(record).filename = strcat( data_directory, 'DncTwrc_1.mat');
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'Uncoded, Rayleigh, Csi=1, M=4,';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 4;
sim_param(record).decoder_type = 3;
sim_param(record).code_configuration = 4;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;



record = 2;
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 1;
sim_param(record).filename = strcat( data_directory, 'DncTwrc_2.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'Turbo code, BICM=1, Rayleigh, CSI=1, M=4';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 4;
sim_param(record).decoder_type = 3;
sim_param(record).code_configuration = 4;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;





record = 3;
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 2;
sim_param(record).max_iterations = 10;
sim_param(record).filename = strcat( data_directory, 'DncTwrc_3.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'Turbo coded, BICM=2, Rayleigh, M=4';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 4;
sim_param(record).decoder_type = 3;
sim_param(record).code_configuration = 4;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;







record = 4;
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 2;
sim_param(record).max_iterations = 10;
sim_param(record).filename = strcat( data_directory, 'test_4.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'Turbo coded, BICM=2, Csi=2, M=2';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 4;
sim_param(record).decoder_type = 3;
sim_param(record).code_configuration = 4;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4;
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;



record = 5;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 16200;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 2;
sim_param(record).max_iterations = 30;
sim_param(record).filename = strcat( data_directory, 'test_5.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).channel = 'AWGN';
sim_param(record).comment = 'LDPC coded, BICM=2, AWGN, Csi=2, M=4';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
sim_param(record).MaxRunTime = 60;



record = 6;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 16200;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 5;
sim_param(record).filename = strcat( data_directory, 'test_6.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).channel = 'AWGN';
sim_param(record).comment = 'LDPC coded, AWGN, BICM=2, M=4';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';





record = 7;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
sim_param(record).SNR = [0:0.5:30];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 16200;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 5;
sim_param(record).filename = strcat( data_directory, 'test_7.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).ldpc_impl = 'new';
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = 'LDPC, Rayleigh, BICM=1, M=4';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).linetype = 'k';
sim_param(record).demod_type = 0;
sim_param(record).decoder_type = 0;
sim_param(record).code_configuration = 2;
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5;
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 10;
sim_param(record).sameData = 0;
sim_param(record).mapping = 'natural';
sim_param(record).topology = 'twrc';
sim_param(record).twrc_param.energy_ratio = 1;
sim_param(record).twrc_param.csi1switch = 1;
sim_param(record).twrc_param.protocol = 'dnc';
