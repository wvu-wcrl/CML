function CmlStartup( SimLocation )

% CmlStartup
%
% Initializes the Coded Modulation Library
%
% Last updated June 11, 2010

% determine the version of matlab version

%%%%% check input argument for errors and set default if necessary
if( nargin<1 ), SimLocation = 'local'; end

switch SimLocation,   % error check input
    case 'local',
    case 'cluster',
    otherwise
        fprintf('Please specify a valid value for SimLocation. \n');
        return;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


version_text = version;
if ( str2num( version_text(1) ) > 6)
    save_flag = '-v6';
else
    save_flag = '-mat';
end

% determine the home directory
cml_home = pwd;

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


switch( SimLocation )
    case 'cluster'
        % save to temporary location
        [dc user] = system('whoami');
        user = user(1:end-1);
        
        tmp_filename = [user '_' 'cml_home.mat'];
        tmp_file = ['/var/tmp' '/' tmp_filename];
    
        save( tmp_file, save_flag, 'cml_home' );
        
        %sudo move
        cmd = ['sudo mv' ' ' tmp_file ' ' save_directory]; system(cmd);
        cmd = ['sudo chown' ' ' user ':' user ' ' save_directory];
            
    case 'local'
    save( save_directory, save_flag, 'cml_home' );
end