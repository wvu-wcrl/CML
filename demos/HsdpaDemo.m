% HSDPA Demo: Prompts user for input, then simulates a specified number of packets
% at a specified SNR.
%
% Last modified on June 21, 2006

% Turbo Code Parameters
% generator polynomial
g_turbo = [1 0 1 1
     1 1 0 1];
 
% scrambling parameters
g_scrambling = [1 zeros(1,10) 1 0 1 1 0 1];
 
% Puncturing pattern
pun_pattern = [1
               1
               0
               1];
           
% tail pattern    
tail_pattern = [1 1 1
    1 1 1
    1 1 1
    1 1 1];

nsc_flag = 0;

% Query for parameters
H_set = input( 'Choose an H_set (1-6) or select 0 to enter custom parameters: ' );
if ( sum( H_set == [0 1 2 3 6] ) )
    modulation= input('\nEnter 0 for QPSK modulation or 1 for QAM modulation: ' );
elseif ( sum( H_set == [4 5] ) )
    fprintf( '\nFor this H_set, QPSK modulation is used.\n' );
    modulation = 0;
else
    error( 'This H_set not supported' );
end

if (H_set == 0)
    TTI_distance = input( 'TTI spacing (1, 2, or 3): ' );
    K_info = input( 'K_info (number of information bits per frame): ' );
    P = input( 'P (number of physical channels per codeword): ');
    X_set = input( 'X_set (the vector of redundancy versions, e.g. [0 2 5 6]): ' );
    N_IR = input( 'N_IR (the virtual IR buffer size): ' );
elseif(H_set == 1)
    TTI_distance = 3;
elseif (H_set == 2)
    TTI_distance = 2;
elseif ( (H_set == 3)|(H_set==6) )
    TTI_distance = 1;
elseif (H_set == 4)
    % The TTI distance is actually only 2,
    % but effectively it is 3 because there are
    % only 2 simultaneous HARQ processes
    TTI_distance = 3;
elseif (H_set == 5)
    % The TTI distance is actually only 1,
    % but effectively it is 2 because there are
    % only 3 simultaneous HARQ processes
    TTI_distance = 2;
end

if (modulation == 0)
    % QPSK
    if (H_set == 6)
        K_info = 6438;
    elseif ( H_set > 0 )
        K_info = 3202;
    end
    
    if (H_set > 0)            
        P = 5;
        % The sequence of redundancy versions
        X_set = [0 2 5 6];
    end
    
    U = 960;
    % Create the constellation (updated 6-21-06)
    % S_matrix = Create2D( 4, 'HSDPA', [] );
    S_matrix = CreateConstellation( 'HSDPA', 4 );    
   
elseif (modulation == 1)
    % QAM
    if (H_set == 6)
        K_info = 9377;
    elseif ( H_set > 0 )
        K_info = 4664;
    end
    
    if (H_set > 0)
        P = 4;
        % The sequence of redundancy versions
        X_set = [6 2 1 5];
    end
        
    U = 1920;

    % Create the constellation (updated 6-21-06)
    % S_matrix = Create2D( 16, 'HSDPA', [] );
    S_matrix = CreateConstellation( 'HSDPA', 16 );     
  
else
    error('Modulation should be either 0 or 1');
end

% Ask if AWGN or Rayleigh fading
channel_type = input('\nChannel type (0 for AWGN or 1 for Rayleigh block fading): ' );
if ( sum( channel_type == [0 1] ) == 0)
    error( 'Invalid selection' );
end

% Ask which Es/No and how many trials
EsNodB = input('\nEnter Es/No in dB: ');
number_frames = input('\nHow many frames to simulate: ');

if ( H_set == 4 )
    N_IR = 7200;
elseif ( H_set > 0 )
    N_IR = 9600;
end
    
% derived constants
K_crc = K_info + 24; % add CRC bits

% see if there needs to be more than one block
number_codewords = ceil( K_crc/5114 ); % number of blocks
data_bits_per_frame = ceil( K_crc/number_codewords ); % length of each block
if (number_codewords*data_bits_per_frame ~= K_crc)
    K_crc = number_codewords*data_bits_per_frame;
    fprintf( '\nWarning %d filler bit(s) needed prior to segmentation\n', K_crc-K_info-24 );
end

N_TTI = 3*data_bits_per_frame + 12;
N_data = P*U;
M = length( X_set ); % maximum HARQ retransmissions
symbols_per_frame = number_codewords*N_data/(2^(modulation+1));

% default values (change if desired)
turbo_iterations = 14; % 14 iterations of turbo decoding
demod_type = 2; % constant log-MAP
decoder_type = 2; % constant log-MAP

input_somap_c = zeros(1,number_codewords*N_data); % a priori demodulator input

code_interleaver = CreateUmtsInterleaver( data_bits_per_frame );

% SNR
EsNo = 10^(EsNodB/10);
variance = 1/(2*EsNo);

% channel fading coefficients (set to one for AWGN)
a = 1;

trials = zeros(1,M);
frame_errors = zeros(1,M);
bit_errors = zeros(1,M);

fprintf( '\nFor each frame, the number below indicates how many HARQ transmissions before success\n(x indicates failure after last attempt)\n\n' );

% generate the scrambling sequence
pnsequence = PnGenerator( K_crc, g_scrambling );

for (frame=1:number_frames)
    
    % Generate Random Data
    data_unscrambled = round( rand( 1, K_crc ) );
    
    % Scramble
    data_scrambled = mod( data_unscrambled + pnsequence, 2 );
    
    % Turbo Encode
    codeword = TurboEncode( data_scrambled, code_interleaver, pun_pattern, tail_pattern, g_turbo, nsc_flag, g_turbo, nsc_flag );
    
    % Create the virtual buffer
    LLR_buffer = zeros(number_codewords,N_TTI);
    
    for (harq_transmission=1:M)        
        % increment counter
        trials( harq_transmission ) = trials( harq_transmission ) + 1;

        % Rate Matching
        [channel_streams] = HarqMatch( codeword, X_set(harq_transmission), N_IR, modulation, P );       
        
        % modulate
        harq_codeword = reshape( channel_streams', 1, number_codewords*N_data);
        % updated 6-21-06
        % s = Mod2D( harq_codeword, S_matrix );
        s = Modulate( harq_codeword, S_matrix );        
        
        % generate fading, if necessary
        if (channel_type==1) % block Rayleigh fading
             a = sqrt(0.5)*( randn( 1, 1) + j*randn( 1, 1) );
        end  
        
        % add noise
        noise = sqrt(variance)*( randn(1,symbols_per_frame) + j*randn(1,symbols_per_frame) ); % complex noise
        r = a*s + noise;
        
        % demodulate
        symbol_likelihood = Demod2D( r, S_matrix, EsNo, a*ones(1,symbols_per_frame) );
        bit_likelihood = Somap( symbol_likelihood, demod_type, input_somap_c );
        
        % Dematch
        [LLR] = HarqDematch( reshape( bit_likelihood, U, number_codewords*P)', X_set(harq_transmission), N_IR, N_TTI, number_codewords );        
                
        % update the virtual buffer
        LLR_buffer = LLR_buffer + LLR;        
        
        % Decode
        [detected_data, errors, output_decoder_c ] = TurboDecode( LLR_buffer, data_scrambled, turbo_iterations, decoder_type,  code_interleaver, pun_pattern, tail_pattern, g_turbo, nsc_flag, g_turbo, nsc_flag );        
                
        % Update error counters and retransmit, if necessary
        if ( errors(turbo_iterations) )
            % errors remain
            frame_errors( harq_transmission ) = frame_errors( harq_transmission ) + 1;
            bit_errors( harq_transmission ) = bit_errors( harq_transmission ) + errors( turbo_iterations );           
            if (harq_transmission == M)
                fprintf( 'x' ); % unsuccesful after Mth attempt
            end                
        else
            fprintf( '%d', harq_transmission ); % success after this attempt
            
            % This is where you could unscramble the data as follows:
            detected_data_unscrambled = mod( pnsequence + detected_data, 2 );
            break;            

        end           
    end
end

% Compute the throughput
number_correct_bits = K_info*(trials(1)-frame_errors(M));
blocks_transmitted = sum( trials );
throughput = number_correct_bits/(blocks_transmitted*TTI_distance*2);

fprintf( '\n\nThroughput at %3.1f dB = %4.0f kbps\n', EsNodB, throughput );

