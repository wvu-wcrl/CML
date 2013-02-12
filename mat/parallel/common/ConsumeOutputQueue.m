% ConsumeOutputQueue.m
% Move job files from job output queue to cml output directory.
%
% Inputs
%  output_queue      path to output queue
%  listing           directory listing of output queue
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


% move job file from project output queue to cml output
function ConsumeOutputQueue( output_queue, listing )
N = size( listing );
for k = 1:N,
    [scenario_name record] = ReadScenarioNameAndRecord( listing(k).name );
    full_path_to_output_file = [ output_queue filesep listing(k).name ];
    MoveJobOutToCmlOut( full_path_to_output_file, scenario_name, record);
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
