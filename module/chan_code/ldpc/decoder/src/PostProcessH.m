% PostProcessH.m
%  Convert parity check matrix in H_rows, H_cols form to format suitable
%   for CML LDPC decoder.
%
% Inputs
%  sim_param       CML structure containing general simulation parameters
%  code_param      CML structure containing channel_coding parameters
%
%  row_one         Parity check matrices formatted for input to LDPC
%  col_one          decoder
%
%
% Conversion depends on the type of H-matrix, as defined by the
%  standard defining the code
%
% Currently supported standards
%   DVB-S2
%   WiMax
%
%
%  Last updated on 5/26/2013
%
%  Copyright (C) 2013, Terry Ferrett, Xingyu Xiang and Matthew C. Valenti
%  For full copyright information see the bottom of this file.


function [ row_one, col_one ] = PostProcessH( H_rows, H_cols )

% subtract 1 from all values of H_rows and H_cols,
%  converting indexing from MATLAB > C
row_one = H_rows - 1;
col_one = H_cols - 1;

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

