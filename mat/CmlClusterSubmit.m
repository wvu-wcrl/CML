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

[ CML_ROOT PROJECT_ROOT ] = ReadCmlCfg();        % read user's .cml_cfg to locate project directory

CreateJobs( scenario, records, PROJECT_ROOT, CML_ROOT );  % create job file for this scenario and record
                                                                                  % and move to user's job input queue
end





function [ CML_ROOT PROJECT_ROOT ] = ReadCmlCfg()

UTIL_PATH = '/home/pcs/util';   % add path to file reading utility
addpath(UTIL_PATH);

CML_PROJ_CF = get_proj_cf();     % path to user cml project file

% get path to cml
heading = '[GeneralSpec]';
key = 'CmlRoot';
out = util.fp(CML_PROJ_CF, heading, key);
CML_ROOT = out{1}{1};

addpath(CML_ROOT);

% get path to cml project root
heading = '[GeneralSpec]';
key = 'ProjectRoot';
out = util.fp(CML_PROJ_CF, heading, key);
PROJECT_ROOT = out{1}{1};

end



function cf_path = get_proj_cf()    % get config file for this user
[dontcare USER] = system('whoami');
USER = USER(1:end-1);

CML_PROJ_CFG_FILE = '.cml_cfg';
cf_path = ['/home' '/' USER '/' CML_PROJ_CFG_FILE];
end




function CreateJobs( scenario, records, PROJECT_ROOT, CML_ROOT )

[sim_param sim_state] = ReadScenario( scenario, records );    % read cml records from disk

CML_CLUSTER_WORKER = 'CmlWorker';    % PCS specific worker function.

JOB_INPUT_QUEUE = [PROJECT_ROOT '/' 'JobIn'];
FunctionName = CML_CLUSTER_WORKER;   % TaskParam structure fields

CML_ROOT_REMOTE = rename_local_remote(CML_ROOT);

FunctionPath = [CML_ROOT '/' 'mat'];   %Construct function path.
FunctionPath = rename_local_remote(FunctionPath);

N = length(records);   % number of simulation records
for k = 1:N,
    JobParam = sim_param(k);   % convert data structures to naming convention used by job manager
    JobState = sim_state(k);
   
    CreateJob(k, scenario, records(k), JobParam, JobState,  JOB_INPUT_QUEUE, FunctionPath, FunctionName);
end

end


function FunctionPathRemote = rename_local_remote(FunctionPathLocal)

[dc suffix] = strtok(FunctionPathLocal, '/');

FunctionPathRemote = ['/rhome' suffix];

end


function CreateJob(k, scenario, records, JobParam, JobState, JOB_INPUT_QUEUE, FunctionPath, FunctionName)

JOB_NAME = [scenario '_' int2str( records ) '.mat'];  % create job filename

full_path_job_file = ['/' JOB_INPUT_QUEUE '/' JOB_NAME];
save(full_path_job_file, 'JobParam', 'JobState', 'FunctionName', 'FunctionPath');% save job file in user's job input queue

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
