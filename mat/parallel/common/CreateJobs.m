% CreateJobs.m
% Read simulation parameters for jobs given a scenario and set of records.
%
% Inputs
%  scenario           CML scenario name
%  records            Records within scenario
%  job_root           Root of job directories
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

% Read simulation parameters for jobs given a scenario and set of records.
% For each record, create a job file and place in input queue.
function CreateJobs( scenario, records, job_root )

[sim_param sim_state] = ReadScenario( scenario, records );   

job_input_queue = [job_root filesep 'JobIn'];

% convert cml data structures to naming convention used by job manager
N = length(records); 
for k = 1:N,
    JobParam = sim_param(k);   
    JobState = sim_state(k);
    
    CreateJob(  scenario, records(k), JobParam, JobState,...
               job_input_queue );
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


