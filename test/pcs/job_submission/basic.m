% basic.m
% Test basic functionality of CML job manager.
%
% Inputs
%
%     Last updated on 8/9/2012
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


%%%%%%%%%% insert delays to allow time for job file propagation through queues
function basic( )

   submit_test_job();

   wait_for_job_completion();

   consume_job();

end




function submit_test_job()
fprintf('Submitting test job:  scenario t_BerSim,  record 1.\n');
CmlClusterSubmit('t_BerSim', 1);
end



function wait_for_job_completion()

  monitor_output_job();

end



function monitor_output_job()

[ project_root ] = CmlReadProjectRoot();
output_job_file = [project_root filesep 'JobOut' filesep 't_BerSim_1.mat'];

warning('off', 'MATLAB:DELETE:FileNotFound')
delete(output_job_file);


fprintf('\n');
fprintf('Waiting 60 seconds for job completion.\n');

tic;
job_is_done = exist(output_job_file);
while( ~ job_is_done & toc < 60 )
job_is_done = exist(output_job_file);
fprintf('.');
pause(2);
end

fprintf('\n');

if job_is_done,
  fprintf('Successful test job.\n');
 else,
   fprintf('Unsuccessful test job. JM/TC not operating properly.\n');
end
end



function consume_job()
  CmlClusterConsume();
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
