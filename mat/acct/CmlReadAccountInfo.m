% CmlReadAccountInfo.m
% Read user's PCS account info.
%
% Inputs
%  None.
%
% Outputs
%  user             Username
%  remote_cmlroot   Location of CML on cluster
%  remote_projroot  Location of user project directory on cluster
%
%     Last updated on 1/24/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function [user remote_cmlroot remote_projroot] = ...
    CmlReadAccountInfo()

[cml_home] = CmlLoadCmlHome('local');

cfp = strcat(cml_home, '/cfg/webcml');

Ex = CmlCfgEx();
if strcmp( Ex, 'no' )
    fprintf('WebCML account information not configured.\n');
    CmlSetupAccount();
end


heading = '[cfg]';
key = 'USER';
out = util.fp(cfp, heading, key);
user = out{1}{1};

key = 'REMOTE_CMLROOT';
out = util.fp(cfp, heading, key);
remote_cmlroot = out{1}{1};

key = 'REMOTE_PROJROOT';
out = util.fp(cfp, heading, key);
remote_projroot = out{1}{1};

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
