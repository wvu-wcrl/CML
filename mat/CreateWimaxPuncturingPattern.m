function pun_pattern = CreateWimaxPuncturingPattern( Nbits_pun, Nbits_unpun )
% CreateWimaxPuncturingPattern creates the puncturing pattern for use with the duobinary
% tailbiting turbo code (CTC) from the mobile WiMAX (IEEE 802.16e) standard.
%
% The calling syntax is:
%     pun_pattern = CreateWimaxPuncturingPattern( Nbits_pun, Nbits_unpun )
%
%     pun_pattern = the puncturing pattern (length Nbits_pun vector)
%
%     Nbits_pun = the number of bits after puncturing
%     Nbits_unpun = the number of bits prior to puncturing (not used)
%
% Copyright (C) 2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Oct. 12, 2007
%
% Function CreateWimaxPuncturingPattern is part of the Iterative Solutions Coded Modulation
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

pun_pattern = 1:Nbits_pun;
