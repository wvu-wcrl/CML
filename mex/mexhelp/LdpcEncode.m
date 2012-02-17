% LdpcEncode encodes an LDPC codeword.  Code must be an "eIRA-LDPC" type code, such as the one
% in the DVB-S2 standard, or WiMax standard.
%
% The calling syntax is:
% codeword    = LdpcEncode( data, H_rows, [P])
%
% Where:
%      codeword = the encoded codeword
%
%      data   = a row vector containing the data
%      H_rows = a M-row matrix containing the indices of the non-zero rows of H excluding the dual-diagonal part.
%      P      = (optional) z times z matrix used to generate the first z check bits for WiMax (default =[])
%
% Copyright (C) 2005-2007, Matthew C. Valenti and Rohit Iyer Seshadri
%
% Last updated on July 10, 2007
%
% Function LdpcEncode is part of the Iterative Solutions 
% Coded Modulation Library. The Iterative Solutions Coded Modulation 
% Library is free software; you can redistribute it and/or modify it 
% under the terms of the GNU Lesser General Public License as published 
% by the Free Software Foundation; either version 2.1 of the License, 
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