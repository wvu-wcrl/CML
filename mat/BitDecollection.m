function [systematic_t, parity_1_t, parity_2_t] = BitDecollection( x, N_row, s, N_TTI, N_IR );
% BitDecollection reverses the bit collection operation (used in HSDPA decoder)
%
% The calling syntax is:
%     [systematic_t, parity_1_t, parity_2_t] = BitDecollection( x, N_row, s, N_TTI, N_IR );
%
%     systematic_t = the punctured systematic bits
%     parity_1_t = the punctured upper parity bits
%     parity_2_t = the punctured lower parity bits
%
%     x = the received, punctured codeword 
%     N_row = Number of rows in the internal matrix (2 for QPSK and 4 for QAM)
%     s = RV flag that determines if priority placed on systematic (1) or parity (0) bits
%     N_TTI = Length of the unpunctured turbo codeword
%     N_IR = Size of the virtual IR buffer
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Dec. 13, 2005
%
% Function BitDecollection is part of the Iterative Solutions Coded Modulation
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
N_data = length( x );
N_sys = N_TTI/3; % N_sys should be multiple of 3.

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

% more constant values
N_col = N_data/N_row;
N_r = floor( N_t_sys/N_col );
N_c = N_t_sys - N_r*N_col;

% initialize storage
if (N_t_sys > 0)
    systematic_t = zeros(1,N_t_sys);
else
    systematic_t = [];
end

parity_temp = zeros(1,N_t_p1+N_t_p2);
y = reshape( x, N_row, N_col );

% extract systematic bits
if (N_t_sys > 0) % are there any systematic bits?
    if (N_c == 0)  
        % First N_r rows are the systematic bits
        systematic_t = reshape( y(1:N_r,:), 1, N_t_sys );
    else
        % First N_c columns contain systematic bits in first N_r + 1 rows
        systematic_t(1:N_c*(N_r+1)) = reshape( y(1:N_r+1,1:N_c), 1, N_c*(N_r+1) );
        % Remaining columns contain systematic bits in first N_r rows
        systematic_t(N_c*(N_r+1)+1:N_t_sys) = reshape( y(1:N_r,N_c+1:N_col), 1, N_r*(N_col-N_c) );
    end
end

% extract parity bits
if ( N_t_p1 + N_t_p2 > 0 ) % are there any parity bits?      
    if (N_c == 0)
        % Last N_row-N_r rows are the parity bits
        parity_temp = reshape( y(N_r+1:N_row,:), 1, N_t_p1 + N_t_p2 );
    else
        if (N_row > N_r+1)
            % First N_c columns contain parity bits in last N_row-N_r-1 rows (if they exist)
            parity_temp(1:N_c*(N_row-N_r-1) ) = reshape( y(N_r+2:N_row,1:N_c), 1, N_c*(N_row-N_r-1) );
        end
        % Last N_col-N_c columns contain parity bits in last N_row-N_r rows 
        parity_temp(N_c*(N_row-N_r-1)+1:N_t_p1+N_t_p2 ) = reshape( y(N_r+1:N_row,N_c+1:N_col), 1, (N_col-N_c)*(N_row-N_r) );
    end
end

% create parity streams
parity = reshape( parity_temp(1:2*N_t_p1), 2, N_t_p1 );
parity_1_t = parity(2,:);
parity_2_t = parity(1,:);
parity_2_t(N_t_p2) = parity_temp(N_t_p1+N_t_p2);



