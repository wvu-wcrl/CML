% CmlLoadCmlHome loads the location of 'CmlHome' from disk to variable in workspace.
%
% The calling syntax is:
%     cml_home = CmlLoadCmlHome( SimLocation )
%
%     SimLocation: ?
%     cml_home: ?
%
% Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
% 
% Last updated on 3/10/2014
%
% Licensed under the Lesser GPL.  See source code file for more detail.

function cml_home = CmlLoadCmlHome( SimLocation )

switch SimLocation
    
    case {'local', 'clusterlocal'}
        load('CmlHome.mat');
    case 'clusterworker'
        load('CmlRHome.mat');
        % currently, take no action
        
    otherwise
        
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
