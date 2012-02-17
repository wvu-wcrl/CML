function [symbol_likelihood] = CmlChannel( s, sim_param, code_param, EsNo )
% CmlChannel sends the signal vector s over a channel, resulting in
% sufficient statistics in symbol_likelihood
%
% The calling syntax is:
%     [symbol_likelihood] = CmlChannel( s, sim_param, code_param, EsNo )
%
%     symbol_likelihood = M row matrix of likelihoods
%     s = a row vector containing encoded/modulated symbols
%     sim_param = A structure containing simulation parameters.
%     code_param = A structure containing the code paramaters.
%     EsNo = Ratio of Es/No (linear units -- not dB).
%
%     Copyright (C) 2006, Matthew C. Valenti
%
%     Last updated on May 6, 2006
%
%     Function CmlChannel is part of the Iterative Solutions Coded Modulation
%     Library (ISCML).  
%
%     The Iterative Solutions Coded Modulation Library is free software;
%     you can redistribute it and/or modify it under the terms of 
%     the GNU Lesser General Public License as published by the 
%     Free Software Foundation; either version 2.1 of the License, 
%     or (at your option) any later version.
%
%     This library is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%     Lesser General Public License for more details.
%
%     You should have received a copy of the GNU Lesser General Public
%     License along with this library; if not, write to the Free Software
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

% determine the noise variance
variance = 1/(2*EsNo);

% create the fading coefficients
if (code_param.channel_type==1) % Ergodic Rayleigh fading
    a = sqrt(0.5)*( randn( 1, code_param.symbols_per_frame) + j*randn( 1, code_param.symbols_per_frame) );
elseif ( code_param.channel_type==2 ) % Rayleigh block fading
    for block_count=1:sim_param.blocks_per_frame
        a( (block_count-1)*code_param.symbols_per_block+1: block_count*code_param.symbols_per_block) = sqrt(0.5)*(randn(1,1) + j*randn(1,1))*ones(1, code_param.symbols_per_block );
    end            
else % AWGN
    a = ones(1,code_param.symbols_per_frame); 
end  

% Add noise and then demodulate
if (code_param.bpsk) % BPSK 
    noise = sqrt(variance)*randn(1, code_param.symbols_per_frame );
    r = abs(a).*s + noise;            
    symbol_likelihood = -2*r.*abs(a)/variance; % This is the LLR                
elseif (code_param.fsk) % FSK
    % repeat fading coefficient since this is a multidimensional modulation
    for i=1:sim_param.mod_order
        a_matrix(i,:) = a;
    end
    
    % permutation matrix, to handle non-natural mappings.
    perm_matrix( code_param.mapping + 1, : ) = eye( sim_param.mod_order );

    noise = sqrt(variance)*( randn(sim_param.mod_order,code_param.symbols_per_frame) + j*randn(sim_param.mod_order,code_param.symbols_per_frame) );        
    r = a_matrix.*s + code_param.fil_noise*noise;
    symbol_likelihood = DemodFSK( perm_matrix*r, EsNo, sim_param.csi_flag, a );   
   
else
    % Complex modulation
    noise = sqrt(variance)*( randn(1,code_param.symbols_per_frame) + j*randn(1,code_param.symbols_per_frame) ); % complex noise
    r = a.*s + noise;
    symbol_likelihood = Demod2D( r, code_param.S_matrix, EsNo, a );   
end  