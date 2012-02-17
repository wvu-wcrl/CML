% SisoDecode performs soft-in/soft-out decodeing of a convolutional code.
%
% The calling syntax is:
%     [output_u, output_c] = SisoDecode(input_u, input_c, g_encoder, [code_type], [dec_type] )
%
%     output_u = LLR of the data bits
%	  output_c = LLR of the code bits
%
%     Required inputs:
%	  input_u = APP of the data bits
%	  input_c = APP of the code bits
%	  g_encoder = generator matrix for convolutional code
%	              (If RSC, then feedback polynomial is first)
%	  
%	  Optional inputs:
%	  code_type = 0 for RSC outer code (default)
%	            = 1 for NSC outer code
%	  dec_type = the decoder type:
%			= 0 For linear approximation to log-MAP (DEFAULT)
%			= 1 For max-log-MAP algorithm (i.e. max*(x,y) = max(x,y) )
%			= 2 For Constant-log-MAP algorithm
%			= 3 For log-MAP, correction factor from small nonuniform table and interpolation
%			= 4 For log-MAP, correction factor uses C function calls (slow)  )
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Nov. 28, 2005
%
% Function SisoDecode is part of the Iterative Solutions 
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