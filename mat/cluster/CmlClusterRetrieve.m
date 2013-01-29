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
%  Running on the cluster retrieves completed jobs, converts them to
%   CML output files, and places the output files in CML's output
%   directory.
%
%  Running locally connects to the cluster, performs the steps described
%  above, and copies the CML output directory on the
%  cluster to the output directory for the CML output directory stored locally.
%
%     Last updated on 11/27/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlClusterRetrieve( )

RunLoc = CmlJobSubMRunLocation();

switch RunLoc,
    
    case 'clusterlocal'
        [project_root] = ReadCmlCfg();
       
        running_queue = [project_root '/JobRunning'];
        listing = GetDirectoryListing( running_queue );
        consume_running_queue( running_queue, listing );
        
        output_queue = [project_root '/JobOut'];
        listing = GetDirectoryListing( output_queue );
        consume_output_queue( output_queue, listing );
        
    case 'local'
        
        cml_home = CmlLoadCmlHome('local');
        [user remote_cmlroot remote_projroot] =  CmlReadAccountInfo(cml_home);
        
        ReportRemoteJobStatus(user, remote_projroot);
        
        RetrieveRemoteJobs(user, remote_cmlroot);
        
end

end


% print status of user's cluster jobs
function ReportRemoteJobStatus( user, remote_projroot )

fprintf('Running Jobs:\n');
PrintMatFilesInProjDir(user, remote_projroot, 'JobRunning');

fprintf('\n');

fprintf('Completed Jobs:\n');
PrintMatFilesInProjDir(user, remote_projroot, 'JobOut');

fprintf('\n');
end


% print a list of .mat files in a remote project directory
function PrintMatFilesInProjDir(user, remote_projroot, remote_projdir)
c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];

% get listing of mat files in user's cluster JobRunning/
c2 = ['ls ' remote_projroot '/' remote_projdir '/' ' | grep -i .mat'];
cmd = [c1 c2];
[dc running_jobs] = system(cmd);
fprintf(running_jobs);
end


% retrieve CML output files for completed cluster jobs 
function RetrieveRemoteJobs( user, remote_cmlroot )

ExecRemoteCmlClusterRetrieve(user, remote_cmlroot);

RetrieveRemoteOutput(user, remote_cmlroot);

end



function ExecRemoteCmlClusterRetrieve(user, remote_cmlroot)
c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
c2 = ['matlab -r' ' '];
c3 = ['"cd\(\'''];
c4 = [remote_cmlroot];
c5 = ['\''\)'];
c6 = ['\;CmlStartup\;'];
c7 = ['CmlClusterRetrieve'];
c8 = ['\;'];
c9 = ['exit" > /dev/null'];

cmd = [c1 c2 c3 c4 c5 c6 c7 c8 c9];
system(cmd);
end


function RetrieveRemoteOutput(user, remote_cmlroot)

cml_home = CmlLoadCmlHome('local');
% copy remote output to local output
fprintf('Consuming remote CML output.\n');
cmd1 = ['scp -r ' user '@wcrlcluster.csee.wvu.edu:'];
cmd2 = [remote_cmlroot '/output/*' ' ' ];
cmd3 = [ cml_home '/output > /dev/null'];
cmd = [cmd1 cmd2 cmd3];

system(cmd);
end


% copy intermediate results from JobRunning to CML output
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


% convert job running file file to cml output file, copy to cml out, and leave 
% running file in place
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
