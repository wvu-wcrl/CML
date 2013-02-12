% CreateJob.m
% Creates job file for execution.
%
% Inputs
%  scenario           CML scenario name
%  record             Record within scenario
%  JobParam           simulation parameters
%  JobState           simulation state
%  job_input_queue    path to job input queue
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

% create job file for execution.
function CreateJob( scenario, record, JobParam, JobState, job_input_queue )

% the data file for a particular job is assumed to have the same
%  name as the job
job_name = [scenario '_' int2str( record ) '.mat'];
JobParam.code_param_long_filename = job_name;

full_path_job_file = [job_input_queue filesep job_name];
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


