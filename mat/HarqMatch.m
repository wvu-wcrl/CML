function [channel_streams] = HarqMatch( code_bits, X_RV, N_IR, modulation, P )
% HarqMatch converts a UMTS turbo codeword into P punctured HSDPA streams
%
% The calling syntax is:
%     [channel_streams] = HarqMatch( code_bits, X_RV, N_IR, modulation, P )
%
%     channel_streams = P by U matrix containing bits to be sent over the channel
%                       where U=960 for QPSK and U=1920 for 16-QAM
%
%     code_bits = the output of the turbo encoder,
%                 could contain multiple rows if multiple codewords.
%     X_RV = The redundancy version (an integer from 0 to 7).
%     N_IR = Size of the virtual IR buffer
%     modulation = 0 for QPSK or 1 for QAM
%     P = number of physical subchannels per turbo codeword
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on June 21, 2006
%
% Function HarqMatch is part of the Iterative Solutions Coded Modulation
% Library (ISCML).  
%
% The Iterative Solutions Coded Modulation Library is free software;
% you can redistribute it and/or modify it under the terms of 
% the GNU Lesser General Public License as published by the 
% Free Software Foundation; either version 2.1 of the License, 
% or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

% interleaver pattern for physical channel (table 7)
p_interleaver = [0 20 10 5 15 25 3 13 23 8 18 28 1 11 21 6 16 26 4 14 24 19 9 29 12 2 7 22 27 17];
R2 = 32;
C2 = 30;

% Based on X_RV and modulation, determine the Redundancy Version and other parameters
if (modulation == 0)
    % QPSK
    U = 960;
    r_max = 4;
    N_row = 2;
    LUT = [1 0
        0 0
        1 1
        0 1
        1 2
        0 2
        1 3
        0 3];
    s = LUT(X_RV+1,1);
    r = LUT(X_RV+1,2);       
else
    % 16-QAM
    U = 1920;
    r_max = 2;
    N_row = 4;
    LUT = [1 0 0
        0 0 0
        1 1 1
        0 1 1
        1 0 1
        1 0 2
        1 0 3
        1 1 0];
    s = LUT(X_RV+1,1);
    r = LUT(X_RV+1,2);
    b = LUT(X_RV+1,3);
end

% determine number of bits and turbo codewords
[number_codewords, N_TTI] = size( code_bits );
N_data = P*U;

% sanity checks
if ( rem( N_TTI, 3 ) )
    error( 'N_TTI must be a multiple of 3' );
elseif ( N_IR < N_TTI/3 )
    error( 'N_IR is not large enough' );
end

% loop over each turbo codeword
for codeword_index=1:number_codewords  
    
    % First Rate Matching
    X_i = N_TTI/3;
    
    % bit separation 
    streams = reshape( code_bits(codeword_index,:), 3, X_i );
    
    % The systematic part does not get punctured
    systematic = streams(1,:);
    
    % only need first rate matching if IR buffer smaller than the encoder output
    if ( N_IR < N_TTI )    
        % set up parameters
        delta_N = N_IR - N_TTI;
        e_ini = X_i;
        
        % puncture first parity stream
        % Correction 6-21-2006
        % e_plus = X_i;
        % e_minus = abs( floor( delta_N/2 ) );
        e_plus = 2*X_i;        
        e_minus = 2*abs( floor( delta_N/2 ) );
        parity_1 = RateMatch( streams(2,:), X_i, e_ini, e_plus, e_minus );
        
        % puncture second parity stream
        % Correction 6-21-2006
        % e_plus = 2*X_i;
        % e_minus = 2*abs( ceil( delta_N/2 ) );
        e_plus = X_i;
        e_minus = abs( ceil( delta_N/2 ) );
        parity_2 = RateMatch( streams(3,:), X_i, e_ini, e_plus, e_minus );    
    else
        parity_1 = streams(2,:);
        parity_2 = streams(3,:);
    end
    N_sys = X_i;
    N_p1 = length( parity_1 );
    N_p2 = length( parity_2 );
    
    % Second rate matching
    if (s==1)
        % Keep as many systematic bits as possible
        N_t_sys = min( N_sys, N_data );
    else
        % Keep as many parity bits as possible
        N_t_sys = max( N_data - (N_p1+N_p2), 0 );
    end
    
    N_t_p1 = floor( (N_data - N_t_sys)/2 );
    N_t_p2 = ceil( (N_data-N_t_sys)/2 );    
    
    % puncture systematic stream
    X_i = N_sys;
    e_plus = N_sys;
    e_minus = abs( N_sys - N_t_sys );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    systematic_t = RateMatch( systematic, X_i, e_ini, e_plus, e_minus );
    
    % puncture first parity stream
    X_i = N_p1;
    e_plus = 2*N_p1;
    e_minus = 2*abs( N_p1 - N_t_p1 );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    parity_1_t = RateMatch( parity_1, X_i, e_ini, e_plus, e_minus );
    
    % puncture second parity stream
    X_i = N_p2;
    e_plus = N_p2;
    e_minus = abs( N_p2 - N_t_p2 );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    parity_2_t = RateMatch( parity_2, X_i, e_ini, e_plus, e_minus );
    
    % bit collection
    w = BitCollection( systematic_t, parity_1_t, parity_2_t, N_row );
    
    % Physical channel segmentation
    temp_channel_streams = reshape( w, U, P )';
    
    % Interleave 
    if (modulation == 0) % QPSK
        % Interleave each physical channel
        for p_count=1:P
            % write into matrix row-by-row
            y = reshape( temp_channel_streams( p_count, : ), C2, R2)';
            
            % inter-column permutations
            y_prime = y(:,p_interleaver+1 );
            
            % read out of matrix column-by-column
            temp_channel_streams( p_count, : ) = reshape( y_prime, 1, U );
        end           
    else % QAM
        % Each physical channel gets two interleavings
        for p_count=1:P
            % split into two streams
            w_prime = reshape( temp_channel_streams(p_count,:), 4, U/4 );
            z(1,:) = reshape( w_prime(1:2,:), 1, U/2 );
            z(2,:) = reshape( w_prime(3:4,:), 1, U/2 );
            
            % interleave each substream
            for substream=1:2         
                % write into matrix row-by-row
                y = reshape( z(substream,:), C2, R2)';
                
                % inter-column permutations
                y_prime = y(:,p_interleaver+1 );
                
                % read out of matrix column-by-column
                z_prime(substream,:) = reshape( y_prime, 1, U/2 );            
            end
            
            % reassemble
            
            % Constellation re-arrangement
            if (b==0)
                w_prime(1:2,:) = reshape( z_prime(1,:), 2, U/4 );
                w_prime(3:4,:) = reshape( z_prime(2,:), 2, U/4 );            
            elseif (b==1)
                % swap MSB with LSB
                w_prime(1:2,:) = reshape( z_prime(2,:), 2, U/4 );
                w_prime(3:4,:) = reshape( z_prime(1,:), 2, U/4 );               
            elseif (b==2)
                % Inversion of LSB
                w_prime(1:2,:) = reshape( z_prime(1,:), 2, U/4 );            
                w_prime(3:4,:) = not( reshape( z_prime(2,:), 2, U/4 ) );  
                % next line is for debugging purposes
                % w_prime(3:4,:) = -reshape( z_prime(2,:), 2, U/4 ); 
            else
                % swap then invert LSB
                w_prime(1:2,:) = reshape( z_prime(2,:), 2, U/4 );            
                w_prime(3:4,:) = not( reshape( z_prime(1,:), 2, U/4 ) ); 
                % next line is for debugging purposes
                % w_prime(3:4,:) = -reshape( z_prime(1,:), 2, U/4 ); 
            end
            
            temp_channel_streams( p_count, : ) = reshape( w_prime, 1, U );        
        end   
    end
    channel_streams( (P*(codeword_index-1)+1):P*codeword_index, : ) = temp_channel_streams;
end
