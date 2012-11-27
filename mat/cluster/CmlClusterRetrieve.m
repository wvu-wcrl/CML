% CmlClusterRetrieve.m
% Retrieve CML scenarios completed by PCS.
%
% Inputs
%  No arguments      Retrieve all completed jobs
%
%  scenario          CML scenario name
%  records            record list
%
%
%     Last updated on 10/1/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlClusterRetrieve( )

run_loc = DetermineRunLocation()  % check if local or cluster


switch run_loc,
    
    case 'cluster'
        [project_root] = ReadCmlCfg();
        
        running_queue = [project_root '/JobRunning'];
        listing = GetDirectoryListing( running_queue );
        consume_running_queue( running_queue, listing );
        
        output_queue = [project_root '/JobOut'];
        
        listing = GetDirectoryListing( output_queue );
        consume_output_queue( output_queue, listing );
        
    case 'local'
        
        
        cml_home = CmlLoadCmlHome('local');
        [user remote_cmlroot remote_projroot] = ...
            CmlReadClusterCfg(cml_home);
        
        ReportJobStatus(user, remote_projroot);
               
        ConsumeRemoteJobs(user, remote_cmlroot, remote_projroot);        
        
end

end



function ReportJobStatus( user, remote_projroot )

fprintf('Running Jobs:\n');
c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
c2 = ['ls ' remote_projroot '/JobRunning/ | grep -i .mat'];
cmd = [c1 c2];
[dc running_jobs] = system(cmd);
fprintf(running_jobs);

fprintf('\n');

fprintf('Completed Jobs:\n');
c2 = ['ls ' remote_projroot '/JobOut/ | grep -i .mat'];
cmd = [c1 c2];
[dc completed_jobs] = system(cmd);
fprintf(completed_jobs);


%c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
%c2 = ['matlab -r' ' '];
%c3 = ['"cd\(\'''];
%c4 = [remote_cmlroot];
%c5 = ['\''\)'];
%c6 = ['\;CmlStartup\;'];
%c7 = ['PrintRunningScenarios\('];
%c8 = ['\''' queue '\'''];
%c9 = ['\)\;'];
%c10 = ['exit"'];
%cmd = [c1 c2 c3 c4 c5 c6 c7 c8 c9 c10];
%system(cmd);
end


function ConsumeRemoteJobs( user, remote_cmlroot, remote_projroot )

c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
c2 = ['matlab -r' ' '];
c3 = ['"cd\(\'''];
c4 = [remote_cmlroot];
c5 = ['\''\)'];
c6 = ['\;CmlStartup\;'];
c7 = ['CmlClusterRetrieve'];
c8 = ['\;'];
c9 = ['exit"'];

cmd = [c1 c2 c3 c4 c5 c6 c7 c8 c9];
system(cmd);
end



function consume_running_queue( running_queue, listing )
N = size( listing );
for k = 1:N,
    [scenario_name record] = read_scenario_name_and_record( listing(k).name );
    full_path_to_output_file = [ running_queue '/' listing(k).name ];
    copy_job_out_to_cml_out( full_path_to_output_file, scenario_name, record);
end
end



function consume_output_queue( output_queue, listing )
N = size( listing );
for k = 1:N,
    [scenario_name record] = read_scenario_name_and_record( listing(k).name );
    full_path_to_output_file = [ output_queue '/' listing(k).name ];
    move_job_out_to_cml_out( full_path_to_output_file, scenario_name, record);
end
end



function [scenario_name record] = read_scenario_name_and_record( name_record )
[scenario_name suffix] = strtok( name_record, '_' );
record = str2double( suffix(1:end-4) );

flipped_name_record = name_record(end:-1:1);
[rec_flip scen_flip] = strtok( flipped_name_record, '_' );


scenario_name = scen_flip( end : -1 : 1+1 );

rec_flipped_back = rec_flip(end:-1:1);
record = str2double( strtok(rec_flipped_back, '.') );
end



function move_job_out_to_cml_out( full_path_to_job_output_file, scenario_name, record)

cur_record = record;

load( full_path_to_job_output_file );
save_param = JobParam;
save_state = JobState;

save_param = SetSimLocationLocal( save_param );

eval( scenario_name );


save( [cml_home sim_param(cur_record).filename], 'save_param', 'save_state');

delete( full_path_to_job_output_file );

end


function  copy_job_out_to_cml_out( full_path_to_job_output_file, scenario_name, record )

load( full_path_to_job_output_file );
save_param = JobParam;
save_state = JobState;

save_param = SetSimLocationLocal( save_param );

eval( scenario_name );

save( [cml_home sim_param(record).filename], 'save_param', 'save_state');

end


function save_param = SetSimLocationLocal( save_param )
save_param.SimLocation = 'local';
end







function [ project_root ] = ReadCmlCfg()

util_path = '/home/pcs/util';   % add path to file reading utility
addpath(util_path);

cml_proj_cf = get_proj_cf();     % path to user cml project file

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
%project_root = project_root(1:end-1);  %TEMP

end



function user = get_current_user()
[dontcare user] = system('whoami');
user = user(1:end-1);
end



function cf_path = get_proj_cf()    % get config file for this user
user = get_current_user();

cml_proj_cf = 'cml_cfg';
cf_path = ['/home' '/' user '/' cml_proj_cf];
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
