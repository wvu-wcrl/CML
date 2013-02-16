% CmlAlistToHrowsHcols converts alist files to H_rows, H_cols format
%
% The calling syntax is:
%     [ H_rows H_cols ] = CmlAlistToHrowsHcols( tmp_path, pcm_prefix )
%
%     Inputs
%       alist_path        path containing alist file
%       pcm_prefix        prefix of parity check data file
%
%     Output:
%       H_rows            Spare row representation of parity check matrix
%       H_cols            Spare column representation of parity check matrix
%
%     Copyright (C) 2013, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on 1/25/2013

function [H_rows H_cols ErrMsg] = CmlAlistToHrowsHcols( tmp_path, pcm_prefix )

AlistFile = [pcm_prefix '.alist'];
FullPathAlistFile = [tmp_path filesep pcm_prefix '.alist'];

try
fid = fopen(FullPathAlistFile, 'r');
catch
ErrMsg = sprintf('Data file %s does not exist.', AlistFile);
H_rows = 0;
H_cols = 0;
return;
end
ErrMsg = [''];


dim = fscanf(fid, '%d', [1,2]);
cols=dim(2); rows = dim(1);

max_weight= fscanf(fid, '%d', [1,2]);
max_col_weight=max_weight(2); max_row_weight=max_weight(1);

row_weight = fscanf(fid, '%d', [1,rows]);
col_weight = fscanf(fid, '%d', [1,cols]);

H_rows = fscanf(fid, '%d', [max_row_weight, rows])';
H_cols = fscanf(fid, '%d', [max_col_weight, cols])';

fclose(fid);

end


%     Function CmlCreateHmatCluster is part of the Iterative Solutions Coded Modulation
%     Library (ISCML).
%
%     The Iterative Solutions Coded Modulation Library is free software;
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
