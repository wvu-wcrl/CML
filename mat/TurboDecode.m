function [detected_data, errors, output_decoder_c, input_upper_u] = TurboDecode( input_decoder_c, data, turbo_iterations, decoder_type, code_interleaver, pun_pattern, tail_pattern, g1, nsc_flag1, g2, nsc_flag2, varargin )
% TurboDecode decodes a received sequence that was encoded by a binary turbo code.  
% If input_decoder_c has multiple rows, then multiple codewords will be decoded (one for each row).
%
% The calling syntax is:
%     [detected_data, errors, output_decoder_c, [output_decoder_u] ] =
%                     TurboDecode( input_decoder_c, data, turbo_iterations, decoder_type,  ... 
%                          code_interleaver, pun_pattern, tail_pattern, g1, nsc_flag1, g2, ...
%                          nsc_flag2, [input_decoder_u] )
%
%     detected_data = a row vector containing the detected data
%     errors = a column vector containing the number of errors per
%              iteration for all the codewords.
%     output_decoder_c = the extrinsic information of the code bits
%     output_decoder_u = the extrinsic information of the systematic bits (optional)
%
%     input_decoder_c = the decoder input, in the form of bit LLRs
%                       this could have multiple rows if the data is longer
%                       than the interleaver
%     data = the row vector of data bits (used to count errors and for early halting of iterative decoding)
%     turbo_iterations = the number of turbo iterations
%     decoder_type = the decoder type
%              = 0 For linear-log-MAP algorithm, i.e. correction function is a straght line.
%              = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) ), i.e. correction function = 0.
%              = 2 For Constant-log-MAP algorithm, i.e. correction function is a constant.
%              = 3 For log-MAP, correction factor from small nonuniform table and interpolation.
%              = 4 For log-MAP, correction factor uses C function calls.
%     code_interleaver = the turbo interleaver
%     pun_pattern = the puncturing pattern for all but the tail
%     tail_pattern = the puncturing pattern just for the tail
%     g1 = the first generator polynomial
%     nsc_flag1 = 0 if first encoder is RSC and 1 if NSC
%     g2 = the second generator polynomial
%     nsc_flag2 = 0 if second encoder is RSC and 1 if NSC
%     [input_decoder_u] = the a priori information about systematic bits (optional input)
%
% Copyright (C) 2005-2006, Matthew C. Valenti
%
% Last updated on Apr. 23, 2006
%
% Function TurboDecode is part of the Iterative Solutions Coded Modulation
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

% determine some parameters
[N1,K1] = size( g1 );
[N2,K2] = size( g2 );

% check interleaver length against data length
K_data = length( data );
K_interleaver = length( code_interleaver );
if ( rem( K_data, K_interleaver ) )
    error( 'The data length needs to be an integer multiple of the interleaver length' );
end
number_codewords = K_data/K_interleaver;
data_bits_per_frame = K_data/number_codewords;

data = reshape( data, K_interleaver, number_codewords)';

% intialize error counter
errors = zeros( turbo_iterations, 1 );   

if ( length(varargin) >= 1 )   
    input_upper_u = varargin{1};
else
    input_upper_u = zeros( number_codewords, data_bits_per_frame );
end   

% loop over each received frame
for codeword_index=1:number_codewords       
   
    % depuncture and split
    depunctured_output = Depuncture( input_decoder_c(codeword_index,:), pun_pattern, tail_pattern );
    input_upper_c = reshape( depunctured_output(1:N1,:), 1, N1*length(depunctured_output) );
    input_lower_c = reshape( depunctured_output(N1+1:N1+N2,:), 1, N2*length(depunctured_output) );
    
    % decode
    for turbo_iter=1:turbo_iterations
        % fprintf( 'Turbo iteration = %d\n', turbo_iter );
        % Pass through upper decoder
        [output_upper_u output_upper_c] = SisoDecode( input_upper_u(codeword_index,:), input_upper_c, g1, nsc_flag1, decoder_type );
        
        % Interleave and extract extrinsic information
        input_lower_u = Interleave( output_upper_u - input_upper_u(codeword_index,:), code_interleaver );    
        
        % Pass through lower decoder
        [output_lower_u output_lower_c] = SisoDecode( input_lower_u, input_lower_c, g2, nsc_flag2, decoder_type );
        
        % count errors
        detected_data(codeword_index,:) = Deinterleave( (sign(output_lower_u)+1)/2, code_interleaver );
        error_positions = xor( detected_data(codeword_index,:), data(codeword_index,:) );       
        
        % exit if all the errors are corrected
        temp_errors = sum(error_positions);
        
        % for debugging
        % fprintf( 'Codeword: %d, Iteration: %d, Errors: %d\n', codeword_index, turbo_iter, temp_errors );
        if (temp_errors==0)
            break;
        else
            errors(turbo_iter) = temp_errors + errors(turbo_iter);              
            % Interleave and extract extrinsic information
            input_upper_u(codeword_index,:) = Deinterleave( output_lower_u - input_lower_u, code_interleaver );  
        end        
                             
    end         
    
    % Combine output_c and puncture
    % convert to matrices (each row is from one row of the generator)
    upper_reshaped = [ reshape( output_upper_c, N1, length(output_upper_c)/N1 ) ];
    lower_reshaped = [ reshape( output_lower_c, N2, length(output_lower_c)/N2 ) ];
    
    % parallel concatenate
    unpunctured_word = [upper_reshaped
        lower_reshaped];                     
    % repuncture
    output_decoder_c( codeword_index,:) = Puncture( unpunctured_word, pun_pattern, tail_pattern ); 
end

detected_data = reshape( detected_data', 1, K_data);


