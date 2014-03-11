%  LteSubBlockInterleaver implements the sub-block interleaver used for rate matching in LTE.
%
%   The calling syntax is:
%      interleaver_output = LteSubBlockInterleaver( interleaver_input, index)
%
%      interleaver_output: the result of the sub-block interleaving (includes Dummy bits)
%      interleaver_input: the input to the sub-block interleaver
%      index: index of the sub-block interleaver (determines permutation pattern)
%
% Copyright (C) 2014, Matthew C. Valenti and Xingyu Xiang
%
% Last updated on Mar. 10, 2014
%
% Licensed under the Lesser GPL.  See source code file for more detail

function [ interleaver_output ] = LteSubBlockInterleaver( interleaver_input, index)

D = length(interleaver_input);
C_subBlock_matrix = 32;
R_subBlock_matrix = ceil(D/C_subBlock_matrix);
NoElementsInMatrix = R_subBlock_matrix * C_subBlock_matrix;
N_Dummy = NoElementsInMatrix - D;
 
% define the matrix
Data_to_ElementsMatrix = zeros(1, NoElementsInMatrix);
Data_to_ElementsMatrix(1:N_Dummy) = -1;
Data_to_ElementsMatrix(N_Dummy+1:end) = interleaver_input;
inter_column_permutation_pattern=[ 0, 16, 8, 24, 4, 20, 12, 28, 2, 18, 10, 26, 6, 22, ...
        14, 30, 1, 17, 9, 25, 5, 21, 13, 29, 3, 19, 11, 27, 7, 23, 15, 31];
if (index-3<0)
    ElementsMatrix = reshape(Data_to_ElementsMatrix,C_subBlock_matrix,[]);
    ElementsMatrix = ElementsMatrix';
    % Perform the inter-column permutation
    MatrixAfterPermutation(:, inter_column_permutation_pattern+1) = ElementsMatrix;

    % output in the column direction
    interleaver_output = reshape(MatrixAfterPermutation,1,[]);

else

    Pi_K =zeros(1,NoElementsInMatrix);
    for k=0:NoElementsInMatrix-1
        Pi_K(k+1)=mod(inter_column_permutation_pattern(floor(k/R_subBlock_matrix)+1)...
            +C_subBlock_matrix*mod(k,R_subBlock_matrix)+1,  NoElementsInMatrix);
    end
    interleaver_output  = Data_to_ElementsMatrix(Pi_K+1);
    
end

end

% Function LtePunPattern is part of the Iterative Solutions Coded Modulation
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

