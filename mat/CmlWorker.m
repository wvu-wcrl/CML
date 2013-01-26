% CmlWorker is the task entry function for cluster-parallelized CML.
%
% The calling syntax is:
%     TaskState = CmlWorker( InputParam )
%
%     Output:
%     TaskState = A structure containing the simulation state.
%     Note: See readme.txt for a description of the structure formats.
%
%     Required inputs:
%	  
%
%     Example:
%     
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on 08/03/2012.


function TaskState = CmlWorker( InputParam )

[sim_param sim_state cml_rhome RandSeed wid] = ReadParams(InputParam);

InitCml( cml_rhome, wid );

[sim_param] = SetLocationToCluster(sim_param);

SetRandSeed( RandSeed );

[code_param] = ReadCodeParam( sim_param, cml_rhome );

[sim_param sim_state] = SelectSimTypeAndRun(sim_param, sim_state, code_param);

TaskState = sim_state;   % return simulation results to generic worker.

end



function [sim_param sim_state cml_rhome RandSeed wid] = ReadParams(InputParam)

sim_param = InputParam.JobParam;      % cml data structures
sim_state = InputParam.JobState;

RandSeed = InputParam.RandSeed;       % parameters general to any task
MaxRunTime = InputParam.MaxRunTime;

sim_param.MaxRunTime = MaxRunTime;    % SimulateMod expects MaxRuntime
                                      % to reside in sim_param

cml_rhome = sim_param.cml_rhome;      % derived parameters
wid = InputParam.wid;

end



function InitCml(cml_rhome, wid)
cd(cml_rhome);
cd('mat');
CmlInit(cml_rhome, 'clusterworker', wid);
end


function sim_param = SetLocationToCluster( sim_param )
  sim_param.SimLocation = 'clusterworker';
end


function [sim_param sim_state] = SelectSimTypeAndRun(sim_param, sim_state, code_param)

if ( ( strcmp( sim_param.sim_type, 'throughput' ) ) )
    [sim_param, sim_state] = CalculateThroughput( sim_param, sim_state, code_param );
    
elseif ( ( strcmp( sim_param.sim_type, 'bwcapacity' ) ) )
    [sim_param, sim_state] = CalculateMinSNR( sim_param, sim_state, code_param );
    
elseif ( ( strcmp( sim_param.sim_type, 'minSNRvsB' ) ) )
    fprintf( '\n minSNRvsB\n\n' );
    [sim_param, sim_state] = CalculateMinSNRvsB( sim_param, sim_state, code_param );
else
    % determine if mat or exe is called
    
    if ( sim_param.compiled_mode == 0 )
        % run the matlab version
        sim_state = SingleSimulate( sim_param, sim_state, code_param );
    else
        % run the compiled exe in stand-alone mode
        save('SimSetup.mat','code_param');
        save_param = sim_param;
        save_state = sim_state;
        
        save('SimState.mat','save_param','save_state');
        !SingleSimulate &
    end
end

end



function PrevStream = SetRandSeed(SeedValue)
if( nargin<1 || isempty(SeedValue) ), SeedValue = 1000*sum(clock); end
if( verLessThan('matlab','7.7') || ~exist('RandStream','class') )
    % RandStream class was added to MATLAB Version 7.7 Release (R2008b).
    PrevStream = rand('twister');
    rand('twister',SeedValue);
    randn('state',SeedValue);
else
    % In newer than Version 7.7 Release (R2008b) of MATLAB, it is recommended to use RandStream class.
    CurRndStream = RandStream('mt19937ar','Seed',SeedValue);
    MethodList = methods(CurRndStream);
    if sum( strcmpi(MethodList,'setGlobalStream') )==1
        PrevStream = RandStream.setGlobalStream(CurRndStream);
    elseif sum( strcmpi(MethodList,'setDefaultStream') )==1
        PrevStream = RandStream.setDefaultStream(CurRndStream);
    end
end
end



function [code_param] = ReadCodeParam( sim_param, cml_rhome )

code_param_short = sim_param.code_param_short;

code_param_long = read_code_param_long( sim_param, cml_rhome );

code_param = concatenate_structs( code_param_short, code_param_long );

end



function code_param_long = read_code_param_long( sim_param, cml_rhome )

[str1 str2] = strtok( cml_rhome, filesep );
[str3 str4] = strtok(str2, filesep);
project_path = fullfile(filesep, str1, str3, 'Projects', 'cml', 'data');

task_data_file = sim_param.code_param_long_filename;

project_data_file_path = fullfile(project_path, task_data_file);

if exist( project_data_file_path, 'file' ) == 0,
    code_param_long = struct;  % create empty struct
else
    load(project_data_file_path);
end

end



function struct_concat = concatenate_structs( struct1, struct2 )
fields = fieldnames(struct1);
N = length(fields);

for k = 1:N,
    current_field = fields{k};
    field_value = getfield( struct1, current_field );
    struct2 = setfield(struct2, current_field, field_value );
end

struct_concat = struct2;
end

%     Function CmlSimulate is part of the Iterative Solutions Coded Modulation
%     Library (ISCML).
%
%     The Iterative Solutions Coded Modulation Library is free software;
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
