% Capacity determines the ergodic capacity under modulation constraints
%
% The calling syntax is:
%     [output] = capacity( input, data )
%
%     output  = Instantaneous capacity of this frame
%
%     input   = M by N matrix of symbol likelihoods
%               where M is the modulation order, or
%               M=1 is used to indicate that the input is a bitwise LLR.
%	  data    = 1 by N*log2(M) vector of data bits
%	  
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Nov. 28, 2005
%
% Function Capacity is part of the Iterative Solutions 
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