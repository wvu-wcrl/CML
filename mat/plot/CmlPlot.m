function [sim_param, sim_state, varargout] = CmlPlot( varargin )
% CmlPlot plots simulation results
%
% The calling syntax is:
%     [sim_param, sim_state] = CmlPlot( scenario_filename, cases )
%
%     Outputs:
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     Note: See readme.txt for a description of the structure formats.
%
%     Required inputs:
%	  scenario_filename = the name of the file containing an array of sim_param structures.
%     cases = a list of the array indices to plot.
%
%     Note: Multiple scenario files can be specified.  In this case, the argument list
%     should contain each scenario file to be used followed by the list of array indices
%     to read from that file.
%
%     Example:
%     [sim_param, sim_state] = CmlPlot( 'Scenario1', [1 2 5], 'Scenario2', [1 4 6] );
%
%     Copyright (C) 2005-2006, Matthew C. Valenti
%
%     Last updated on June 4, 2006

% add exit plotting
% accept snr point as input

% setup structures are retrieve data
% give an extra argument to force sim_param.reset = 0
[sim_param, sim_state] = ReadScenario( varargin{:}, [] );
number_cases = length( sim_param );


% determine the simulation type


% determine the simulation types
SimTypes = DetermineSimTypePerRecord(sim_param);


fig_number = 0;
FigHandle = [];

% First, plot capacity vs. Eb/No and Es/No, if there are any capacity curves requested.
if( sum( SimTypes(1,:) ) )
    [FigHandle, fig_number] = PlotCapacityCurves(sim_param( SimTypes(1,:) == 1 ), sim_state( SimTypes(1,:) == 1 ), FigHandle, fig_number);
end


% Plot exit curves, if there are any exit curves requested.
if ( sum( SimTypes(2,:) ) )
    if length(varargin) >= 3
        VarArgLength = length(varargin);
        SnrPoint = varargin{3};
        [FigHandle, fig_number] = PlotExitCurves( ...
            sim_param(SimTypes(2,:) == 1), sim_state(SimTypes(2,:) == 1), FigHandle, fig_number, SnrPoint, number_cases, VarArgLength);
    end
end


% next plot BER vs. Eb/N0 for coded or uncoded simulations, AND BER vs. Es/N0 for coded simulations.
% AND SER vs. Eb/N0 for uncoded simulations.
if ( sum( sum( SimTypes(3:4,:) ) ) )
    sim_param_uncoded = sim_param(SimTypes(3,:) == 1);
    sim_state_uncoded = sim_state(SimTypes(3,:) == 1);
    sim_param_coded = sim_param(SimTypes(4,:) == 1);
    sim_state_coded = sim_state(SimTypes(4,:) == 1);
    [FigHandle, fig_number] = PlotBerSerCodedUncoded( ...
        sim_param_uncoded, sim_state_uncoded, sim_param_coded, sim_state_coded, FigHandle, fig_number);
end


% Plot the FER of coded and outage simulations.
if ( sum( sum( SimTypes(4:5,:) ) ) )
    sim_param_coded = sim_param(SimTypes(4,:) == 1);
    sim_state_coded = sim_state(SimTypes(4,:) == 1);
    sim_param_outage = sim_param(SimTypes(5,:) == 1);
    sim_state_outage = sim_state(SimTypes(5,:) == 1);
    
    [FigHandle, fig_number] = PlotFerCodedOutage( ...
        sim_param_coded, sim_state_coded, sim_param_outage, sim_state_outage, FigHandle, fig_number);
end


% Plot throughput vs. Es/N0, if there are any throughput curves requested.
if ( sum( SimTypes(6,:) ) )
    [FigHandle, fig_number] = PlotThroughputEsN0( ...
        sim_param(SimTypes(6,:) == 1), sim_state(SimTypes(6,:) == 1), FigHandle, fig_number);
end


% ebn0 vs h:
% plot min Eb/N0 vs. h and min Eb/N0 vs. rate for nonorthogonal FSK under BW constraints B.
if ( sum( SimTypes(7,:) ) )
    [FigHandle, fig_number] = PlotMinEbN0hRateNonOrthogonalFsk( ...
        sim_param(SimTypes(7,:) == 1), sim_state(SimTypes(7,:) == 1), FigHandle, fig_number);
end


% plot min Eb/N0 vs. B, eta vs. min Eb/N0, optimal h vs. B, optimal rate vs. B for nonorthogonal FSK under BW constraint B.
if ( sum( SimTypes(8,:) ) )
    [FigHandle, fig_number] = PlotMinEbN0BNonOrthogonalFsk( ...
        sim_param(SimTypes(8,:) == 1), sim_state(SimTypes(8,:) == 1), FigHandle, fig_number);
end

varargout{1} = FigHandle;

end


%     Function CmlPlot is part of the Iterative Solutions Coded Modulation
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
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
%     US