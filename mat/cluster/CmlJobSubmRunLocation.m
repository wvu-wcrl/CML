% CmlJobSubmRunLocation.m
%  Determine run location for the purposes of job submission.
%
% Outputs
%     RunLoc - 'clusterlocal' or 'local'
%               'clusterlocal' - user running cml in their own
%                                linux account
%               'local'          user running cml on local machine
%
%     Last updated on 1/27/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


function RunLoc = CmlJobSubmRunLocation()

  [dc hostname] = system('hostname');
  hostname = hostname(1:end-1);

if strcmp(hostname, 'wcrlCluster')
    RunLoc = 'clusterlocal';
else
    RunLoc = 'local';
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

