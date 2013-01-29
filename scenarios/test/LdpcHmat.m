% LdpcHmat.m
%
% Tests for LDPC functionality such as methods for specifying parity check matrices
%  - InitializeDVBS2()
%  - alist files
%  - pchk files
%  - mat files
%
% Last updated on 11/16/2012

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'LdpcHmat';
if ispc
    data_directory = strcat( cml_home, '\output\', base_name, '\' );
else
    data_directory = strcat( cml_home, '/output/', base_name, '/' );
end
if ~exist( data_directory, 'dir' )
    mkdir(data_directory);
end

MINBER = 1e-5;



record = 1;
effective_rate = '1/4'; % since a short code, this is not the actual rate!
  sim_param(record).comment = 'InitializeDVBS()';
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
sim_param(record).linetype = 'r-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcHmat_1.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 5;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);
sim_param(record).MaxRunTime = 3*60;
                                
                                
record = 2;
effective_rate = '3/5'; 
sim_param(record).comment = '.PCHK file';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = 'test_ldpc_hmat.pchk';   % support .pchk or .alist h-matrix
sim_param(record).ldpc_param.rate = str2num( effective_rate );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcHmat_2.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 20;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);
sim_param(record).MaxRunTime = 3*60;

record = 3;
effective_rate = '3/5'; 
sim_param(record).comment = '.alist file';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = 'test_ldpc_hmat.alist';   % support .pchk or .alist h-matrix
sim_param(record).ldpc_param.rate = str2num( effective_rate );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcHmat_3.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 20;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);
sim_param(record).MaxRunTime = 3*60;

                                
record = 4;
effective_rate = '3/5'; 
sim_param(record).comment = '.mat file';
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 2; % LDPC
sim_param(record).ldpc_impl = 'new';   % specify ldpc implementation
sim_param(record).SNR = [0:0.5:30];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 64800; 
sim_param(record).parity_check_matrix = 'test_ldpc_hmat.mat';   % support .pchk or .alist h-matrix
sim_param(record).ldpc_param.rate = str2num( effective_rate );
sim_param(record).modulation = 'FSK';
sim_param(record).csi_flag = 2;
sim_param(record).mod_order = 2;
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2;
sim_param(record).demod_type = 0; 
sim_param(record).linetype = 'm-';
sim_param(record).max_iterations = 30;
sim_param(record).decoder_type = 0;
sim_param(record).filename = strcat( data_directory, 'LdpcHmat_4.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e8*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = 300*ones( size(sim_param(record).SNR) );
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).save_rate = 20;
sim_param(record).legend = strcat('M=', num2str(sim_param(record).mod_order), ',',...
                                   'BICM=', num2str(sim_param(record).bicm), ',',...
                                    'LDPC Impl=', sim_param(record).ldpc_impl);                                
sim_param(record).MaxRunTime = 3*60;                    
    

