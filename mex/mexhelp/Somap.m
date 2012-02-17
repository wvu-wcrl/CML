% Somap performs soft demapping (converts M-ary symbol likelihoods to bitwise LLRs).
%
% The calling syntax is:
%     [output] = Somap( input, [demod_type], [extrinsic_info] )
%
%     output     = Length N*log2(M) stream of LLR values
%
%     Required inputs:
%     input      = M by N matrix of symbol likelihoods
%
%	  Optional inputs:
%	  demod_type = The type of max_star algorithm that is used 
%	             = 0 For linear approximation to log-MAP (DEFAULT)
%                = 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) )
%                = 2 For Constant-log-MAP algorithm
%	             = 3 For log-MAP, correction factor from small nonuniform table and interpolation
%                = 4 For log-MAP, correction factor uses C function calls
%	  extrinsic_info = 1 by N*log2(M) vector of extrinsic info (defaults to all-zero)
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Nov. 28, 2005
%
% Function Somap is part of the Iterative Solutions 
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