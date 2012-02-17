function sim_state = SimulateCapacity( sim_param, sim_state, code_param )
% SimulateCapacity runs a single of capacity simulation.
%
% The calling syntax is:
%     sim_state = SimulateCapacity( sim_param, sim_state, code_param )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining derived information.
%
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2005-2006, Matthew C. Valenti
%
%     Last updated on June 6, 2006
%
%     Function SimulateCapacity is part of the Iterative Solutions Coded Modulation
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

% make sure that SNR is in terms of Es/No
if ( sim_param.SNR_type(2) == 's' ) % Eb/No
    EsNo = 10.^(sim_param.SNR/10); 
else % Es/No
    error( 'The SNR for capacity simulations must be in terms of Es/No in dB' );
end              

% temporary filename
tempfile = 'tempsave.mat';

% simulate
for snrpoint = 1:length(EsNo)
    fprintf( strcat( '\n', sim_param.SNR_type, ' = %f dB\n'), sim_param.SNR(snrpoint) );
    
    %fprintf( 'trials = %d, max_trials = %d\n', sim_state.trials( snrpoint ),sim_param.max_trials( snrpoint ) )

    while ( sim_state.trials( snrpoint ) < sim_param.max_trials( snrpoint )  )        
        % increment the trials counter
        sim_state.trials(snrpoint) = sim_state.trials(snrpoint) + 1;
        
        % generate random data
        data = round( rand( 1, code_param.data_bits_per_frame ) );
        
        % code  and modulate
        s = CmlEncode( data, sim_param, code_param );
        
        % Put through the channel
        symbol_likelihood = CmlChannel( s, sim_param, code_param, EsNo(snrpoint) );          
                
        % determine capacity  
        if ( sim_param.bicm ) 
            % BICM capacity
            if (code_param.bpsk)
                bit_likelihood = symbol_likelihood; % later this should be moved to Somap function
            else
                bit_likelihood = Somap( symbol_likelihood, sim_param.demod_type );
            end
            cap = Capacity( bit_likelihood, data );  
        else    
            % CM capacity
            cap = Capacity( symbol_likelihood, data );  
        end
        
        sim_state.capacity_sum( snrpoint ) = sim_state.capacity_sum( snrpoint ) + cap;
        sim_state.capacity_avg( snrpoint ) = sim_state.capacity_sum( snrpoint )/sim_state.trials(snrpoint);
        
        % determine if it is time to save (either (1) last frame, or (2) once per save_rate)
        condition1 = ( sim_state.trials(snrpoint ) == sim_param.max_trials( snrpoint ) );
        condition2 = ~mod( sim_state.trials(snrpoint), sim_param.save_rate );
        time_to_save = condition1|condition2;
        
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
        end          
    end     
end
