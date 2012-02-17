function y = BitCollection( systematic_t, parity_1_t, parity_2_t, N_row )
% BitCollection performs the bit collection operation (used in HSDPA encoder)
%
% The calling syntax is:
%     y = BitCollection( systematic_t, parity_1_t, parity_2_t, N_row )
%
%     y = the punctured codeword formed by collecting the systematic and parity bits
%
%     systematic_t = the punctured systematic bits
%     parity_1_t = the punctured upper parity bits
%     parity_2_t = the punctured lower parity bits
%     N_row = Number of rows in the internal matrix (2 for QPSK and 4 for QAM)
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Dec. 13, 2005
%
% Function BitCollection is part of the Iterative Solutions Coded Modulation
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

% calculate constant values
N_t_sys = length( systematic_t );
N_t_p1 = length( parity_1_t );
N_t_p2 = length( parity_2_t );

% more constant values
N_data = N_t_sys + N_t_p1 + N_t_p2;
N_col = N_data/N_row;
N_r = floor( N_t_sys/N_col );
N_c = N_t_sys - N_r*N_col;

% initialize the internal matrix
w = zeros( N_row, N_col );

% feed in systematic bits
if (N_t_sys > 0) % are there any systematic bits?
    if (N_c == 0)
        w(1:N_r,:) = reshape( systematic_t, N_r, N_col );
    else
        w(1:N_r+1,1:N_c) = reshape( systematic_t(1:N_c*(N_r+1) ), N_r+1, N_c );
        w(1:N_r, N_c+1:N_col ) = reshape( systematic_t( N_c*(N_r+1)+1:N_t_sys), N_r, N_col - N_c );
    end
end

% feed in parity bits
if ( (N_t_p1+N_t_p2) > 0 ) % are there any parity bits?    
    parity_temp(1,:) = parity_2_t(1:N_t_p1);
    parity_temp(2,:) = parity_1_t;   
    
    parity = reshape( parity_temp, 1, 2*N_t_p1 );
    if ( N_t_p2 > N_t_p1 )
        parity( N_t_p1 + N_t_p2 ) = parity_2_t( N_t_p2 );
    end
    
    if (N_c == 0)
        w(N_r+1:N_row,:) = reshape( parity, N_row-N_r, N_col );
    else
        if (N_row > N_r+1)
            w(N_r+2:N_row,1:N_c) = reshape( parity(1:N_c*(N_row-N_r-1)), N_row-N_r-1, N_c );
        end
        w(N_r+1:N_row,N_c+1:N_col) = reshape( parity( N_c*(N_row-N_r-1)+1:N_t_p1+N_t_p2), N_row-N_r, N_col-N_c );              
    end
end

% form the codeword as a row vector
y = reshape( w, 1, N_data );


