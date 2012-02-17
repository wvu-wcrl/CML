% File DVBRCSScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the convolutional
% turbo code used by the DVB-RCS standard
%
% Last updated on Nov. 22, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'DVBRCS';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

MINBER = 1e-5;
num_errors = 100;

couples = [ 48, 64, 212 220, 228, 424, 432, 440, 848, 856, 864, 752 ];
% couples = 212;
rates = [1/3, 2/5, 1/2, 2/3, 3/4, 4/5, 6/7 ];
% rates = 1/3;
decoders = [0 1];
% decoders = 1;
colors = ['k' 'r' 'b' 'm' 'c' 'g' 'y'];

% This program creates records according to a loop.
% the record number depends on the size (number of couples) and rate 
% of the code, as well as the type of decoder.

record = 0;
for decoder_index = 1:length(decoders)
    for couple_index = 1:length(couples)
        for rate_index = 1:length(rates)
            % increment the record number
            record = record + 1;
            
            % All cases use QPSK over AWGN in 0.2 dB increments
            sim_param(record).modulation = 'QPSK';
            sim_param(record).mapping = 'gray';
            sim_param(record).mod_order = 4;
            sim_param(record).channel = 'AWGN';
            sim_param(record).SNR = [0:0.2:10];
            
            % particular to this rate and number of couples
            sim_param(record).framesize = 2*couples(couple_index);
            sim_param(record).code_bits_per_frame = ceil( couples(couple_index)/rates(rate_index) )*2;
            
            % filename
            sim_param(record).filename = strcat( data_directory, sim_param(record).modulation, ...
                int2str( sim_param(record).code_bits_per_frame), 'comma', int2str( sim_param(record).framesize), ...
                sim_param(record).channel, '.mat');
            
            % select the decoder type
            sim_param(record).decoder_type = decoders( decoder_index ); 
            sim_param(record).linetype = colors(rate_index);
            if (decoders( decoder_index ) == 0)
                sim_param(record).filename = strcat( sim_param(record).filename, 'LogMap');
                sim_param(record).linetype = strcat( sim_param(record).linetype, '-' );
            elseif (decoders( decoder_index ) == 1)
                sim_param(record).filename = strcat( sim_param(record).filename, 'MaxLogMap');
                sim_param(record).linetype = strcat( sim_param(record).linetype, '--' );
            end            
            sim_param(record).filename = strcat( sim_param(record).filename, '.mat');                                       
            sim_param(record).comment = sprintf( '(%d,%d) %s %s', sim_param(record).code_bits_per_frame/2, sim_param(record).framesize/2, ...
                sim_param(record).modulation, sim_param(record).channel  );
            
            % Same for all
            sim_param(record).legend = sim_param(record).comment;
            sim_param(record).sim_type = 'coded';
            sim_param(record).code_configuration = 6; % DVB-RCS
            sim_param(record).SNR_type = 'Eb/No in dB';
            sim_param(record).bicm = 0;
            sim_param(record).demod_type = 0; % linear-log-MAP demapper            
            sim_param(record).max_iterations = 10;
            sim_param(record).reset = 0;
            sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
            sim_param(record).minBER = MINBER;
            sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
            sim_param(record).plot_iterations = sim_param(record).max_iterations;
            sim_param(record).save_rate = floor(1e6/sim_param(record).framesize); % save every million data bits
        end
    end
end

