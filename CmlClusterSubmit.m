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

[ PROJECT_ROOT ] = ReadCmlCfg();        % read user's .cml_cfg to locate project directory

[sim_param sim_state] = ReadScenario( scenario, records );    % read cml records from disk

CreateJob( scenario, records, sim_param, sim_state, PROJECT_ROOT );  % create job file for this scenario and record
                                                                                  % and move to user's job input queue
end














function [ PROJECT_ROOT ] = ReadCmlCfg()

UTIL_PATH = '/home/pcs/util';   % add path to file reading utility
addpath(UTIL_PATH);

CML_PROJ_CF = get_proj_cf();     % path to user cml project file

% get path to cml
heading = '[GeneralSpec]';
key = 'CmlRoot';
out = util.fp(CML_PROJ_CF, heading, key);
CML_ROOT = out{1};

addpath(CML_ROOT);

% get path to cml project root
heading = '[GeneralSpec]';
key = 'ProjectRoot';
out = util.fp(CML_PROJ_CF, heading, key);
PROJECT_ROOT = out{1};

end



function cf_path = get_proj_cf()    % get config file for this user
[dontcare USER] = system('whoami');

CML_PROJ_CFG_FILE = '.cml_cfg';
cf_path = ['/home' '/' USER '/' CML_PROJ_CFG_FILE];
end



function CreateJob( scenario, records, sim_param, sim_state, PROJECT_ROOT )

JobParam = sim_param;   % convert data structures to naming convention used by job manager
JobState = sim_state;

job_name = [scenario '_' int2str( records(1) ) '_' int2str( records(end) ) '.mat'];  % create job filename

job_input_queue = [PROJECT_ROOT '/' 'JobIn'];

full_path_job_file = [job_input_queue job_name];

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
