% MpDecode decodes a block code (e.g. LDPC) using the message passing algorithm. 
%
% The calling syntax is:
%     [output, errors] = MpDecode(input, H_rows, H_cols, [max_iter], [dec_type], [r_scale_factor], [q_scale_factor], [data] )
%
%     Required outputs:
%     output = matrix of dimension maxiter by N that has the decoded code bits for each iteration 
%
%     Optional outputs:
%	  errors = (optional) column vector showing the number of (code bit) errors after each iteration.
%
%     Required inputs:
%     input  = the decoder input in LLR form
%	  H_cols = a N row matrix specifying the locations of the nonzero entries in each column of the H matrix.
%	           The number or columns in the matrix is the max column weight.
%	           OR
%	           a K row matrix specifying locations of the nonzero entries in each coulmn of an extended IRA type 
%	           sparse H1 matrix	           
%	  H_rows = a N-K row matrix specifying the locations of the nonzero entries in each row of the H matrix.
%	           The number or columns in the matrix is the max row weight, unless this is for an H1 matrix,
%			   in which case the last n-k columns of the H matrix are equal to a known H2 matrix.
%
%     Optional inputs:
%     max_iter = the maximum number of decoder iterations (default = 30).
%	  dec_type = the decoder type:
%			   = 0 Sum-product (default)
%			   = 1 Min-sum 
%			   = 2 Approximate-min-star
%     r_scale_factor = amount to scale extrinsic output of c-nodes in min-sum decoding (default = 1) 
%     q_scale_factor = amount to scale extrinsic output of v-nodes in min-sum decoding (default = 1)
%	  data = a vector containing the data bits (used for counting errors and for early halting) (default all zeros)
%
% Copyright (C) 2005-2007, Matthew C. Valenti and Rohit Iyer Seshadri
%
% Last updated on July 21, 2007
%
% Function Mpdecode is part of the Iterative Solutions 
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