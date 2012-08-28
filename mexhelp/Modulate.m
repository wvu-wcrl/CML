% Modulate transforms bits into K-dimensional channel symbols
%
% The calling syntax is:
%     [output] = Modulate( input, S_matrix )
%
%     output =  K by N vector of modulated symbols
%
%     Required inputs:
%     input    = 1 by N*log2(M) vector of data bits
%     S_Matrix = K by M complex matrix containing the constellation signals
%                Each Column is one signal, each signal is K-dimensional
%
%     Note: For legacy purposes, S_matrix can be a M by 1 matrix when signal
% 	  set can be characterized by a one-dimensional complex value (QAM, etc).
%
% Copyright (C) 2006, Matthew C. Valenti
%
% Last updated on June 21, 2006
%
% Function Modulate is part of the Iterative Solutions 
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