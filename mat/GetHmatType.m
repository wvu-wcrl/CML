% GetHmatType.m
%  Determine the parity check matrix file format.
%
% Inputs
%   pcm         filename of parity check matrix stored in
%                 <cml_root>/data/ldpc
%
%     Last updated on 2/13/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function hmat_type = GetHmatType( pcm )

% parity check matrix formed using CML 'InitializeDVBS2' function
if ~isempty(strfind( pcm, 'InitializeDVBS2' ))
    hmat_type = 'cml_dvbs2';

% Radford Neal's .pchk format
elseif strcmp( pcm(end-3:end), 'pchk')
    hmat_type = 'pchk';
    
% .alist.  See David MacKay's website
elseif strcmp( pcm(end-4:end), 'alist')
    hmat_type = 'alist';
    
% CML H_rows, H_cols format, stored as .mat
elseif strcmp( pcm(end-2:end), 'mat')
    hmat_type = 'mat';
    
% randomcode generation
elseif strcmp( pcm, 'random')
    hmat_type = 'random';
    
else
    hmat_type = 'not_supported';
    
end
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
