function [detected_data, errors] = TurboDuobinaryCRSCDecode( llr, code_interleaver, pun_pattern, data, max_iterations, decoder_type)
% TurboDuobinaryCRSCDecode deccodes a data sequence that was encoded by a 
% duobinary tailbiting turbo encoder.  
%
% The calling syntax is:
%     [detected_data, errors] = TurboDuobinaryCRSCDecode( llr, code_interleaver, pun_pattern, data, max_iterations, decoder_type )
%
%     detected_data = a row vector containing the detected data
%     errors = a column vector containing the number of errors per
%              iteration for all the codewords.
%
%     llr = received LLR of the code bits.
%     code_interleaver = the turbo interleaver
%     pun_pattern = the puncturing pattern 
%     data = the row vector of data bits (for early halting)
%     max_iterations = maximum number of decoder iterations
%     decoder_type = the decoder type
%              = 0 For linear-log-MAP algorithm, i.e. correction function is a straght line.
%              = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) ), i.e. correction function = 0.
%              = 2 For Constant-log-MAP algorithm, i.e. correction function is a constant.
%              = 3 For log-MAP, correction factor from small nonuniform table and interpolation.
%              = 4 For log-MAP, correction factor uses C function calls.
%

% Copyright (C) 2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Nov. 16, 2007
%
% Function TurboDuobinaryCRSCDecode is part of the Iterative Solutions Coded Modulation
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

Nbits = length(code_interleaver.info_intl);
N = Nbits/2;
depun_llr = zeros(1,3*Nbits);
if (length(pun_pattern)>1)
    depun_llr(pun_pattern) = llr;
else
    depun_llr(1:3*Nbits) = llr;
end


if (length( code_interleaver.subblk_intl ) > 0 )
    % for WiMAX
    temp_llr([1,2],code_interleaver.subblk_intl) = reshape( depun_llr(1:2*N), N, 2).';
    temp_llr([3,4],code_interleaver.subblk_intl) = reshape( depun_llr(2*N+1:4*N), 2, N);
    temp_llr([5,6],code_interleaver.subblk_intl) = reshape( depun_llr(4*N+1:6*N), 2, N);
else
    % for DVB-RCS
    temp_llr([1,2],:) = reshape( depun_llr(1:2*N), 2, N );
    temp_llr([3,4],:) = reshape( depun_llr(2*N+1:4*N), 2, N);
    temp_llr([5,6],:) = reshape( depun_llr(4*N+1:6*N), 2, N);
end

X = [ temp_llr([2,1],:); temp_llr(1,:)+temp_llr(2,:)]; %% llr: 01, 10, 11
inz1  = [ temp_llr([5,3],:); temp_llr(3,:)+temp_llr(5,:)]; %% llr: 01, 10, 11
inz2  = [ temp_llr([6,4],:); temp_llr(4,:)+temp_llr(6,:)]; %% llr: 01, 10, 11



couple_index = ceil(code_interleaver.info_intl(1:2:Nbits)/2);
code_interleaver_GF4(1:3:3*Nbits/2) = couple_index-1 + code_interleaver.info_intl(1:2:Nbits);
code_interleaver_GF4(2:3:3*Nbits/2) = couple_index-1 + code_interleaver.info_intl(2:2:Nbits);
code_interleaver_GF4(3:3:3*Nbits/2) = 3*couple_index;

poly = [1,0,1,1;1,0,0,1];

inx2 = zeros(3,N);
inner_extr = zeros(3,N);
detected_data = zeros(1,Nbits);
errors = zeros(max_iterations, 1);
for it = 1:max_iterations
    inx1 = X + inner_extr;
    [outx1, outz1]=DuobinaryCRSCDecode( inx1, inz1, poly, decoder_type);
    
    llrx1 = outx1 - inner_extr;
    inx2(1:3*N) = llrx1( code_interleaver_GF4);
    [outx2, outz2, out_info]=DuobinaryCRSCDecode( inx2, inz2, poly, decoder_type);
    detected_data(code_interleaver.info_intl) = (out_info>0)+0;
    errors(it)= sum( sum(abs(detected_data - data)));
    if (errors(it) == 0)
        break;
    else
        inner_extr(code_interleaver_GF4) = outx2 - inx2;
    end
end