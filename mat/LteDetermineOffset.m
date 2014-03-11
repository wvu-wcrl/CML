%  LteDetermineOffset determines the offset k_0 used by the LTE rate matcher to
%  read from the circular buffer.
%
%   The calling syntax is:
%      k_0 = LteDetermineOffset(framesize, [rv_idx] )
%
%      k_0: offset for reading from the circular buffer
%
%      framesize: the length of data bits
%      rv_idx: redundancy version index (integer from 0 to 3).
%              [optional, and assumed to be zero if not given]
%
% Copyright (C) 2014, Matthew C. Valenti and Xingyu Xiang
%
% Last updated on Mar. 10, 2014
%
% Licensed under the Lesser GPL.  See source code file for more detail.

function k_0 = LteDetermineOffset(framesize, varargin )

% set the rv_idx if not given
if (nargin<2)
    rv_idx = 0;
else
    rv_idx = varargin{1};
end

% the number of bits entering the sub-block interleaver
% including 1/3 of the 12 tail bits
D = framesize+4;

% the number of columns in the sub-block interleaver
C_subBlock_matrix = 32;

% the number of roes in the sub-block interleaver
R_subBlock_matrix = ceil(D/C_subBlock_matrix);

% the number of elements in the sub-block intereaver
K_pi = C_subBlock_matrix*R_subBlock_matrix;

% total size of the circular buffer
K_w = 3*K_pi;

% the soft buffer size (N_cb) for each code block
% note: this is valid for the uplink coded transport channel
N_cb = K_w;

% determine the offset
k_0 = R_subBlock_matrix*(2*ceil(N_cb/(8*R_subBlock_matrix))*rv_idx+2);

% Function LteDetermineOffset is part of the Iterative Solutions Coded Modulation
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
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301