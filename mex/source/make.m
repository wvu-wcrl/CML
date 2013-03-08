function make( varargin )
% makefile for the CML mex files
%
% Usage: 
%    make % makes all files
%
%    make 'filename' % makes just the specified file (must end in .c)
%
% Last updated June 10, 2010

% determine this directory and the one under it
% asssumes this directory ends in "source"
this_dir = pwd;
mex_dir = this_dir(1:length(this_dir)-6);

% determine where to put target
target_dir = strcat( mex_dir, lower( computer ) );
target_dir = ['''' target_dir ''''];

% Obtain a list of all the files in this directory
if nargin
    desired_file = varargin{1};
    D = dir( strcat( pwd, '/', desired_file ) );
else
    D = dir( pwd );
end

% Look for c-files in the list of files
for i=1:length(D)
    % is this a c-file?
    if ( length( D(i).name ) > 2 )
        if strcmp( D(i).name( (length(D(i).name)-1):length(D(i).name) ), '.c' )
            % yes, this is a c file, so compile it
            
            % function name
            fun_name = D(i).name( 1:length(D(i).name)-2 );
            
            % clear the function
            clear_string = ['clear ', D(i).name];
            eval( clear_string );
            
            % compile
            compile_string = ['mex -outdir ', target_dir, ' ', D(i).name ];
            eval( compile_string );
        end
    end
end



% execute module-specific makefiles - Terry 2/2013
[ cml_home ] = CmlLoadCmlHome('local');
path_cml_mex = fullfile(cml_home, 'mex', 'source');

% LDPC Decoder
% construct path to module source
path_ldpc_mex = fullfile(cml_home, 'module', 'chan_code', 'ldpc', ...
                         'decoder', 'src', 'mexsrc');

% execute makefile
cd(path_ldpc_mex); 
make; 
cd (path_cml_mex);

