function code_interleaver = CreateWimaxInterleaver(Nbits)
% CreateWimaxInterleaver intializes an interleaver for use with the duobinary
% tailbiting turbo code (CTC) from the mobile WiMAX (IEEE 802.16e) standard.
%
% The calling syntax is:
%     code_interleaver = CreateWimaxInterleaver(Nbits)
%
%     code_interleaver = a structure with the following members
%     code_interleaver.subblk_intl = subblock bit-wise interleaver, 1 by Nbits/2 vector
%     code_interleaver.info_intl = information interleaver over GF(2), 
%                                  a row vector of length Nbits.
%
%     Nbits = number of bits (i.e. twice the number of couples)
%             valid range = {24 36 48 72 96 108 120 144 180 192 216 240 480 960 1440 1920 2400}
%
% Copyright (C) 2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Oct. 12, 2007
%
% Function CreateWimaxInterleaver is part of the Iterative Solutions Coded Modulation
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

NN = [ 24, 36, 48, 72, 96, 108, 120, 144, 180, 192, 216, 240, 480, 960, 1440, 1920,2400].';
PP=[5, 0, 0, 0;  %%24
    11, 18, 0, 18;   %% 36
    13, 24, 0, 24;   %% 48
    11, 6, 0, 6;    %% 72
    7, 48, 24, 72;   %%96
    11, 54, 56, 2;   %% 108
    13, 60, 0, 60;   %% 120
    17, 74, 72, 2;    %%144
    11, 90, 0, 90;    %% 180
    11, 96, 48, 144;   %% 192
    13, 108, 0, 108;   %% 216
    13, 120, 60, 180;  %% 240
    53, 62,  12,  2;   %% 480
    43, 64, 300, 824;   %% 960 
    43, 720, 360, 540;   %% 1440
    31, 8, 24, 16;  %% 1920
    53, 66, 24, 2];  %% 2400

subblk_mJ = [ 3,3; %%24
              4,3; %%36
              4,3; %%48
              5,3; %%72
              5,3; %%96
              5,4; %%108
              6,2; %%120
              6,3; %%144
              6,3; %%180
              6,3; %%192
              6,4; %%216
              7,2; %%240
              8,2; %%480
              9,2; %%960
              9,3; %%1440
              10,2; %%1920
              10,3]; %%2400
              
Nindex = find( NN== N);

if (length(Nindex) ~= 1)
    disp('Wrong interleaver size for WiMax CTC');
end

P0 = PP(Nindex, 1);
P1 = PP(Nindex, 2);
P2 = PP(Nindex, 3);
P3 = PP(Nindex, 4);

x= zeros(2,N);
x(1:2*N) = 1:2*N;

%% intra-couple shifting
t = 2:2:N;
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

%% create subblock interleaver
m = subblk_mJ(Nindex,1);
J = subblk_mJ(Nindex,2);

y = zeros(1,N);
k = 0;
for index = 0:N-1
    T = N;
    while (T>=N)
        temp = floor(k/J);
        T = 2^m * mod(k,J) + bin2dec( fliplr( dec2bin(temp,m))); 
        k = k+1;
    end
    y(index+1) = T+1;  
end
code_interleaver.subblk_intl= y;


