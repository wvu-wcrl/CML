% MoveJobOutToCmlOut
%  Move job from output queue to CML output directory.
%
% Inputs
%  job_file       full path to job file
%  scenario_name  cml scenario name
%  record         record number
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

%  Move job from output queue to CML output directory.
function MoveJobOutToCmlOut( job_file, scenario_name, record)
cur_record = record;

load( job_file );
save_param = JobParam;
save_state = JobState;

save_param = SetSimLocationLocal( save_param );

eval( scenario_name );

% issue arose with this syntax while testing scenario LdpcHmat record 3
%save( [cml_home sim_param(cur_record).filename], 'save_param', 'save_state';)
save( [sim_param(cur_record).filename], 'save_param', 'save_state');

delete( job_file );
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



