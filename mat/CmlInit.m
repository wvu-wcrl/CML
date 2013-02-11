% CmlInit.m
% Initialize the MATLAB environment to execute CML
%
% Inputs
%  cml_home        path to CML source root
%  SimLocation     execution location of code - 'local' or 'clusterworker'
%
%  Local and cluster operation are differentiated by the manner in
%    in which CmlHome.mat is saved in the function 'save_cml_home'/
%
%     Last updated on 7/26/2012
%
%    - Possible future update: add support for location 'clusterlocal'
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.




function CmlInit( cml_home, SimLocation, wid )

if( nargin<2 || isempty(SimLocation) ), SimLocation = 'local'; end

error_check_input( SimLocation );

save_flag = determine_matlab_version();

set_cml_paths( cml_home, SimLocation );

save_cml_home( SimLocation, save_flag, cml_home, wid );

end


function error_check_input( SimLocation )
switch SimLocation,
    case 'local',
    case 'clusterworker',
    otherwise
        fprintf('Please specify a valid value for SimLocation -  \n');
        fprintf(' ''clusterworker'' or ''local'' \n');
        return;
end
end


function save_flag = determine_matlab_version()
% cml cluster init
version_text = version;
if ( str2num( version_text(1) ) > 6)
    save_flag = '-v6';
else
    save_flag = '-mat';
end
end


function set_cml_paths( cml_home, SimLocation )

% setup the path
addpath( fullfile( cml_home, 'mat'), ...
	fullfile( cml_home, 'mat', 'twrc'), ...
    fullfile( cml_home, 'mat', 'acct'), ...
    fullfile( cml_home, 'mat', 'parallel', 'web'), ...
    fullfile( cml_home, 'matalt' ), ...
    fullfile( cml_home, 'mat', 'exit' ), ...
        fullfile( cml_home, 'mat', 'parallel', 'cluster' ), ...
    fullfile( cml_home, 'mex', 'mexhelp'), ...
    fullfile( cml_home, 'mex'), ...
    fullfile( cml_home, 'demos' ), ...
    fullfile( cml_home, 'scenarios'), ...
	 fullfile( cml_home, 'scenarios', 'test'), ...
    fullfile( cml_home, 'localscenarios'),...    
    fullfile( cml_home, 'data', 'interleavers'), ...
    fullfile( cml_home, 'data', 'ldpc'), ...
    fullfile( cml_home, 'data', 'tables'), ...
    fullfile( cml_home, 'data', 'bandwidth') ,...
    fullfile( cml_home, 'module', 'chan_code', 'ldpc', 'decoder', 'src'), ...
    fullfile( cml_home, 'module', 'chan_code', 'ldpc', 'decoder', 'supp'), ...
	 fullfile( cml_home, 'module', 'chan_code', 'ldpc', 'decoder', 'src', 'mex'), ...
     fullfile( cml_home, 'util', 'file_parser'),...
     fullfile( cml_home, 'util', 'scenario_creation'));

% execute startup script for scenario creation subsystem
sc_startup(cml_home);
 
% if CML grid is installed
if exist( fullfile('.', 'grid', 'mat') )
    addpath( fullfile( cml_home, 'grid', 'mat' ) );
end

% this is the location of the mex directory for this architecture
addpath( fullfile( cml_home, 'mex', lower(computer) ) );

end


function save_cml_home( SimLocation, save_flag, cml_home, wid )

if strcmp( SimLocation, 'local' )
    cml_local_home = cml_home;
    
    cml_home_file = 'CmlHome.mat';
    save_directory = fullfile( cml_local_home, 'scenarios', cml_home_file );
    save( save_directory, save_flag, 'cml_home' );
    
    %cml_home_file = 'CmlRHome.mat';
    %cml_home = cml_home(2:end);
    %cml_home = ['/r' cml_home];
    %save_directory = fullfile( cml_local_home, 'scenarios', cml_home_file );
    %save( save_directory, save_flag, 'cml_home' );
end

end


function user = get_current_user( cml_home )
[str1 str2] = strtok( cml_home, '/' );
[str3 str4] = strtok(str2, '/');

user = str3;
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
