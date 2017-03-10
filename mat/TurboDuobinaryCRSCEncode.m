% TurboDuobinaryCRSCEncode encodes a data sequence using a duobinary tailbiting 
% turbo encoder.  
%
% The calling syntax is:
%     codeword = TurboDuobinaryCRSCEncode( data, code_interleaver, pun_pattern )
%
%     codeword: the codeword generated by the encoder (a row vector)
%
%     data: the row vector of data bits
%     code_interleaver: the turbo interleaver
%     pun_pattern: the puncturing pattern 
%
% Copyright (C) 2007-2014, Matthew C. Valenti and Shi Cheng
%
% Last updated on Nov. 16, 2007
%
% Licensed under the Lesser GPL.  See source code file for more detail.

function codeword = TurboDuobinaryCRSCEncode( data, code_interleaver, pun_pattern )

Nbits= length(data);
N = Nbits/2;
poly = [1,0,1,1;1,0,0,1];
couple_data = reshape(data, 2, N);
outz = DuobinaryCRSCEncode(couple_data, poly);
intl_data = zeros(2,N);
intl_data = data(code_interleaver.info_intl);
intl_outz = DuobinaryCRSCEncode( intl_data, poly);

if (length( code_interleaver.subblk_intl ) > 0 )
    % WiMax uses a sub-block interleaver
    unpun_codeword = [reshape(couple_data(:,code_interleaver.subblk_intl).' ,1,2*N),...
       reshape( [outz(1,code_interleaver.subblk_intl);intl_outz(1,code_interleaver.subblk_intl)], 1, 2*N),...
       reshape( [outz(2,code_interleaver.subblk_intl);intl_outz(2,code_interleaver.subblk_intl)], 1, 2*N)]; 
else
    % DVB-RCS does not use a sub-block interleaver
    unpun_codeword = [reshape(couple_data,1,2*N),...
       reshape( [outz(1,:);intl_outz(1,:)], 1, 2*N),...
       reshape( [outz(2,:);intl_outz(2,:)], 1, 2*N)]; 
end

if (length(pun_pattern)>1)
    codeword = unpun_codeword( pun_pattern);
else
    codeword = unpun_codeword( 1:3*Nbits );
end

end

% Function TurboDuobinaryCRSCEncode is part of the Iterative Solutions Coded Modulation
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
% USA