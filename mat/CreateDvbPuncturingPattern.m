function pun_pattern = CreateDvbPuncturingPattern( Nbits_pun, Nbits_unpun )
% CreateDvbPuncturingPattern creates the puncturing pattern for use with the duobinary
% tailbiting turbo code from the DVB-RCS standard.
%
% The calling syntax is:
%     pun_pattern = CreateDvbPuncturingPattern( Nbits_pun, Nbits_unpun )
%
%     pun_pattern = the puncturing pattern (length Nbits_pun vector)
%
%     Nbits_pun = the number of bits after puncturing
%     Nbits_unpun = the number of bits prior to puncturing 
%
% Copyright (C) 2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Oct. 12, 2007
%
% Function CreateDvbPuncturingPattern is part of the Iterative Solutions Coded Modulation
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

N = Nbits_unpun/6; 

if ( abs( Nbits_pun - ceil( N/(1/3) ) * 2 ) < 1E-5)
    pun_pattern = 1:Nbits_pun;
elseif ( abs( Nbits_pun - ceil( N/(2/5) ) * 2 ) < 1E-5)
    t = reshape( [ [1:2:N]*2-1 ; [1:2:N]*2], 1, N);
    pun_pattern = [1:4*N, 4*N+t];
elseif ( abs( Nbits_pun - ceil( N/(1/2) ) * 2 ) < 1E-5)
    pun_pattern = 1:Nbits_pun;
elseif ( abs( Nbits_pun - ceil( N/(2/3) ) * 2 ) < 1E-5)
    t = reshape( [ [1:2:N]*2-1 ; [1:2:N]*2], 1, N);
    pun_pattern = [1:2*N, 2*N+t];
elseif ( abs( Nbits_pun - ceil( N/(3/4) ) * 2 ) < 1E-5)
    t = reshape( [ [1:3:N]*2-1 ; [1:3:N]*2], 1, Nbits_pun-2*N);
    pun_pattern = [1:2*N, 2*N+t];
elseif ( abs( Nbits_pun - ceil( N/(4/5) ) * 2 ) < 1E-5)  
    t = reshape( [ [1:4:N]*2-1 ; [1:4:N]*2], 1, Nbits_pun-2*N);
    pun_pattern = [1:2*N, 2*N+t];
elseif ( abs( Nbits_pun - ceil( N/(6/7) ) * 2 ) < 1E-5)
    t = reshape( [ [1:6:N]*2-1 ; [1:6:N]*2], 1, Nbits_pun-2*N);
    pun_pattern = [1:2*N, 2*N+t];
else
    disp('DVB interleaver: Wrong punctured size');
end

