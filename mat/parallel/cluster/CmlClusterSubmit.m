% CmlClusterSubmit.m
% Submit CML scenarios for simulation using the WCRL cluster.
%
% Inputs
%  scenario          CML scenario name
%  records           record list
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlClusterSubmit( scenario, records )

location = CmlJobSubMRunLocation();  % check if local or cluster

switch location,
    
    % submit job while running directly on the cluster
    case 'clusterlocal'
        
        % read location of user's project root
        [ project_root ] = ReadProjectRoot();

        % copy data files requested by simulation to project data directory
        CopyCmlDat2ProjDat( scenario, records, project_root );
        
        % create cluster jobs from given scenario and records and
        %  move to job input queue
        CreateJobs( scenario, records, project_root );
        
        % submit job directly to cluster while running on user's computer.
        % functionality not fully implemented, so not officially supported.
    case 'local'
        cml_home = CmlLoadCmlHome('local');
        
        % read linux account info used on cluster
        [user remote_cmlroot remote_projroot] = ...
            CmlReadAccountInfo();
        
        % N_h used in constructing partial path to scenario files.
        N_h = length(cml_home);
        
        % push local scenarios to copy of cml on cluster
        SyncScenario(scenario, user, remote_cmlroot, N_h);
        fprintf(['Submitting ' scenario ' ' 'records ' ...
            '[' int2str(records) ']']);
        fprintf(' for cluster execution.\n');
        
        % start jobs by executing CmlClusterSubmit directly on cluster.
        ExecuteRemoteSims(user, remote_cmlroot, scenario, records);
end
end


% copy data files requested by simulation to project data directory
function CopyCmlDat2ProjDat( scenario, records, project_root )

% load scenarios and records
[sim_param sim_state] = ReadScenario( scenario, records );


N = length(records);
for k = 1:N,    
    
    % ldpc parity check matrices.
    % later: convert to switch statement
    if( sim_param(k).code_configuration == 2 ) % ldpc
        pcm = sim_param(k).parity_check_matrix;
        hmat_type = GetHmatType( pcm );
        switch hmat_type,
            case 'cml_dvbs2'
            case 'pchk'
                CopyPchktoJobData( pcm, project_root );
            case 'alist'
                CopyPchktoJobData( pcm, project_root );
            case 'mat'
                CopyPchktoJobData( pcm, project_root );
            case 'random'
            case 'not_supported'
        end
    end
    
    
end

end



function CopyPchktoJobData( pcm, project_root )

[ cml_home ] = CmlLoadCmlHome('clusterlocal');

% construct path to parity check matrix in cml
cml_data_file = fullfile( cml_home, 'data', 'ldpc', pcm );

% construct path to data file in project directory
proj_data_file = fullfile( project_root, 'Data', pcm );

% produce an error if the data file does not exist
if ~exist( cml_data_file, 'file' )
    ErrStr = sprintf(['Project data file %s does not exist'], ...
        proj_data_file);
    error(ErrStr);
end

% copy parity check matrix to data file
copyfile( cml_data_file, proj_data_file );

end


% push local scenario files to cluster copy of cml
function SyncScenario(scenario, user, remote_cmlroot, N_h)
fullpath_localscen = which(scenario);
partialpath_localscen = fullpath_localscen(N_h + 1:end);
fullpath_remotescen = [remote_cmlroot partialpath_localscen];


cmd = ['scp' ' ' fullpath_localscen ' ' user...
    '@wcrlcluster.csee.wvu.edu' ':' fullpath_remotescen ' > /dev/null'];
system(cmd);
end


% execute jobs by running CmlClusterSubmit on the cluster
function ExecuteRemoteSims(user, remote_cmlroot, scenario, records)
c1 = ['ssh' ' ' user '@wcrlcluster.csee.wvu.edu '];
c2 = ['matlab -r' ' '];
c3 = ['"cd\(\'''];
c4 = [remote_cmlroot];
c5 = ['\''\)'];
c6 = ['\;CmlStartup\;'];
c7 = ['CmlClusterSubmit\('];
c8 = ['\''' scenario '\'','];
c9 = ConstructRecords(records);
c10 = ['\)\;'];
c11 = ['exit" > /dev/null'];
cmd = [c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11];
system(cmd);
end


% construct string of records for cluster exec ssh command
function recstr = ConstructRecords(records)
recstr = '\[';
N = length(records);
for k = 1:N,
    recstr = [recstr int2str(records(k)) '\' ' '];
end
recstr(end) = '\';
recstr(end) = ']';
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
