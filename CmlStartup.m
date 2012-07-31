% CmlStartup.m
% Initialize MATLAB environment to execute CML in local mode by
%   calling CmlInit()
%
% Inputs
%
%     Last updated on 7/26/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


function CmlStartup()

cml_home = pwd;

set_path_to_mat_files( cml_home );

CmlInit( cml_home, 'local', 0 );  % assume local operation

end


function set_path_to_mat_files( cml_home )

if ispc,  fs = '\';  else fs = '/'; end

addpath( strcat( cml_home, fs, 'mat') );   

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
