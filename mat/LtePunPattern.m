%  LtePunPattern determines the tail_pattern and pun_pattern vectors
%  used by the turbo codec in accordance with the LTE standard.
%
%   The calling syntax is:
%      [pun_pattern,  tail_pattern] = LtePunPattern( framesize, code_bits_per_frame, [rv_idx] )
%
%      framesize: the length of data bits (input to rate matching)
%      code_bits_per_frame: the desired length of the code block (output of rate matching)
%      rv_idx: redundancy version index (integer from 0 to 3).
%              [optional, and assumed to be zero if not given]
%
%      pun_pattern: the puncturing pattern for all but the tail
%      tail_pattern: the puncturing pattern just for the tail
%
% Copyright (C) 2014, Matthew C. Valenti and Xingyu Xiang
%
% Last updated on Mar. 10, 2014
%
% Licensed under the Lesser GPL.  See source code file for more detail.

function [ pun_pattern,  tail_pattern ] = LtePunPattern(framesize,  code_bits_per_frame, varargin )

% set the rv_idx if not given
if (nargin<3)
    rv_idx = 0;
else
    rv_idx = varargin{1};
end

% determine the offset k_0 for reading from the circular buffer
k_0 = LteDetermineOffset(framesize, rv_idx );

% codeword length before puncturing, including data length (framesize) and 12 bits tail
N = 3*framesize+12;
% length of each row of the codeword matrix
dk_length = N/3;

% pass through the three sub-block interleavers
% the sub-block interleaver is based on section 5.1.4 of LTE standard 36.212
tempInSubInterleaver = 1:dk_length;
sys_block_interleaved=LteSubBlockInterleaver(tempInSubInterleaver,1);
tempInSubInterleaver = (1:dk_length)+dk_length;
parity1_block_interleaved=LteSubBlockInterleaver(tempInSubInterleaver,2);
tempInSubInterleaver = (1:dk_length)+2*dk_length;
parity2_block_interleaved=LteSubBlockInterleaver(tempInSubInterleaver,3);

% the output length of the sub-block interleaver
K_pi = length(sys_block_interleaved);
%bit collection, consturct virtual circular buffer
K_w=3*K_pi;

% initialize the circular buffer
W_circularbuffer=zeros(1,K_w);
% write the output of the sub-block interleaving into the circular buffer
%  according to 5.1.4.1.2 of LTE standard 36.212
for i=1:K_pi
    W_circularbuffer(i) = sys_block_interleaved(i);
    W_circularbuffer(K_pi+2*i-1) = parity1_block_interleaved(i);
    W_circularbuffer(K_pi+2*i) = parity2_block_interleaved(i);
end

% initialize the output of the rate matching
RateMatchingOutput = zeros(1, code_bits_per_frame);

% bit selection
k=1;
j=0;
while (k<=code_bits_per_frame)
    index = mod(k_0+j,K_w);
    if(W_circularbuffer(1+index)~=-1) % skiping dummy bits
        RateMatchingOutput(k)=W_circularbuffer(1+index);
        k=k+1;
    end
    j=j+1;
end

% generate pun_pattern and tail_pattern based on
% the output of the Rate Matcher
total_pattern = zeros(dk_length,3);
total_pattern(RateMatchingOutput) = 1;
PunPattern = total_pattern';

% transform the three-row tail_pattern into four-row pattern
tail_pattern_temp =  PunPattern(:,framesize+1:end);
tail_pattern = [reshape(tail_pattern_temp(:,1:2), 2,3);
    reshape(tail_pattern_temp(:,3:4), 2,3)];

% transform the three-row pun_pattern into four-row pattern
PunPattern(4,:) = PunPattern(3,:);
PunPattern(3,:) = zeros(1, dk_length);
pun_pattern = PunPattern(:, 1:framesize);

end

% Function LtePunPattern is part of the Iterative Solutions Coded Modulation
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