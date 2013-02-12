% CmlWebSubmit.m
% Creates job file for WebCML web-interface submission
%
% Inputs
%  scenario          CML scenario name
%  records           record list
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlWebSubmit( scenario, records )

[cml_home] = CmlLoadCmlHome('local');

local_jobs_path = [cml_home filesep 'jobs'];

% create job files from the specified scenarios and records
CreateJobs(scenario, records, local_jobs_path);

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
