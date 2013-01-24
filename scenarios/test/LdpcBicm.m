% LdpcBicm.m
%
% Demonstrate BICM and BICM-ID using the new LDPC decoder implemenation.


% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'LdpcBicm';
if ispc
    data_directory = strcat( cml_home, '\output\', base_name, '\' );
else
    data_directory = strcat( cml_home, '/output/', base_name, '/' );
end
if ~exist( data_directory, 'dir' )
    mkdir(data_directory);
end




record = 1;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
  sim_param(record).comment = 'BICM, old implementation';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'old';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcBicm_1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 10^(-5); 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);


record = 2;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
  sim_param(record).comment = 'BICM, new implementation';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcBicm_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 10^(-5); 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);


record = 3;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
  sim_param(record).comment = 'BICM-ID, new implementation';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 16200; 
sim_param(record).parity_check_matrix = strcat( 'InitializeDVBS2(', effective_rate , ',', int2str( sim_param(record).framesize ), ')' );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'k-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcBicm_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 10^(-5); 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);
