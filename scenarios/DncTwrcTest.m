% determine where your root directory is
load( 'CmlHome.mat' );
% determine where to store your files
base_name = 'localscenarios';
experiment_name ='DncTwrcTest';
if ispc
data_directory = strcat('\', base_name, '\', experiment_name, '\', 'output' );
else
data_directory = strcat( '/', base_name, '/', experiment_name, '/', 'output/' );
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
sim_param(record).filename = strcat( data_directory, 'test_1.mat');
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = '0-Perfect amplitude knowledge';
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





record = 2;
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 1;
sim_param(record).max_iterations = 1;
sim_param(record).filename = strcat( data_directory, 'test_2.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = '0-Perfect amplitude knowledge';
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





record = 3;
sim_param(record).SNR = [0:0.5:50];
sim_param(record).blocks_per_frame = 1024;
sim_param(record).csi_flag = 1;
sim_param(record).mod_order = 4;
sim_param(record).framesize = 1229;
sim_param(record).code_bits_per_frame = 2048;
sim_param(record).bicm = 2;
sim_param(record).max_iterations = 10;
sim_param(record).filename = strcat( data_directory, 'test_3.mat');
sim_param(record).sim_type = 'coded';
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).modulation = 'FSK';
sim_param(record).channel = 'Rayleigh';
sim_param(record).comment = '0-Perfect amplitude knowledge';
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
sim_param(record).comment = '0-Perfect amplitude knowledge';
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



