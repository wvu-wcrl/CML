function [ row_one, col_one] = PostProcessH( H_rows, H_cols )
% this funciton changes the H_cols and H_rows to the inputs format fit for
% the LDPC bicmid decoder 
%   Detailed explanation goes here

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

%H_cols(cols+1:16200,:)=H_cols_dual;
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

