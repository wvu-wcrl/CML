% UmtsPunPattern determines the pun_pattern and tail_pattern vectors 
% used by the turbo codec according to the UMTS standard.
%
%   The calling syntax is:
%      [pun_pattern,  tail_pattern ] = UmtsPunPattern( framesize, code_bits_per_frame )
%
%      framesize: the length of data bits (input to rate matching)
%      code_bits_per_frame: the desired length of the code block (output of rate matching)
%
%      pun_pattern: the puncturing pattern for all but the tail
%      tail_pattern: the puncturing pattern just for the tail
%
% Copyright (C) 2005-2014, Matthew C. Valenti
%
% Last updated on Mar. 10, 2014
%
% Licensed under the Lesser GPL.  See source code file for more detail.

function [pun_pattern, tail_pattern] = UmtsPunPattern( framesize, code_bits_per_frame )

N = 3*framesize+12;
X_i = N/3;

% This is the combined pun_pattern and tail_pattern
total_pattern = zeros(3,X_i);

% don't puncture the systematic part
total_pattern(1,:) = ones(1,X_i);

% set up parameters
delta_N = code_bits_per_frame - N; 
e_ini = X_i;

% puncture first parity stream
e_plus = 2*X_i;
e_minus = 2*abs( floor( delta_N/2 ) );
parity_1 = RateMatch( 1:X_i, X_i, e_ini, e_plus, e_minus );
total_pattern(2,parity_1) = ones( size(parity_1) );

% puncture second parity stream
e_plus = X_i;
e_minus = abs( ceil( delta_N/2 ) );
parity_2 = RateMatch( 1:X_i, X_i, e_ini, e_plus, e_minus );
total_pattern(3,parity_2) = ones( size(parity_2) );

% bit collection
pun_pattern(1,:) = ones(1,framesize);
pun_pattern(2,:) = total_pattern(2,1:framesize);
pun_pattern(3,:) = zeros(1,framesize);
pun_pattern(4,:) = total_pattern(3,1:framesize);

tail_pattern = reshape( total_pattern(:,framesize+1:X_i),4, 3 );

end

% Function UmtsPunPattern is part of the Iterative Solutions Coded Modulation
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




