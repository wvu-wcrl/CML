% InitializeDVBS2 creates H_rows and H_cols matrices for the DVB-S2 LDPC code.
%
% The calling syntax is:
%     [H_rows, H_cols] = InitializeDVBS2( rate, size )
%
%     H_rows = a M-row matrix containing the indices of the non-zero rows of H.
%     H_cols = a (N-M)-row matrix containing the indices of the non-zeros rows of H.
%
%     rate = the code rate
%     size = the size of the code (number of code bits):
%          = 64,800 for normal (n=64,800)
%          = 16,200 for short  (n=16,200)
%
% Copyright (C) 2005, Matthew C. Valenti and Rohit Iyer Seshadri
%
% Last updated on Nov. 28, 2005
%
% Function InitializeDVBS2 is part of the Iterative Solutions 
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