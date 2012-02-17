function code_interleaver = CreateDvbInterleaver(Nbits)
% CreateDvbInterleaver intializes an interleaver for use with the duobinary
% tailbiting turbo code from the DVB-RCS standard
%
% The calling syntax is:
%     code_interleaver = CreateDvbInterleaver(Nbits)
%
%     code_interleaver = a structure with the following members
%     code_interleaver.subblk_intl = subblock bit-wise interleaver, 1 by Nbits/2 vector
%     code_interleaver.info_intl = information interleaver over GF(2), 
%                                  a row vector of length Nbits.
%
%     Nbits = number of bits (i.e. twice the number of couples)
%             valid range = {48 64 212 220 228 424 432 440 848 856 864 752}
%
% Copyright (C) 2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Oct. 12, 2007
%
% Function CreateDvbInterleaver is part of the Iterative Solutions Coded Modulation
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

N = Nbits/2; %% N is the number of couples

NN= [ 48, 64, 212 220, 228, 424, 432, 440, 848, 856, 864, 752].';

PP=[11, 24, 0, 24;
    7, 34, 32, 2;
    13, 106, 108, 2;
    23, 112, 4, 116;
    17, 116, 72, 188;
    11, 6, 8, 2;
    13, 0, 4, 8;
    13, 10, 4, 2;
    19, 2, 16, 6;
    19, 428, 224, 652;
    19, 2, 16, 6;
    19, 376, 224, 600];


Nindex = find( NN== N);

if (length(Nindex) ~= 1)
    disp('Wrong interleaver size of WiMax CTC');
end

P0 = PP(Nindex, 1);
P1 = PP(Nindex, 2);
P2 = PP(Nindex, 3);
P3 = PP(Nindex, 4);


x= zeros(2,N);
x(1:2*N) = 1:2*N;

%% intra-couple shifting
t = 1:2:N;
x(1,t) = 2*t;
x(2,t) = 2*t -1;

y= zeros(2,N);
for index = 0: N-1
    if mod(index,4) == 0
        P = 0;
    elseif mod(index,4) ==1 
        P = N/2 +P1;
    elseif mod(index,4) ==2
        P = P2;
    else
        P = N/2 +P3;
    end
    i = mod( P0* index + P +1, N);
    y(:, index+1) = x(:,i+1);
end

code_interleaver.info_intl = reshape(y, 1, Nbits);

% create subblock interleaver
code_interleaver.subblk_intl= [];


