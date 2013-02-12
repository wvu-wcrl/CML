% ReadProjectRoot.m
%
%  Read cluster CML job queue root.
%
% Inputs
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function [ project_root ] = ReadProjectRoot()

% add path to file reading utility
util_path = '/home/pcs/util';   
addpath(util_path);

% path to user cml project file
cml_proj_cf = GetProjCf();     

% get path to cml
heading = '[GeneralSpec]';
key = 'CodeRoot';
out = util.fp(cml_proj_cf, heading, key);
cml_home = out{1}{1};

addpath(cml_home);

% get path to cml project root
heading = '[GeneralSpec]';
key = 'JobQueueRoot';
out = util.fp(cml_proj_cf, heading, key);
project_root = out{1}{1};
project_root = project_root(1:end);  %TEMP

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
