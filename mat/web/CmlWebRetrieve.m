% CmlWebRetrieve.m
% Creates job file for PCS web-interface submission
%
% Inputs
%  none
%
%
%     Last updated on 2/5/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlWebRetrieve(  )

% set path to JobOut
[cml_home] = CmlLoadCmlHome('local');

LocalJobOut = [cml_home filesep 'jobs' filesep 'JobOut'];

listing = GetDirectoryListing( LocalJobOut );

consume_output_queue( LocalJobOut, listing);

end


function consume_output_queue( output_queue, listing )
N = size( listing );
for k = 1:N,
    [scenario_name record] = read_scenario_name_and_record( listing(k).name );
    full_path_to_output_file = [ output_queue filesep listing(k).name ];
    move_job_out_to_cml_out( full_path_to_output_file, scenario_name, record);
end
end


% read scenario name and record as strings
function [scenario_name record] = read_scenario_name_and_record( name_record )
[scenario_name suffix] = strtok( name_record, '_' );
record = str2double( suffix(1:end-4) );

flipped_name_record = name_record(end:-1:1);
[rec_flip scen_flip] = strtok( flipped_name_record, '_' );


scenario_name = scen_flip( end : -1 : 1+1 );

rec_flipped_back = rec_flip(end:-1:1);
record = str2double( strtok(rec_flipped_back, '.') );
end



% convert job output file to cml output file, move to cml out, and delete
% job out
function move_job_out_to_cml_out( full_path_to_job_output_file, scenario_name, record)
cur_record = record;

load( full_path_to_job_output_file );
save_param = JobParam;
save_state = JobState;

save_param = SetSimLocationLocal( save_param );

eval( scenario_name );

% issue arose with this syntax while testing scenario LdpcHmat record 3
%save( [cml_home sim_param(cur_record).filename], 'save_param', 'save_state';)
save( [sim_param(cur_record).filename], 'save_param', 'save_state');

delete( full_path_to_job_output_file );
end


function save_param = SetSimLocationLocal( save_param )
save_param.SimLocation = 'local';
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
