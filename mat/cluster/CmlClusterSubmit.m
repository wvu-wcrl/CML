% CmlClusterSubmit.m
% Submit CML scenarios for simulation using the WCRL cluster.
%
% Inputs
%  scenario          CML scenario name
%  records            record list
%
%
%     Last updated on 7/9/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlClusterSubmit( scenario, records )

run_loc = DetermineRunLocation();  % check if local or cluster

switch run_loc,
    
    case 'cluster'
        
        [ project_root ] = CmlReadProjectRoot();        % read user's .cml_cfg to locate project directory
        
        CreateJobsCluster( scenario, records, project_root );  % create job file for this scenario and record
                                                        % and move to user's job input queue
        
    case 'local'
        
        cml_home = CmlLoadCmlHome('local');
        
        [user remote_cmlroot remote_projroot] = ...
            CmlReadAccountInfo();

        N_h = length(cml_home);
        SyncScenario(scenario, user, remote_cmlroot, N_h);
        
        fprintf(['Submitting ' scenario ' ' 'records ' ...
            '[' int2str(records) ']']);
        fprintf(' for cluster execution.\n');
        ExecuteRemoteSims(user, remote_cmlroot, scenario, records);                
        
end


end


function CreateJobsCluster( scenario, records, project_root )

[sim_param sim_state] = ReadScenario( scenario, records );    % read cml records from disk

job_input_queue = [project_root '/' 'JobIn'];

N = length(records);   % number of simulation records
for k = 1:N,
    JobParam = sim_param(k);   % convert data structures to naming convention used by job manager
    JobState = sim_state(k);
    
    CreateJob( k, scenario, records(k), JobParam, JobState,  job_input_queue );
end

end



function FunctionPathRemote = rename_local_remote(FunctionPathLocal)

[dc suffix] = strtok(FunctionPathLocal, '/');

FunctionPathRemote = ['/rhome' suffix];

end



function CreateJob( k, scenario, record, JobParam, JobState, job_input_queue )

%load('CmlHome.mat');    % create path to cml_home
%[dc suffix] = strtok(cml_home, '/');
%cml_home = ['/rhome' suffix];
%JobParam.cml_home = cml_home;

%JobParam.scenario = scenario;  % this might get chopped off in job manager processing
%JobParam.record = record;

job_name = [scenario '_' int2str( record ) '.mat'];  % create job filename
JobParam.code_param_long_filename = job_name;

full_path_job_file = [job_input_queue '/' job_name];
save(full_path_job_file, 'JobParam', 'JobState');% save job file in user's job input queue

end



function SyncScenario(scenario, user, remote_cmlroot, N_h)
fullpath_localscen = which(scenario);
partialpath_localscen = fullpath_localscen(N_h + 1:end);
fullpath_remotescen = [remote_cmlroot partialpath_localscen];

cmd = ['scp' ' ' fullpath_localscen ' ' user...
    '@wcrlcluster.csee.wvu.edu' ':' fullpath_remotescen ' > /dev/null'];
system(cmd);
end



function ExecuteRemoteSims(user, remote_cmlroot, scenario, records)
c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
c2 = ['matlab -r' ' '];
c3 = ['"cd\(\'''];
c4 = [remote_cmlroot];
c5 = ['\''\)'];
c6 = ['\;CmlStartup\;'];
c7 = ['CmlClusterSubmit\('];
c8 = ['\''' scenario '\'','];
c9 = ConstructRecords(records);
c10 = ['\)\;'];
c11 = ['exit" > /dev/null'];
cmd = [c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11];
system(cmd);
end


% construct string of records for cluster exec ssh command
function recstr = ConstructRecords(records)
recstr = '\[';
N = length(records);
for k = 1:N,
    recstr = [recstr int2str(records(k)) '\' ' '];    
end
recstr(end) = '\';
recstr(end) = ']';
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
