% CmlWebSubmit.m
% Creates job file for PCS web-interface submission
%
% Inputs
%  scenario          CML scenario name
%  records            record list
%
%
%     Last updated on 1/24/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlWebSubmit( scenario, records )

cml_home = CmlLoadCmlHome('local');

%[user remote_cmlroot remote_projroot] = ...
%    CmlReadAccountInfo();

CreateJobsWeb(scenario, records);

end


function CreateJobsWeb( scenario, records )

[sim_param sim_state] = ReadScenario( scenario, records );    % read cml records from disk

N = length(records);   % number of simulation records

for k = 1:N,
    JobParam = sim_param(k);   % convert data structures to naming convention used by job manager

    JobState = sim_state(k);    
    
    CreateJobWeb( k, scenario, records(k), JobParam, JobState );
end

end


function CreateJobWeb( k, scenario, record, JobParam, JobState )

[cml_home] = CmlLoadCmlHome('local');

LocalJobsPath = [cml_home filesep 'jobs' filesep 'JobIn'];

JobName = [scenario '_' int2str( record ) '.mat'];

JobParam.code_param_long_filename = JobName;

LocalJobsFile = [LocalJobsPath filesep JobName];

save( LocalJobsFile, 'JobParam', 'JobState' );

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
