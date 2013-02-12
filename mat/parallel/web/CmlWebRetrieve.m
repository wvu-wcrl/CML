% CmlWebRetrieve.m
% Translate completed WebCML job files in jobs/JobOut to CML output files.
%
% Inputs
%  none
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlWebRetrieve(  )

[cml_home] = CmlLoadCmlHome('local');

LocalJobOut = [cml_home filesep 'jobs' filesep 'JobOut'];

% get list of files in local jobout
listing = GetDirectoryListing( LocalJobOut );

% translate job files to cml output files
ConsumeOutputQueue( LocalJobOut, listing );

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
