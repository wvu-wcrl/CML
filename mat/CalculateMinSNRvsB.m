function  [sim_param, sim_state] = CalculateMinSNRvsB( sim_param, sim_state )
% CalculateMinSNRvsB determines the minimum SNR as a function of BW
% constraint B.
%
% The calling syntax is:
%     [sim_param, sim_state] = CalculateMinSNRvsB(( sim_param, sim_state )
%
%     Required inputs/outputs:
%     sim_param = A structure containing simulation parameters.
%
%     Required output
%     sim_state = A structure containing the simulation state.
%
%     Required input
%     code_param = A structure contining derived information.
%
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2006-2007, Matthew C. Valenti
%
%     Last updated on Oct. 12, 2007
%
%     Function CalculateMinSNR is part of the Iterative Solutions Coded Modulation
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

% read in the simulation results
[read_param, read_state] = ReadScenario( sim_param.input_filename, sim_param.scenarios, [] );
number_records = length( sim_param.scenarios );

% go through each record
for record=1:number_records
    
    sim_param.bwconstraint(record) = read_param(record).bwconstraint;
    
    % determine the minimum Eb/No
    [value, index] = min( read_state(record).min_EbNodB );
    if ( length(index) > 0 )
        sim_state.min_EbNodB(record) = read_state(record).min_EbNodB(index(1));
        sim_param.h(record) = read_param(record).h(index(1));
        sim_state.best_rate(record) = read_state(record).best_rate(index(1));
    else
        sim_state.min_EbNodB(record) = NaN;
        sim_param.h(record) = NaN;
        sim_state.best_rate(record) = NaN;
    end
end

% save results
save_state = sim_state;
save_param = sim_param;
save( code_param.filename, code_param.save_flag, 'save_state', 'save_param');


