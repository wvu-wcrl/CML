% Puncture deletes bits at output of encoder according to puncutring pattern
%
% The calling syntax is:
%     [output] = Puncture(input, pun_pattern, tail_pattern )
%
%     output       = Punctured sequence
%
%     input        = Code bits to be punctured
%	  pun_pattern  = Puncturing pattern for encoded data bits
%	  tail_pattern = Puncturing pattern for encoded tail bits
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Nov. 28, 2005
%
% Function Puncture is part of the Iterative Solutions 
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