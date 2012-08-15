% cluster.m
%  Execute given scenario and record using cluster and time execution.
%
%  Inputs
%   1. scenario - CML scenario
%   2. record   - CML record
%   3. cml_root - Path to CML root
%   4. data_file- File storing timing info.
%
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function cluster(scenario, record, cml_root, data_file)

cd(cml_root);
CmlStartup;

CmlClusterConsume;
 
tic;
CmlClusterSubmit(scenario, record);
wait_for_job( scenario, record );
sim_time = toc;
save(data_file, 'sim_time');

CmlClusterConsume
exit
end


function wait_for_job( scenario, record )
[project_root] = CmlReadProjectRoot();

job_name = [ scenario '_' int2str(record) '.mat' ];

job_output_file = [ project_root filesep 'JobOut' filesep job_name ];


fprintf('Waiting for cluster CML job to complete.\n');
while ~exist(job_output_file)
fprintf('.');
pause(2);
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
