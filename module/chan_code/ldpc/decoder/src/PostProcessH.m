% PostProcessH.m 
%  Convert parity check matrix in H_rows, H_cols form to format suitable
%   for CML LDPC decoder.
%  
% Inputs
%  sim_param       CML structure containing general simulation parameters
%  code_param      CML structure containing channel_coding parameters
%
%  row_one         Parity check matrices formatted for input to LDPC
%  col_one         decoder
%   
%  Last updated on 3/8/2013
%
%  Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%  For full copyright information see the bottom of this file.


function [ row_one, col_one ] = PostProcessH( H_rows, H_cols )
% this funciton changes the H_cols and H_rows to the inputs format fit for
% the LDPC bicmid decoder 


[cols, max_col_weight]=size(H_cols); 

rows = size(H_rows,1); 

%%%%%%%%%%%%%%%%% dual diagonal matrix%%%%%%%%%
temp = cols;
H_cols_dual = zeros(rows, max_col_weight);
for i=1:rows-1   
    H_cols_dual(i,1) = i;
    H_cols_dual(i,2) = i+1;    
end

H_cols_dual(rows,1) = rows;

H_cols((cols+1):(cols+rows),:)=H_cols_dual;

H_rows1=H_rows;
for j=2:rows
    row_weight = sum(H_rows(j,:)~=0);
    H_rows(j, row_weight+1) = temp + j-1;
    H_rows(j, row_weight+2) = temp + j;
end

H_rows(1,row_weight(1)+1)=temp + 1;

row_one = H_rows -1;
col_one = H_cols -1;

end


%     This library is free software;
%     you can redistribute it and/or modify it under the terms of
%     the GNU Lesser General Public License as published by the
%     Free Software Foundation; either version 2.1 of the License,
%     or (at your option) any later version.
%
%     This library is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%     Lesser General Public License for more details.
%
%     You should have received a copy of the GNU Lesser General Public
%     License along with this library; if not, write to the Free Software
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

