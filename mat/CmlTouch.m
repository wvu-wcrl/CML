function [sim_param, sim_state] = CmlTouch( varargin )
% CmlTouch touches files, useful for upgrading to new version.
%
% The calling syntax is:
%     [sim_param, sim_state] = CmlTouch( scenario_filename, cases )
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
%     [sim_param, sim_state] = CmlTouch( 'Scenario1', [1 2 5], 'Scenario2', [1 4 6] );
%
%     Copyright (C) 2005-2006, Matthew C. Valenti
%
%     Last updated on Mar. 15, 2006
%
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

% setup structures and retrieve data
[sim_param, sim_state] = ReadScenario( varargin{:} );
number_cases = length( sim_param );

for ( case_number=1:number_cases )
    % Initialize code_param (will be [] if not a coded simulation)
    code_param = InitializeCodeParam( sim_param(case_number) );
    
    sim_param(case_number).rate = code_param.rate; % needed for CmlPlot to work correctly
    
    fprintf( '\n' );
    fprintf( sim_param(case_number).comment );
    fprintf( '\n' );
    
    % save
    save_state = sim_state(case_number);
    save_param = sim_param(case_number);
    save(sim_param(case_number).filename, code_param.save_flag, 'save_state', 'save_param' );      
   

end