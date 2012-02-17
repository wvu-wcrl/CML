function sequence = PnGenerator( sequence_length, g )
% PnGenerator creates a PN sequence using polynomial g
%
% The calling syntax is:
%     sequence = PnGenerator( sequence_length, g )
%
%     sequence = the PN sequence
%
%     sequence_length = the length of the sequence
%     g = the generator polynomial coefficients
%
% Copyright (C) 2006, Matthew C. Valenti
%
% Last updated on June 20, 2006
%
% Function PnGenerator is part of the Iterative Solutions Coded Modulation
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

K = length(g);
m = K-1;
pun_pattern = [0 1]';
tail_pattern = zeros(2,m);

g_encoder = [g
    [1 zeros(1,m) ] ];

input = [1 zeros(1,sequence_length-1)];

codeword = ConvEncode( input, g_encoder );

sequence = Puncture( reshape( codeword, 2, length(codeword)/2 ), pun_pattern, tail_pattern );

