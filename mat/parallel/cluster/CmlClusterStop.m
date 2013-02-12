% CmlClusterStop.m
%  Stop running CML cluster jobs.
%
%    If no inputs are given, all currently running jobs are stopped.
%
%    Giving a scenario and set of records as input stops only the jobs
%     specified.
%
% Inputs
%
%  Input case 1
%  scenario          CML scenario name  Ex: 'FskScenarios'
%  records           record list           Ex: [1 4 5]
%
%
%  Input case 2
%  No inputs
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlClusterStop( varargin )

[ mode scenario records ] = DetermineModeBasedOnInput( varargin{:} );

switch mode,
    case 'stop_all_jobs',
        StopAllJobs();
    case 'stop_specified_jobs'
        StopSpecifiedJobs( scenario, records );
end

end


% determine whether to stop all jobs or specified jobs. 
function [ mode, varargout] = DetermineModeBasedOnInput( varargin )

nout = max(nargout,1)-1;

num_args = length( varargin );
if num_args == 0,
    mode = 'stop_all_jobs';
    for k =1:nout, varargout(k) = cell(1); end
elseif num_args == 2,
    mode = 'stop_specified_jobs';
    varargout(1) = varargin(1);
    varargout(2) = varargin(2);
else
    ErrStr1 = ['Incorrect number of input arguments.'];
    ErrStr2 = [' Type ''help CmlClusterStop''\n'];
    ErrStr = [ErrStr1 ErrStr2];
    error(ErrStr);
end

end


% stop all running jobs.
function StopAllJobs()

[project_root] = ReadProjectRoot();

job_running_dir = [project_root filesep 'JobRunning'];
job_output_dir =  [project_root filesep 'JobOut'];

running_jobs = dir( [job_running_dir filesep '*.mat'] );

N = length(running_jobs);

if N == 0,
    fprintf('No jobs to stop.\n');
end

for n = 1:N,
    current_file = [job_running_dir filesep running_jobs(n).name];
    movefile(current_file, job_output_dir);
    fprintf('Stopping job %s.\n', running_jobs(n).name(1:end-4) );
end

end


% stop specified jobs.
function StopSpecifiedJobs( scenario, records )

[ project_root ] = ReadProjectRoot();
path_to_running_queue = [project_root filesep 'JobRunning'];
path_to_output_queue = [project_root filesep 'JobOut'];

% construct job names for all scenarios and records
N = length(records);

for n = 1:N,
    job_name{n} = [scenario '_' int2str( records(n) ) '.mat'];
    full_path_to_job{n} = [ path_to_running_queue filesep job_name{n}];
end

% iterate over job names, moving from running to output
for n = 1:N,
    if exist( full_path_to_job{n} )
        movefile( full_path_to_job{n}, path_to_output_queue);
        fprintf('Stopping job %s.\n', job_name{n}(1:end-4) );
    else
        fprintf('Warning: job %s does not exist.\n', job_name{n}(1:end-4) );
    end
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
