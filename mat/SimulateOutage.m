function sim_state = SimulateOutage( sim_param, sim_state, code_param )
% SimulateOutage runs a single information outage probability simulation.
%
% The calling syntax is:
%     sim_state = SimulateOutage( sim_param, sim_state, code_param )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining derived information.
%
%     Copyright (C) 2005-2007, Matthew C. Valenti and Tarik Ghanim 
%
%     Last updated on December 7, 2007
%
%     Function SimulateOutage is part of the Iterative Solutions Coded Modulation
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

% load AWGN simulation
if(sim_param.mod_order > 0)
    input_file = load(code_param.input_filename); % changed 12/7/07
    capacity_AWGN = input_file.save_state.capacity_avg * log2(sim_param.mod_order);
    EsNodB_AWGN = input_file.save_param.SNR; % assume SNR is Es/No in dB
    EsNo_AWGN = 10.^(EsNodB_AWGN/10);
    
    % Determine the slope of the capacity curve
    last_index = length( capacity_AWGN );
    slope = ( capacity_AWGN(2:last_index) - capacity_AWGN(1:last_index-1) )./( EsNo_AWGN(2:last_index) - EsNo_AWGN(1:last_index-1) );    
end

% Initialize variables
rate = sim_param.rate;
if ( sim_param.SNR_type(2) == 'b' ) % Eb/No
    EbNo = 10.^(sim_param.SNR/10);
    EsNo = EbNo.*rate; 
else % Es/No
    EsNo = 10.^(sim_param.SNR/10);
end          

L = sim_param.blocks_per_frame;
LL = L;
if ( sim_param.mod_order == -1)
    % mod_order == -1 corresponds to 1-D Gaussian input
    LL = L*2; % account for real symbols only
end

% determine combining type used
type = 0; % 'diversity'
if(strcmpi( sim_param.combining_type, 'code' ))
    type = 1;
end

% temporary filename
tempfile = 'tempsave.mat';

% simulate
for snrpoint = 1:size(EsNo,2)
    fprintf( strcat( '\n', sim_param.SNR_type, ' = %f dB\n'), sim_param.SNR(snrpoint) );
    save_counter = 0;

    while (( sim_state.trials( snrpoint ) < sim_param.max_trials( snrpoint ) )...
            &( sim_state.frame_errors(snrpoint) < sim_param.max_frame_errors(snrpoint)))

        % increment the trials counter
        sim_state.trials(snrpoint) = sim_state.trials(snrpoint) + sim_param.trial_size;
        save_counter = save_counter + sim_param.trial_size;

        % Generate i.i.d. exponential SNRs (changed 12/7/07)
        % gamma = EsNo(snrpoint)*exprnd(1,sim_param.trial_size,L);
        gamma = -EsNo(snrpoint)*log(rand(sim_param.trial_size,L));
        
        % If this is diversity combining, add the SNRs.
        if ( type == 0 )
            gamma = sum( gamma, 2 );
        end   
        
        if(sim_param.mod_order > 0)        % Modulation Constrained Input
            inst_cap = 1/LL*CapacityTableLookup( EsNo_AWGN, capacity_AWGN, slope, gamma );
        else   % Unconstrained Gaussian Input 
            inst_cap = 1/LL*sum( log2( 1 + gamma ), 2 );
        end      
        outages = sum(inst_cap<rate);
        
        sim_state.frame_errors(snrpoint) = sim_state.frame_errors(snrpoint) + outages;
        sim_state.FER(snrpoint) = sim_state.frame_errors(snrpoint)./sim_state.trials(snrpoint);
        
        if outages
            fprintf('x');
        end

        % determine if it is time to save (either (1) last error, (2) last
        % frame, or (3) once per save_rate
        condition1 = ( sim_state.trials(snrpoint ) >= sim_param.max_trials( snrpoint ) );
        condition2 = ( sim_state.frame_errors(1, snrpoint) >= sim_param.max_frame_errors(snrpoint) );
        % condition3 = ~mod( sim_state.trials(snrpoint), sim_param.save_rate );
        condition3 = (save_counter > sim_param.save_rate );
        time_to_save = condition1|condition2|condition3;

        if ( time_to_save )
            fprintf('.');
            save_state = sim_state;
            save_param = sim_param;
            
            % Aded on April 22, 2006 in case system crashes during save
            save( tempfile, code_param.save_flag, 'save_state', 'save_param');
            
            % Store into local directory (if running locally)
            if ( sim_param.compiled_mode )                
                copyfile( tempfile, sim_param.filename, 'f' );
            end
                
            movefile( tempfile, code_param.filename, 'f');  
            
            save_counter = 0;
        end
    end % Averaging loop over transmitted codewords(frames)

    % halt if FER is low enough
    if ( sim_state.FER(1, snrpoint) < sim_param.minFER  )
        break;
    end

end % SNR loop