function sim_state = SingleSimulate( varargin )
% Simulate runs a single simulation
%
% The calling syntax is:
%     [sim_param, sim_state] = SingleSimulate( sim_param, sim_state, code_param )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining information about the channel code.
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2006-2007, Matthew C. Valenti 
%
%     Last updated on Dec. 30, 2007
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

% If there are no input arguments, then look for a .mat file in the local
% director with a predetermined file name.
% This hook is for future development.
if (nargin == 0)
    load('SimSetup');  % Contains the code_param structure
    load('SimState');  % Contains sim_param and sim_state
    sim_param = save_param;
    sim_state = save_state;    
    code_param.filename = 'SimState.mat';     
elseif (nargin == 3)
    sim_param = varargin{1};
    sim_state = varargin{2};
    code_param = varargin{3};
else
    error( 'SingleSimulate must have either 0 or 3 inputs' );
end 

fprintf( '\n' );
fprintf( sim_param.comment );
fprintf( '\n' );

% randomly seed the random number generators
rand('state',sum(100*clock));
randn('state',sum(100*clock));

% close open files (4/22/06)
fclose all;

% determine the simulation type
if ( strcmpi( sim_param.sim_type, 'capacity' ) )
    % capacity simulation
    sim_state = SimulateCapacity( sim_param, sim_state, code_param );        
elseif ( ( strcmpi( sim_param.sim_type, 'uncoded' ) )|( strcmpi( sim_param.sim_type, 'coded' ) )| (strcmpi( sim_param.sim_type, 'bloutage') ) )
    % uncoded or coded modulation
    if (sim_param.mod_order>0)
        sim_state = SimulateMod( sim_param, sim_state, code_param );
    else % added 12/30/07
        sim_state = SimulateUGI( sim_param, sim_state, code_param );
    end        
elseif ( strcmpi( sim_param.sim_type, 'outage' ) )
    % simulates outage probability in block fading
    sim_state = SimulateOutage( sim_param, sim_state, code_param );
else
    error( 'Simulation type is not supported' );
end
