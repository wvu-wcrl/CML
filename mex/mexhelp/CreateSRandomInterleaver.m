% CreateSRandomInterleaver produces a S-random interleaver.
% Warning: It can take a significant time to run.
%
% The calling syntax is:
%     [alpha] = CreateSRandomInterleaver( K, S )
%
%     alpha  = the interleaver in a length K vector 
%
%     K      = the size of the interleaver
%     S      = S value (determines amount of spread)
%     Note: the value of S greatly influences run time.
%
% Copyright (C) 2005, Matthew C. Valenti and Yufei Wu
%
% Last updated on Nov. 28, 2005
%
% Function CreateSRandomInterleaver is part of the Iterative Solutions 
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