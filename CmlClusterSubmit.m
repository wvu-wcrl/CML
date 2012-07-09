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


[] = ReadCmlCfg();        % read user's .cml_cfg to locate project directory

N = length( records );    % how many records are we simulating?

for k = 1:N,        % create a job file for every record
    [sim_state sim_param] = ReadScenario( scenario, records(k) );
    
    CreateJob( sim_param, sim_state );  % create job file for this scenario and record
    % and move to user's job input queue    
end




end



function ReadCmlCfg()

UTIL_PATH = '/home/pcs/util';   % add path to file reading utility
addpath(UTIL_PATH);

CML_PROJ_CF = get_proj_cf();     % path to user cml project file

% get path to cml
heading = '[GeneralSpec]';
key = 'CmlRoot';
out = util.fp(CML_PROJ_CF, heading, key);
CML_ROOT = out{1};

% get path to cml project root
heading = '[GeneralSpec]';
key = 'ProjectRoot';
out = util.fp(CML_PROJ_CF, heading, key);
obj.gq.iq = out{1};

end


function cf_path = get_proj_cf()    % get config file for this user
[dontcare USER] = system('whoami');

CML_PROJ_CFG_FILE = '.cml_cfg';
cf_path = ['/home' '/' USER '/' CML_PROJ_CFG_FILE];
end



function CreateJob( sim_param, sim_state )
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
