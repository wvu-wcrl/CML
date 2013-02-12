function [sim_param_output, sim_state_output] = ReadScenario( varargin )
% ReadScenario reads simulation parameters from a list of scenario files and the simulation
% results from the corresponding stored data files
%
% The calling syntax is:
%     [sim_param, sim_state] = ReadScenario( scenario_filename, cases [, ...] )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     Note: See readme.txt for a description of the structure formats.
%
%	  scenario_filename = the name of the file containing an array of sim_param structures.
%     cases = a list of the array indices to read. Set to 'all' to read all the
%     scenarios in the file.
%
%     Note: Multiple scenario files can be specified.  In this case, the argument list
%     should contain each scenario file to be used followed by the list of array indices
%     to read from that file.
%
%     Example:
%     [sim_param, sim_state] = ReadScenario( 'Scenario1', [1 2 5], 'Scenario2', [1 4 6] );
%
% Copyright (C) 2006, Matthew C. Valenti
%
% Last updated on Oct. 12, 2007
%
% Function ReadScenario is part of the Iterative Solutions Coded Modulation
% Library (ISCML).
%
% The Iterative Solutions Coded Modulation Library is free software;
% you can redistribute it and/or modify it under the terms of
% the GNU Lesser General Public License as published by the
% Free Software Foundation; either version 2.1 of the License,
% or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

number_of_files = nargin/2;
if (floor(number_of_files) ~= number_of_files)
    % odd number of arguments is a signal to not reset
    % used when plotting
    dont_reset = 1;
else
    dont_reset = 0;
end

% loop over each Scenario file
offset = 0;
for file=1:number_of_files
    scenario_filename = varargin{file*2-1};
    if ischar(scenario_filename)
        cases = varargin{file*2};
        
        % clear, then initialize sim_param and sim_state structures
        clear sim_param sim_state
        
        % load the scenario file
        eval( scenario_filename );
        
        % set cases to 'all' to read all parameters
        if ischar(cases)
            sim_param = sim_param;
            cases=1:length(sim_param);
        else
            sim_param = sim_param( cases );
        end
        
        % load/initialize each scenario
        num_cases = length( cases );
        
        for case_number=1:num_cases
            fprintf( strcat( 'Initializing case (%d):\t', sim_param(case_number).comment, '\n'  ), cases( case_number ) );
            
            sim_param(case_number) = check_for_undefined_MaxRunTime(sim_param(case_number));
            
            
            if ( ( strcmpi( sim_param(case_number).sim_type, 'throughput' ) )||...
                    ( strcmpi( sim_param(case_number).sim_type, 'bwcapacity' ) ) || ...
                    ( strcmpi( sim_param(case_number).sim_type, 'minSNRvsB' ) ) )
                sim_param(case_number).reset = 1;
            end
            
            if dont_reset
                sim_param(case_number).reset = 0;
            end
            
            [sim_param_out(case_number), sim_state(case_number)] = SingleRead( sim_param(case_number) );
            
        end
        sim_param_output(offset+1:offset+num_cases) = sim_param_out(1:num_cases);
        sim_state_output(offset+1:offset+num_cases) = sim_state(1:num_cases);
        offset = offset + num_cases;
    end
end
end


function sim_param_out = check_for_undefined_MaxRunTime(sim_param_in)
if isfield( sim_param_in, 'MaxRunTime' )
    if isempty(sim_param_in.MaxRunTime)
        error('Please define MaxRunTime in all scenario records.');
    else
        sim_param_out = sim_param_in;
    end
    
else
    sim_param_out = sim_param_in;
end

end
