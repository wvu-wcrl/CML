% CmlWorker is the task entry function for cluster-parallelized CML.
%
% The calling syntax is:
%     [sim_param, sim_state] = CmlSimulate( scenario_filename, cases )
%
%     Outputs:
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     Note: See readme.txt for a description of the structure formats.
%
%     Required inputs:
%	  scenario_filename = the name of the file containing an array of sim_param structures.
%     cases = a list of the array indices to simulate.
%
%     Note: Multiple scenario files can be specified.  In this case, the argument list
%     should contain each scenario file to be used followed by the list of array indices
%     to read from that file.
%
%     Example:
%     [sim_param, sim_state] = CmlSimulate( 'Scenario1', [1 2 5], 'Scenario2', [1 4 6] );
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on Oct. 7/13/2012


function TaskState = CmlWorker( InputParam )

% read simulation parameters and state into local workspace
[sim_param sim_state cml_home RandSeed] = ReadParams(InputParam);  

InitCml( cml_home );

SetRandSeed( RandSeed );


[code_param] = ReadCodeParam( cml_home );
% read short code param

%read long code param

% concatenate

%[sim_param, code_param] = InitializeCodeParam( sim_param, cml_home );

 % selects and runs the particular simulation type - throughput, ber
 [sim_param sim_state] = SelectSimTypeAndRun(sim_param, sim_state, code_param); 

TaskState = sim_state;   % return simulation results to generic worker

end





function [sim_param sim_state cml_home RandSeed] = ReadParams(InputParam)

sim_param = InputParam.JobParam;
sim_state = InputParam.JobState;
cml_home = sim_param.cml_home;
RandSeed = sim_param.RandSeed;

end



function InitCml(cml_home)
cd(cml_home);
CmlStartup('cluster');
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


 
 function [code_param] = ReadCodeParam( sim_param, cml_home )

code_param_short = sim_param.code_param_short;

code_param_long = read_code_param_long( sim_param, cml_home );

code_param = concatenate_structs( code_param_short, code_param_long );

 end



function code_param_long = read_code_param_long( sim_param, cml_home )

[str1 str2] = strtok( cml_home, '/' );
[str3 str4] = strtok(str2, '/');
project_path = ['/' str1 '/' str3 '/' 'Projects/cml/data' ];

task_data_file = [sim_param.scenario '_' sim_param.record '.mat'];

project_data_file_path = [project_path '/' task_data_file];

load(project_data_file_path);

end


function struct_concat = concatenate_structs( struct1, struct2 )
fields = fieldnames(struct1);
N = length(fields);
for k = 1:N,
    struct2 = setfield(struct2, fields{k}, getfield( struct1, fields{k}) );
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
