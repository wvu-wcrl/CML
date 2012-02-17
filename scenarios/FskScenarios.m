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
base_name = 'fsk';
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
sim_param(record).comment = 'Uncoded 8-NFSK in AWGN (CSI)';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
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
sim_param(record).filename = strcat( data_directory, 'NFSK8AWGNCSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 200*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% uncoded 8NFSK modulation in AWGN
record = 2;
sim_param(record).comment = 'Uncoded 8-NFSK in AWGN (no-CSI)';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 2; % no CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'r*';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'NFSK8AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 100*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% uncoded 8FSK modulation in AWGN (coherent)
record = 3;
sim_param(record).comment = 'Uncoded 8-FSK in AWGN';
sim_param(record).sim_type = 'uncoded';
sim_param(record).SNR = [0:0.5:20];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 10000;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 0; % coherent
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1;  % max-log-map appropriate for uncoded
sim_param(record).linetype = 'b:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'FSK8AWGN.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 100*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM: Convolutionally coded 8FSK modulation in AWGN (w/ CSI)
record = 4;
sim_param(record).comment = 'R=1/2 K=7 NSC CC w/ 8NFSK in AWGN (w/ CSI and log-MAP)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5004;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'k:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  -1;  % Viterbi
sim_param(record).filename = strcat( data_directory, 'NFSK8AWGNCC7.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% BICM: Convolutionally coded 8FSK modulation in AWGN (w/ CSI)
record = 5;
sim_param(record).comment = 'R=1/2 K=7 NSC CC w/ 8NFSK in AWGN (w/ CSI and max-log-MAP)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5004;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1;
sim_param(record).demod_type = 1; % max-log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  -1;  % Viterbi
sim_param(record).filename = strcat( data_directory, 'NFSK8AWGNCC7maxlog.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% BICM-ID: Convolutionally coded 8FSK modulation in AWGN (w/ CSI)
record = 6;
sim_param(record).comment = 'R=1/2 K=7 NSC CC w/ 8NFSK in AWGN (w/ CSI and BICM-ID)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 0;
sim_param(record).SNR = [0:0.5:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5004;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 8;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).max_iterations = 4; % BICM-ID iterations
sim_param(record).demod_type = 0; %log-MAP
sim_param(record).linetype = 'g:';
sim_param(record).g1 = [1 0 1 1 0 1 1
   1 1 1 1 0 0 1];
sim_param(record).nsc_flag1 = 1;
sim_param(record).pun_pattern1 = [];
sim_param(record).tail_pattern1 = [];
sim_param(record).decoder_type =  0;  % log-MAP
sim_param(record).filename = strcat( data_directory, 'NFSK8AWGNCC7BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-4; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 50;

% BICM: Turbo coded 16FSK modulation in AWGN (w/ CSI)
record = 7;
sim_param(record).comment = 'R=1/3 turbo w/ 16NFSK in AWGN (w/ CSI and log-MAP)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:1:3 3.1:0.1:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'c:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).decoder_type =  0;  % log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'NFSK16AWGNturboR1by3CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-6; 
sim_param(record).max_frame_errors = 50*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 16FSK modulation in AWGN (w/ CSI)
record = 8;
sim_param(record).comment = 'R=1/3 turbo w/ 16NFSK in AWGN (Iterative Demod/Decoding)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:1:2 2.1:0.1:8];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'AWGN';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'c-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).decoder_type =  0;  % log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'NFSK16AWGNturboR1by3CSI_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 16FSK modulation in Fading (w/ CSI)
record = 9;
sim_param(record).comment = 'R=1/3 turbo w/ 16NFSK in fading';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:1:4 4.1:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 1; % BICM
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'b-';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).decoder_type =  0;  % log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'NFSK16RayleighturboR1by3CSI.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

% BICM-ID: Turbo coded 16FSK modulation in Fading (w/ CSI and BICM-ID)
record = 10;
sim_param(record).comment = 'R=1/3 turbo w/ 16NFSK in fading (w/ BICM-ID)';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 1;
sim_param(record).SNR = [0:1:3 3.5:0.1:10];
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).framesize = 5114;
sim_param(record).modulation = 'FSK';
sim_param(record).mod_order = 16;
sim_param(record).csi_flag = 1; % w/ CSI
sim_param(record).channel = 'Rayleigh';
sim_param(record).bicm = 2; % BICM-ID
sim_param(record).demod_type = 0; % log-MAP
sim_param(record).linetype = 'b:';
sim_param(record).code_interleaver = ...
    strcat( 'CreateUmtsInterleaver(', int2str(sim_param(record).framesize ), ')' );
sim_param(record).g1 = [1 0 1 1
    1 1 0 1];
sim_param(record).g2 = sim_param(record).g1;
sim_param(record).nsc_flag1 = 0;
sim_param(record).nsc_flag2 = 0;
sim_param(record).pun_pattern1 = [1 1
    1 1];
sim_param(record).pun_pattern2= [0 0
    1 1 ];
sim_param(record).tail_pattern1 = [1 1 1
    1 1 1];
sim_param(record).tail_pattern2 = sim_param(record).tail_pattern1;
sim_param(record).decoder_type =  0;  % log-MAP
sim_param(record).max_iterations = 16;
sim_param(record).plot_iterations = sim_param(record).max_iterations;
sim_param(record).filename = strcat( data_directory, 'NFSK16RayleighturboR1by3CSI_BICMID.mat');
sim_param(record).reset = 0;
sim_param(record).max_trials = 1e9*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = 1e-5; 
sim_param(record).max_frame_errors = 30*ones( size(sim_param(record).SNR) );
sim_param(record).save_rate = 100;

