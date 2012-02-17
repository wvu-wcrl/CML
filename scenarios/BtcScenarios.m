% File BtcScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% Last updated on May 3, 2008

% determine where your root directory is
load( 'CmlHome.mat' );
% determine where to store your files
base_name = 'BTC';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

MINBER = 5e-6;  
MAXTRIALS = 1e9;  
MAXERRORS = 200; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,6) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 1;
sim_param(record).comment = '(12,6) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 3;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,9) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 2;
sim_param(record).comment = '(12,9) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 9;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,12) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 3;
sim_param(record).comment = '(24,12) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 17;
sim_param(record).B = 6;
sim_param(record).Q = 0;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,20) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 4;
sim_param(record).comment = '(24,20) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 13;
sim_param(record).k_per_column = 13;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,18) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 5;
sim_param(record).comment = '(36,18) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 26;
sim_param(record).B = 9;
sim_param(record).Q = 3;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,25) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 6;
sim_param(record).comment = '(36,25) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 0 0 1 1]; % row generator (1+X)(1+X+X^6)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 41;
sim_param(record).k_per_column = 5;
sim_param(record).B = 0;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,23) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 7;
sim_param(record).comment = '(48,23) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5) 
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 22;
sim_param(record).B = 8;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,35) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 8;
sim_param(record).comment = '(48,35) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 11;
sim_param(record).k_per_column = 26;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (60,31) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 9;
sim_param(record).comment = '(60,31) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 16;
sim_param(record).k_per_column = 16;
sim_param(record).B = 4;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 18; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (72,40) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 10;
sim_param(record).comment = '(72,40) BTC in AWGN, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:8;
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 18;
sim_param(record).B = 0;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 20; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = 1:sim_param(record).max_iterations; 
sim_param(record).linetype = 'k-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,6) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 11;
sim_param(record).comment = '(12,6) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 3;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,9) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 12;
sim_param(record).comment = '(12,9) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 9;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,12) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 13;
sim_param(record).comment = '(24,12) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 17;
sim_param(record).B = 6;
sim_param(record).Q = 0;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c--'; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,20) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 14;
sim_param(record).comment = '(24,20) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 13;
sim_param(record).k_per_column = 13;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm--';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,18) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 15;
sim_param(record).comment = '(36,18) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 26;
sim_param(record).B = 9;
sim_param(record).Q = 3;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k--';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,25) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 16;
sim_param(record).comment = '(36,25) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 0 0 1 1]; % row generator (1+X)(1+X+X^6)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 41;
sim_param(record).k_per_column = 5;
sim_param(record).B = 0;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,23) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 17;
sim_param(record).comment = '(48,23) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5) 
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 22;
sim_param(record).B = 8;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,35) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 18;
sim_param(record).comment = '(48,35) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 11;
sim_param(record).k_per_column = 26;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (60,31) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 19;
sim_param(record).comment = '(60,31) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;  
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 16;
sim_param(record).k_per_column = 16;
sim_param(record).B = 4;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 18; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (72,40) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 20;
sim_param(record).comment = '(72,40) BTC in AWGN, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:10;
sim_param(record).channel = 'awgn';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 18;
sim_param(record).B = 0;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 20; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k--'; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,6) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 21;
sim_param(record).comment = '(12,6) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 3;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,9) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 22;
sim_param(record).comment = '(12,9) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 9;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,12) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 23;
sim_param(record).comment = '(24,12) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 17;
sim_param(record).B = 6;
sim_param(record).Q = 0;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,20) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 24;
sim_param(record).comment = '(24,20) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 13;
sim_param(record).k_per_column = 13;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,18) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 25;
sim_param(record).comment = '(36,18) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 26;
sim_param(record).B = 9;
sim_param(record).Q = 3;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k-';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,25) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 26;
sim_param(record).comment = '(36,25) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 0 0 1 1]; % row generator (1+X)(1+X+X^6)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 41;
sim_param(record).k_per_column = 5;
sim_param(record).B = 0;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,23) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 27;
sim_param(record).comment = '(48,23) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5) 
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 22;
sim_param(record).B = 8;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,35) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 28;
sim_param(record).comment = '(48,35) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 11;
sim_param(record).k_per_column = 26;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (60,31) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 29;
sim_param(record).comment = '(60,31) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 16;
sim_param(record).k_per_column = 16;
sim_param(record).B = 4;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 18; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (72,40) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 30;
sim_param(record).comment = '(72,40) BTC in RAYLEIGH, log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 18;
sim_param(record).B = 0;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 20; 
sim_param(record).decoder_type = 0; % log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k-';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,6) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 31;
sim_param(record).comment = '(12,6) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 3;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (12,9) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 32;
sim_param(record).comment = '(12,9) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 9;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 10; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,12) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 33;
sim_param(record).comment = '(24,12) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 17;
sim_param(record).B = 6;
sim_param(record).Q = 0;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c--'; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (24,20) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 34;
sim_param(record).comment = '(24,20) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 13;
sim_param(record).k_per_column = 13;
sim_param(record).B = 4;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 12; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm--';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,18) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 35;
sim_param(record).comment = '(36,18) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 6;
sim_param(record).k_per_column = 26;
sim_param(record).B = 9;
sim_param(record).Q = 3;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k--';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (36,25) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 36;
sim_param(record).comment = '(36,25) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 0 0 1 1]; % row generator (1+X)(1+X+X^6)
sim_param(record).g2 = [1 1]; % column generator 1+X (SPC code)
sim_param(record).k_per_row = 41;
sim_param(record).k_per_column = 5;
sim_param(record).B = 0;
sim_param(record).Q = 5;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 14; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'r--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,23) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 37;
sim_param(record).comment = '(48,23) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 0 1 0 1 1]; % row generator (1+X)(1+X+X^4)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5) 
sim_param(record).k_per_row = 9;
sim_param(record).k_per_column = 22;
sim_param(record).B = 8;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'b--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (48,35) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 38;
sim_param(record).comment = '(48,35) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1]; % row generator (1+X) (SPC code)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 11;
sim_param(record).k_per_column = 26;
sim_param(record).B = 0;
sim_param(record).Q = 6;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 16; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'c--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (60,31) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 39;
sim_param(record).comment = '(60,31) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;  
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 16;
sim_param(record).k_per_column = 16;
sim_param(record).B = 4;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 18; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'm--';  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (72,40) byte code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
record = 40;
sim_param(record).comment = '(72,40) BTC in RAYLEIGH, max-log-MAP';
sim_param(record).legend = sim_param(record).comment;
% channel parameters
sim_param(record).SNR_type = 'Eb/No in dB';
sim_param(record).SNR = 0:0.25:20;
sim_param(record).channel = 'rayleigh';
% channel coding parameters
sim_param(record).sim_type = 'coded';
sim_param(record).code_configuration = 7; % BTC
sim_param(record).g1 = [1 1 1 1 0 1 1]; % row generator (1+X)(1+X^2+X^5)
sim_param(record).g2 = [1 1 1 1 0 1 1]; % column generator (1+X)(1+X^2+X^5)
sim_param(record).k_per_row = 18;
sim_param(record).k_per_column = 18;
sim_param(record).B = 0;
sim_param(record).Q = 4;
sim_param(record).framesize = sim_param(record).k_per_row*sim_param(record).k_per_column - sim_param(record).B - sim_param(record).Q;
sim_param(record).max_iterations = 20; 
sim_param(record).decoder_type = 1; % max-log-MAP
% modulation parameters
sim_param(record).modulation = 'BPSK';
sim_param(record).mod_order = 2;
sim_param(record).bicm = 1;
sim_param(record).demod_type = 0; 
% saving
sim_param(record).filename = strcat( data_directory, ...
    strcat( 'btc', int2str( (sim_param(record).framesize)/8 ), sim_param(record).channel, int2str( sim_param(record).decoder_type ), '.mat') );
sim_param(record).reset = 0;
sim_param(record).save_rate = 1000;
% when to halt the simulation
sim_param(record).max_trials = MAXTRIALS*ones( size(sim_param(record).SNR) );
sim_param(record).minBER = MINBER; 
sim_param(record).max_frame_errors = MAXERRORS*ones( 1, length(sim_param(record).SNR) );
% plotting
sim_param(record).plot_iterations = sim_param(record).max_iterations; 
sim_param(record).linetype = 'k--';  
