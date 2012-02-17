function [code_bits] = HarqDematch( channel_streams, X_RV, N_IR, N_TTI, B )
% HarqDematch reassembles B UMTS turbo codewords from B*P received HSDPA streams
%
% The calling syntax is:
%     [code_bits] = HarqDematch( channel_streams, X_RV, N_IR, N_TTI )
%
%     code_bits = the reassembled, received turbo codewords (input to decoder)
%                 could be multiple rows if a long data sequence was
%                 segmented into multiple turbo codewords
%
%     channel_streams = B*P by U matrix containing bits received over the channel
%                       where U=960 for QPSK and U=1920 for 16-QAM
%                       and B is the number of turbo codewords.
%     X_RV = The redundancy version (an integer from 0 to 7).
%     N_IR = Size of the virtual IR buffer
%     N_TTI = Length of each unpunctured turbo codeword
%     B = the number of turbo codewords
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on June 21, 2006
%
% Function HarqDematch is part of the Iterative Solutions Coded Modulation
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

% sanity checks
if ( rem( N_TTI, 3 ) )
    error( 'N_TTI must be a multiple of 3' );
elseif ( N_IR < N_TTI/3 )
    error( 'N_IR is not large enough' );
end

% interleaver pattern for physical channel (table 7)
p_interleaver = [0 20 10 5 15 25 3 13 23 8 18 28 1 11 21 6 16 26 4 14 24 19 9 29 12 2 7 22 27 17];
R2 = 32;
C2 = 30;

% determine parameters
[P_total,U] = size( channel_streams );
% number physical channels per codeword
P = P_total/B; 
number_codewords = B; % an alias

% determine modulation from U.
if (U == 960)
    modulation = 0; % QPSK
elseif (U == 1920)
    modulation = 1; % QAM
else
    error( 'U must be either 960 or 1920' );
end

N_data = P*U;

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

% virtual IR buffer should not be larger than input word
if ( N_IR > N_TTI ) 
    N_IR = N_TTI;
end

% some more parameters
delta_N = N_IR - N_TTI;
N_sys = N_TTI/3;

% Figure out N_p1 and N_p2
N_p1 = floor( (N_IR - N_sys)/2 );
N_p2 = ceil( (N_IR - N_sys)/2 );

% more parameter
if (s==1)
    N_t_sys = min( N_sys, N_data );
else
    N_t_sys = max( N_data - (N_p1+N_p2), 0 );
end
N_t_p1 = floor( (N_data - N_t_sys)/2 );
N_t_p2 = ceil( (N_data-N_t_sys)/2 );

% loop over each turbo codeword
for codeword_index=1:number_codewords  
    
    % the channel streams just for this codeword
    temp_channel_streams = channel_streams( (P*(codeword_index-1)+1):P*codeword_index, : );
    
    % Deinterleave 
    if (modulation == 0) % QPSK
        % Deinterleave each physical channel
        for p_count=1:P
            % write into matrix column-by-column
            y_prime = reshape( temp_channel_streams( p_count, : ), R2, C2 );
            
            % inter-column permutations
            y(:,p_interleaver+1) = y_prime;
            
            % read out matrix row-by-row
            temp_channel_streams( p_count, : ) = reshape( y', 1, U );
            
        end           
    else % QAM
        % Each physical channel must be deinterleaved twice
        for p_count=1:P       
            % split into two streams
            w_prime = reshape( temp_channel_streams(p_count,:), 4, U/4 );
            z(1,:) = reshape( w_prime(1:2,:), 1, U/2 );
            z(2,:) = reshape( w_prime(3:4,:), 1, U/2 );
            
            % deinterleave each substream
            for substream=1:2       
                % write into matrix column-by-column
                y_prime = reshape( z(substream,:), R2, C2 );
                
                % inter-column permutations
                y(:,p_interleaver+1) = y_prime;
                
                % read out matrix row-by-row
                z_prime( substream, : ) = reshape( y', 1, U/2 );                     
            end
            
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
                % w_prime(3:4,:) = not( reshape( z_prime(2,:), 2, U/4 ) );             
                w_prime(3:4,:) = -reshape( z_prime(2,:), 2, U/4 ); 
            else
                % swap then invert LSB
                w_prime(1:2,:) = - reshape( z_prime(2,:), 2, U/4 );            
                % w_prime(3:4,:) = not( reshape( z_prime(1,:), 2, U/4 ) ); 
                w_prime(3:4,:) = reshape( z_prime(1,:), 2, U/4 ); 
            end
            
            % reassemble
            temp_channel_streams( p_count, : ) = reshape( w_prime, 1, U );        
        end  
    end
    
    % Reverse the physical channel segmentation
    w = reshape( temp_channel_streams', 1, N_data);
    
    % Decollect the bits
    [systematic_t, parity_1_t, parity_2_t] = BitDecollection( w, N_row, s, N_TTI, N_IR );
    
    % Second Rate Dematching
    
    % depuncture systematic stream
    X_i = N_sys;
    e_plus = N_sys;
    e_minus = abs( N_sys - N_t_sys );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    systematic = RateDematch( systematic_t, X_i, e_ini, e_plus, e_minus );
    
    % depuncture first parity stream
    X_i = N_p1;
    e_plus = 2*N_p1;
    e_minus = 2*abs( N_p1 - N_t_p1 );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    parity_1 = RateDematch( parity_1_t, X_i, e_ini, e_plus, e_minus );
    
    % depuncture second parity stream
    X_i = N_p2;
    e_plus = N_p2;
    e_minus = abs( N_p2 - N_t_p2 );
    e_ini = mod( X_i - floor( r*e_plus/r_max ) - 1, e_plus)+1;
    parity_2 = RateDematch( parity_2_t, X_i, e_ini, e_plus, e_minus );
    
    % First Rate Dematching
    X_i = N_sys;
    e_ini = X_i;
    
    % The systematic stream is never punctured
    streams(1,:) = systematic;
    
    % only need first rate matching if IR buffer smaller than the encoder output
    if ( N_IR < N_TTI )     
        % depuncture first parity stream
        % Correction 6-21-2006
        % e_plus = X_i;
        % e_minus = abs( floor( delta_N/2 ) );
        e_plus = 2*X_i;        
        e_minus = 2*abs( floor( delta_N/2 ) );
        streams(2,:) = RateDematch( parity_1, X_i, e_ini, e_plus, e_minus );
        
        % depuncture second parity stream
        % Correction 6-21-2006
        % e_plus = 2*X_i;
        % e_minus = 2*abs( ceil( delta_N/2 ) );
        e_plus = X_i;
        e_minus = abs( ceil( delta_N/2 ) );
        streams(3,:) =  RateDematch( parity_2, X_i, e_ini, e_plus, e_minus );
    else
        streams(2,:) = parity_1;
        streams(3,:) = parity_2;
    end   
    
    % Bit Deseparation
    code_bits( codeword_index, :)  = reshape( streams, 1, 3*X_i );
    
end