% File ThroughputScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The records in this file are used to plot Throughput of hybrid-ARQ.
%
% NOTE: - These records do not specify simulations that are run.
%         The file can only be used with CmlPlot, not with CmlSimulate.
%         It requires that simulations already be run for each block
%         transmission.
%
% Last updated on Oct. 12, 2007

% determine where your root directory is
load( 'CmlHome.mat' );

% determine where to store your files
base_name = 'throughput';
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
sim_param(record).comment = 'H-SET 1, AWGN, QPSK';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [1:4];
sim_param(record).linetype = 'b-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_AWGN_QPSK.mat');

record = 2;
sim_param(record).comment = 'H-SET 1, AWGN, QAM';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [5:8];
sim_param(record).linetype = 'c-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_AWGN_QAM.mat');

record = 3;
sim_param(record).comment = 'H-SET 1, Ergodic Fading, QPSK';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [9:12];
sim_param(record).linetype = 'k-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_Rayleigh_QPSK.mat');

record = 4;
sim_param(record).comment = 'H-SET 1, Ergodic Fading, QAM';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [13:16];
sim_param(record).linetype = 'g-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_Rayleigh_QAM.mat');

record = 5;
sim_param(record).comment = 'H-SET 6, AWGN, QPSK';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [17:20];
sim_param(record).linetype = 'b-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET6_AWGN_QPSK.mat');

record = 6;
sim_param(record).comment = 'H-SET 6, AWGN, QAM';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [21:24];
sim_param(record).linetype = 'c-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET6_AWGN_QAM.mat');

record = 7;
sim_param(record).comment = 'H-SET 6, Ergodic Fading, QPSK';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [25:28];
sim_param(record).linetype = 'k-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET6_Rayleigh_QPSK.mat');

record = 8;
sim_param(record).comment = 'H-SET 6, Ergodic Fading, QAM';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [29:32];
sim_param(record).linetype = 'g-.';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET6_Rayleigh_QAM.mat');

record = 9;
sim_param(record).comment = 'H-SET 1, Block fading, QPSK';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [33:36];
sim_param(record).linetype = 'r-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_Block_QPSK.mat');

record = 10;
sim_param(record).comment = 'H-SET 1, Block fading, QAM';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'HsdpaScenarios';
sim_param(record).scenarios = [39:42];
sim_param(record).linetype = 'm-';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'HSET1_Block_QAM.mat');

record = 11;
sim_param(record).comment = 'Unconstrained Throughput, Block Fading';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'OutageScenarios';
sim_param(record).scenarios = [19:22];
sim_param(record).linetype = 'r:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Unconstrained_Block_QPSK.mat');

record = 12;
sim_param(record).comment = 'QPSK-Constrained Throughput, Block Fading';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'OutageScenarios';
sim_param(record).scenarios = [23:26];
sim_param(record).linetype = 'r--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Block_QPSK.mat');

record = 13;
sim_param(record).comment = 'Unconstrained Throughput, Block Fading';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'OutageScenarios';
sim_param(record).scenarios = [27:30];
sim_param(record).linetype = 'm:';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Unconstrained_Block_QAM.mat');

record = 14;
sim_param(record).comment = 'QAM-Constrained Throughput, Block Fading';
sim_param(record).sim_type = 'throughput';
sim_param(record).input_filename = 'OutageScenarios';
sim_param(record).scenarios = [31:34];
sim_param(record).linetype = 'm--';
sim_param(record).legend = sim_param(record).comment;
sim_param(record).filename = strcat( data_directory, 'Block_QAM.mat');