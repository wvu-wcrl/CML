% File LTEScenarios
%
% This is a set of scenarios for the Coded Modulation Library.
%
% The simulations specified in this file are for the turbo code
% used by the UMTS-LTE standard
%
% Last updated on Nov. 23, 2007

% determine where your root directory is
load( 'CmlHome.mat' );
% determine where to store your files
base_name = 'LTE';
if ispc
    data_directory = strcat( '\output\', base_name, '\' );
else
    data_directory = strcat( '/output/', base_name, '/' );
end

full_directory = strcat( cml_home, data_directory );
if ~exist( full_directory, 'dir' )
    mkdir( full_directory);
end

% global variables
MINBER = 1e-9;
MINFER = 1e-4;
num_errors = 300;

% the decoder types
decoders = [0 1];

% the list of possible interleaver sizes
K_values = [40
          48
          56
          64
          72
          80
          88
          96
         104
         112
         120
         128
         136
         144
         152
         160
         168
         176
         184
         192
         200
         208
         216
         224
         232
         240
         248
         256
         264
         272
         280
         288
         296
         304
         312
         320
         328
         336
         344
         352
         360
         368
         376
         384
         392
         400
         408
         416
         424
         432
         440
         448
         456
         464
         472
         480
         488
         496
         504
         512
         528
         544
         560
         576
         592
         608
         624
         640
         656
         672
         688
         704
         720
         736
         752
         768
         784
         800
         816
         832
         848
         864
         880
         896
         912
         928
         944
         960
         976
         992
        1008
        1024
        1056
        1088
        1120
        1152
        1184
        1216
        1248
        1280
        1312
        1344
        1376
        1408
        1440
        1472
        1504
        1536
        1568
        1600
        1632
        1664
        1696
        1728
        1760
        1792
        1824
        1856
        1888
        1920
        1952
        1984
        2016
        2048
        2112
        2176
        2240
        2304
        2368
        2432
        2496
        2560
        2624
        2688
        2752
        2816
        2880
        2944
        3008
        3072
        3136
        3200
        3264
        3328
        3392
        3456
        3520
        3584
        3648
        3712
        3776
        3840
        3904
        3968
        4032
        4096
        4160
        4224
        4288
        4352
        4416
        4480
        4544
        4608
        4672
        4736
        4800
        4864
        4928
        4992
        5056
        5120
        5184
        5248
        5312
        5376
        5440
        5504
        5568
        5632
        5696
        5760
        5824
        5888
        5952
        6016
        6080
        6144];

colors = ['k' 'r' 'b' 'm'];
        
% dynamically create the records (since so many to create)
record = 0;
for decoder_index = 1:length(decoders)
    for K_index = 1:length(K_values)
        
        % increment the record number
        record = record + 1;
            
        % All cases use QPSK over AWGN in 0.2 dB increments
        sim_param(record).modulation = 'QPSK';
        sim_param(record).mapping = 'gray';
        sim_param(record).mod_order = 4;
        sim_param(record).channel = 'AWGN';
            
        % particular to this framesize
        sim_param(record).framesize = K_values(K_index);
        if (K_values(K_index) < 2000 )
            sim_param(record).SNR = [-1:0.2:6];
        else
            sim_param(record).SNR = [-0.2:0.1:3];
        end
        
        % filename
        sim_param(record).filename = strcat( data_directory, 'lte', sim_param(record).modulation, ...
            int2str( sim_param(record).framesize), sim_param(record).channel );

        % select the decoder type
        sim_param(record).decoder_type = decoders( decoder_index );
        sim_param(record).linetype = colors( mod(record,4)+1 ); % picking a color
        if (decoders( decoder_index ) == 0)
            sim_param(record).filename = strcat( sim_param(record).filename, 'LogMap');
            sim_param(record).linetype = strcat( sim_param(record).linetype, '-' );
        elseif (decoders( decoder_index ) == 1)
            sim_param(record).filename = strcat( sim_param(record).filename, 'MaxLogMap');
            sim_param(record).linetype = strcat( sim_param(record).linetype, '--' );
        end
        sim_param(record).filename = strcat( sim_param(record).filename, '.mat');
        
        % create the comment line
        sim_param(record).comment = sprintf( 'K=%d %s %s', sim_param(record).framesize,  ...
            sim_param(record).modulation, sim_param(record).channel  );

        % the number of iterations depends on the framesize
        sim_param(record).max_iterations = 8+floor(sim_param(record).framesize/600);        

        % turbo coding parameters
        sim_param(record).code_interleaver = ...
            strcat( 'CreateLTEInterleaver(', int2str(sim_param(record).framesize ), ')' );
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
        
        % Same for all        
        sim_param(record).legend = sim_param(record).comment;
        sim_param(record).sim_type = 'coded';
        sim_param(record).code_configuration = 1; % binary turbo
        sim_param(record).SNR_type = 'Eb/No in dB';
        sim_param(record).bicm = 1;
        sim_param(record).demod_type = 0; % linear-log-MAP demapper        
        sim_param(record).reset = 0;
        sim_param(record).max_trials = 1e10*ones( size(sim_param(record).SNR) );
        sim_param(record).minBER = MINBER;
        sim_param(record).minFER = MINFER;
        sim_param(record).max_frame_errors = num_errors*ones( size(sim_param(record).SNR) );
        sim_param(record).plot_iterations = sim_param(record).max_iterations;
        sim_param(record).save_rate = floor(1e6/sim_param(record).framesize); % save every million data bits

    end
end
