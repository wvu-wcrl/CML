function [sim_param, sim_state] = CalculateThroughput( sim_param, sim_state, code_param )
% CalculateThroughput determines the throughput of hybrid-ARQ
%
% The calling syntax is:
%     sim_param, sim_state] = CalculateThroughput( sim_param, sim_state )
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
%     Copyright (C) 2005-2007, Matthew C. Valenti
%
%     Last updated on Oct. 12, 2007
%
%     Function CalculateThroughput is part of the Iterative Solutions Coded Modulation
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
[read_param, read_state] = ReadScenario( sim_param.input_filename, sim_param.scenarios );
number_records = length( sim_param.scenarios );

% initialize
sim_param.SNR_type = 'Es/No in dB';
sim_param.SNR = read_param(1).SNR; 

for record=1:number_records
    % make SNR is stored as Es/No
    if ( read_param(record).SNR_type(2) ~= 's' )
        error( 'SNR type must be Es/No in dB' );
    end
    
    % make sure all the simulations have the same SNR values
    if sum( read_param(record).SNR ~= sim_param.SNR )
        error( 'All records must have the same SNR vector' );
    end
   
end

% create a cmf matrix
fer = zeros( number_records, length( sim_param.SNR ) );
pmf = fer;
blocks = fer;
sim_state.throughput = zeros(1,length(sim_param.SNR));

for (m=1:number_records)
    % assume SNR vectors are the same
    [FER_rows, FER_cols] = size( read_state(m).FER );
    fer(m,:) = read_state(m).FER( FER_rows, : );
    pmf(m,:) = (1-fer(m,:)).*prod( fer(1:m-1,:), 1 );
    blocks(m,:) = m*pmf(m,:);
end        

% this is for numerical stability (avoids NaN due to divide by zero)
temp_indices = find( sum(blocks) );

sim_state.throughput(temp_indices) = (1-fer(number_records, temp_indices )).^2./sum(blocks(:,temp_indices));

% save results
save_state = sim_state;
save_param = sim_param;
save( code_param.filename, code_param.save_flag, 'save_state', 'save_param');


