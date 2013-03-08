% make.m
% makefile for LDPC module
%
% 
% Usage: 
%  - Place makefile in directory containing module c-mex source files
%  - Specify target directory. Default is '../mex/<arch>' 
%  - Specify any desired compiler flags in the variable 'flags'
%  - Within MATLAB, switch to this directory and execute 'make'  
%
% Last updated March 7, 2013
function makenew( varargin )

% specify targest directory
   mex_src_dir = pwd;
   tmp = fileparts(pwd);
   root_dir = fileparts(tmp);
   cputype = lower( computer );
   target_dir = ['''' root_dir filesep 'mex' filesep cputype ''''];

% specify compile flags appended to all build strings
if ispc,
flags = '-I.\lib .\lib\ldpc-util.c .\lib\math-supp.c';
 else
flags = '-I./lib ./lib/ldpc-util.c ./lib/math-supp.c';
end


% obtain a list of all the files in this directory
if nargin
    desired_file = varargin{1};
    D = dir( strcat( pwd, filesep, desired_file ) );
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
            %%% modify this
            compile_string = ['mex ' D(i).name ' -outdir ', target_dir, ' ', flags ];
            eval( compile_string );
        end
    end
end


%   This function is part of the Iterative Solutions 
%   Coded Modulation Library. The Iterative Solutions Coded Modulation 
%   Library is free software; you can redistribute it and/or modify it 
%   under the terms of the GNU Lesser General Public License as published 
%   by the Free Software Foundation; either version 2.1 of the License, 
%   or (at your option) any later version.
%
%   This library is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   Lesser General Public License for more details.
%  
%   You should have received a copy of the GNU Lesser General Public
%   License along with this library; if not, write to the Free Software
%   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
%
%
