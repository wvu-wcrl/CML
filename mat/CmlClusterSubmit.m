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

[ project_root ] = ReadCmlCfg();        % read user's .cml_cfg to locate project directory

CreateJobs( scenario, records, project_root );  % create job file for this scenario and record
                                                                                  % and move to user's job input queue
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
key = 'ProjectRoot';
out = util.fp(cml_proj_cf, heading, key);
project_root = out{1}{1};

end



function cf_path = get_proj_cf()    % get config file for this user
[dontcare user] = system('whoami');
user = user(1:end-1);

cml_proj_cf = '.cml_cfg';
cf_path = ['/home' '/' user '/' cml_proj_cf];
end




function CreateJobs( scenario, records, project_root )

[sim_param sim_state] = ReadScenario( scenario, records );    % read cml records from disk

job_input_queue = [project_root '/' 'JobIn'];

%CML_ROOT_REMOTE = rename_local_remote(CML_ROOT);

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



function CreateJob( k, scenario, records, JobParam, JobState, job_input_queue )

%load('CmlHome.mat');    % create path to cml_home
%[dc suffix] = strtok(cml_home, '/');
%cml_home = ['/rhome' suffix];
%JobParam.cml_home = cml_home;

job_name = [scenario '_' int2str( records ) '.mat'];  % create job filename

full_path_job_file = ['/' job_input_queue '/' job_name];
save(full_path_job_file, 'JobParam', 'JobState');% save job file in user's job input queue

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
