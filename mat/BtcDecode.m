function [detected_data, errors] = BTCDecode( symbol_likelihood, data, grows, gcolumns, k_per_row, k_per_column, B, Q, max_iterations, decoder_type )
% BTCDecode decodes a block turbo code
%
% The calling syntax is:
%     [detected_data, errors] = BTCDecode( symbol_likelihood, data, grows, gcolumns, k_per_row, k_per_column, B, Q, max_iterations, decoder_type )
%
%     detected_data = a row vector containing hard decisions on the detected data
%     errors = a column vector containing the number of errors per iteration 
%
%     symbol_likelihood = the decoder input, in the form of bit LLRs
%     data = the row vector of data bits (used to count errors and for early halting of iterative decoding)
%     grows = the generator used to encode the rows
%     gcolumns = the generator used to encode the columns
%     k_per_row = number of data bits per row
%     k_per_column = number of data bits per column
%     B = number of zeros padded before data but not transmitted
%     Q = number of zeros padded before data and transmitted
%     max_iterations = the number of turbo iterations
%     decoder_type = the decoder type
%              = 0 For linear-log-MAP algorithm, i.e. correction function is a straght line.
%              = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) ), i.e. correction function = 0.
%              = 2 For Constant-log-MAP algorithm, i.e. correction function is a constant.
%              = 3 For log-MAP, correction factor from small nonuniform table and interpolation.
%              = 4 For log-MAP, correction factor uses C function calls.
%
% Copyright (C) 2008, Matthew C. Valenti and Sushma Mamidipaka
%
% Last updated on May 22, 2008
%
% Function BtcDecode is part of the Iterative Solutions Coded Modulation
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
% intialize error counter

errors = zeros( max_iterations, 1 ); 

padded_data = [ zeros(1,B) symbol_likelihood ];

% Determine size of the codeword
M= k_per_column+length(gcolumns)-1;
N= k_per_row+length(grows)-1;

% Turn into a rectangular matrix
channel_llr = reshape( padded_data, N, M )';

% RSC code
code_type = 0;

% Initialize Z
Z = channel_llr;
extrinsic_info = zeros(size(Z));

input_u_rows = zeros( 1, N-length(grows)+1 );
input_u_cols = zeros( 1, M-length(gcolumns)+1 );

% Decode
for turbo_iter = 1:max_iterations
    
    % Decode each row
    for m = 1:M
        input_c = channel_llr(m,:) + extrinsic_info(m,:);        
        [output_u, output_c] = SisoDecode(input_u_rows, input_c, grows, code_type, decoder_type );
        Z(m,:) = output_c - extrinsic_info(m,:);
    end
    
    % Decode each column
    for n = 1:N
        input_c = [Z(:,n)]';       
        [output_u, output_c] = SisoDecode(input_u_cols, input_c, gcolumns, code_type, decoder_type );
        extrinsic_info(:,n) = (output_c-input_c)';
        
        % used for hard decision
        % or hard decisions on the data bits for this column
        % could be made here
        output_columns(:,n) = output_c';       
        
    end
    
    output_codeword = output_columns(1:M-length(gcolumns)+1,1:N-length(grows)+1);
    
    % Turn into a row vector
    output_codeword = reshape(output_codeword', 1, prod(size(output_codeword)));
    
    % Stripping out the first B+Q bits
    output_codeword(1:B+Q)=[];
    
     % Count errors
    detected_data = (sign(output_codeword)+1)/2;
    error_positions = xor( detected_data, data );
    errors(turbo_iter) = sum(sum(error_positions));
    
    % fprintf('iteration %d, number errors = %d\n', turbo_iter, errors(turbo_iter) );
    
    % Exit if all the errors are corrected
    if (errors(turbo_iter)==0)
        break;
    end
end
