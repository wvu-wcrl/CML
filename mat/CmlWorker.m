function TaskState = CmlWorker( TaskParam )

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


% read simulation parameters and state into local workspace
[sim_param sim_state cml_home] = ReadParams(TaskParam);  

InitCml(cml_home);

[sim_param, code_param] = InitializeCodeParam( sim_param, cml_home );

 % selects and runs the particular simulation type - throughput, ber
[sim_param sim_state] = SelectSimTypeAndRun(sim_param, code_param); 

TaskState = sim_state;   % return simulation results to generic worker

%TaskParam.sim_param = sim_param;
%TaskParam.sim_state = sim_state;
end



function [sim_param sim_state cml_home] = ReadParams(TaskParam)
sim_param = TaskParam.sim_param;
sim_state = TaskParam.sim_state;
cml_home = TaskParam.cml_home;
end



function InitCml(cml_home)
cd(cml_home);
CmlStartup;
end



function [sim_param sim_state] = SelectSimTypeAndRun(sim_param, code_param)

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
