% CmlInit.m
% Initialize the MATLAB environment to execute CML
%
% Inputs
%  cml_home        path to CML source root
%  SimLocation     execution location of code - 'local' or 'cluster'
%
%  Local and cluster operation are differentiated by the manner in
%    in which CmlHome.mat is saved in the function 'save_cml_home'/
%
%     Last updated on 7/26/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


function CmlInit( cml_home, SimLocation )

                            error_check_input( SimLocation );
                           
SimLocation     = set_defaults( nargin, SimLocation );

save_flag         = determine_matlab_version();

save_directory = set_cml_paths( cml_home );     
            
                            save_cml_home( SimLocation, save_directory, save_flag, cml_home );               
                            
end


function error_check_input( SimLocation )
switch SimLocation,   
    case 'local',
    case 'cluster',
    otherwise
        fprintf('Please specify a valid value for SimLocation -  \n');
        fprintf(' ''cluster'' or ''local'' \n');
        return;
end
end


function SimLocation = set_defaults( nargs, SimLocation )
if( nargs<2 ), SimLocation = 'local'; end
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


function save_directory = set_cml_paths( cml_home )

if ispc
    % setup the path
    addpath( strcat( cml_home, '\mat'), ...
        strcat( cml_home, '\matalt' ), ...
        strcat( cml_home, '\mex\mexhelp'), ...
        strcat( cml_home, '\demos' ), ...
        strcat( cml_home, '\scenarios'), ...
        strcat( cml_home, '\localscenarios'),...
        strcat( cml_home, '\data\interleavers'), ...
        strcat( cml_home, '\data\ldpc'), ...
        strcat( cml_home, '\data\tables'), ...
        strcat( cml_home, '\data\bandwidth') );
    
    % if CML grid is installed
    if exist( '.\grid\mat' )
        addpath( strcat( cml_home, '\grid\mat' ) );
    end
    
    % save the home directory
    save_directory = strcat( cml_home, '\scenarios\CmlHome.mat' );
else
    % setup the path
    addpath( strcat( cml_home, '/mat'), ...
        strcat( cml_home, '/matalt' ), ...
        strcat( cml_home, '/mex/mexhelp'), ...
        strcat( cml_home, '/demos' ), ...
        strcat( cml_home, '/scenarios'), ...
        strcat( cml_home, '/localscenarios'),...
        strcat( cml_home, '/data/interleavers'), ...
        strcat( cml_home, '/data/ldpc'), ...
        strcat( cml_home, '/data/tables'), ...
        strcat( cml_home, '/data/bandwidth') );
    
    % if CML grid is installed
    if exist( './grid/mat' )
        addpath( strcat( cml_home, '/grid/mat' ) );
    end
    
    % save the home directory
    save_directory = strcat( cml_home, '/scenarios/CmlHome.mat' );
end



% this is the location of the mex directory for this architecture
switch computer
    case 'PCWIN'  % MS Windows on x86
        addpath( strcat( cml_home, '\mex\pcwin') );
    case 'GLNX86' % Linux on x86
        addpath( strcat( cml_home, '/mex/glnx86') );
    case 'MACI'   % Apple Mac OS X on x86         
        addpath( strcat( cml_home, '/mex/maci') );
    case 'PCWIN64' % Microsoft Windows on x64      
        addpath( strcat( cml_home, '\mex\pcwin64') );
    case 'GLNXA64'  % Linux on x86_64      
        addpath( strcat( cml_home, '/mex/glnxa64') );
    case 'SOL64'    % Sun Solaris on SPARC           
        addpath( strcat( cml_home, '/mex/sol64') );
    case 'MACI64'   % Apple Mac OS X on x86_64   
        addpath( strcat( cml_home, '/mex/maci64') );
end
end


function save_cml_home( SimLocation, save_directory, save_flag, cml_home )

switch( SimLocation )
    case 'cluster' % save to temporary location and sudo move
        [dc user] = system('whoami');   % get current user
        user = user(1:end-1);
 
        tmp_file_name = [user '_' 'cml_home.mat'];   % save to temporary location
        tmp_file_name_and_location = ['/var/tmp' '/' tmp_filename];
        save( tmp_file_name_and_location, save_flag, 'cml_home' );
        
        mv_cmd = ['sudo mv' ' ' tmp_file_name_and_location ' ' save_directory]; system(mv_cmd);   % sudo move to user's home directory
        chown_cmd = ['sudo chown' ' ' user ':' user ' ' save_directory]; system(chown_cmd);
        
    case 'local' % save directly
        save( save_directory, save_flag, 'cml_home' );
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
