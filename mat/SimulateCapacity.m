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
				   

EsNo = compute_capacity_snr_vector( sim_param );
[ verbosity ] = determine_verbosity( sim_param );

[tempfile] = name_tempfile();

tic;

snrpoint = 1;
elapsed_time = toc;
continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, elapsed_time );
while( continue_simulation )
    print_current_snr( sim_param, snrpoint );
   
 
execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, elapsed_time );
while ( execute_this_snr )

        [sim_state] = increment_trials_counter_capacity( sim_state, snrpoint );
        
        %%% source operations
        [data] = gen_random_data( code_param );
        [s] = CmlEncode( data, sim_param, code_param );
        
        %%% channel operations
        [symbol_likelihood] = CmlChannel( s, sim_param, code_param, EsNo(snrpoint) );
                
        %%% receiver operations
        switch sim_param.sim_type,
            case 'capacity',
                cap = compute_frame_capacity( sim_param, code_param, symbol_likelihood, data );
                [sim_state] = update_capacity_statistics( sim_state, cap, snrpoint );
                
            case 'exit',
                [exit_state_diff] = SimExit( sim_param.exit_param, symbol_likelihood, data );                
                [sim_state.exit_state] = UpdateExitMetrics( sim_param.exit_param, sim_state.exit_state, exit_state_diff, snrpoint );
        end
                
        save_simulation_state_capacity( sim_state, sim_param, code_param, snrpoint, verbosity, tempfile );

elapsed_time = toc;
execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, elapsed_time );

    end
        
    % compute cnd at beginning
% compute final exit stats
[sim_state] = FinalExitMetrics( sim_param, sim_state, sim_state.trials(snrpoint), snrpoint);
save_simulation_state_capacity( sim_state, sim_param, code_param, snrpoint, verbosity, tempfile );    


snrpoint = snrpoint + 1;
elapsed_time = toc;
continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, elapsed_time );
end
end







function continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, elapsed_time )
  c1 = snrpoint <= length(EsNo);

if( sim_param.MaxRunTime == 0 || strcmp( sim_param.SimLocation, 'local') ),
  c2 = 1;
 else
   c2 = elapsed_time < sim_param.MaxRunTime;
end
if c2 == 0,
  if strcmp(sim_param.SimLocation, 'local'), verbosity = 'verbose'; else verbosity = 'silent'; end
  CmlPrint('\nSimulation time expired.\n', [], verbosity);
end
continue_simulation = c1&c2;
end



function execute_this_snr = evaluate_snr_point_stopping_conditions(sim_param, sim_state, code_param, snrpoint, elapsed_time)

c1 = sim_state.trials( snrpoint ) < sim_param.max_trials( snrpoint );

if( sim_param.MaxRunTime == 0 || strcmp( sim_param.SimLocation, 'local') ),
  c2 = 1;
 else
   c2 = elapsed_time < sim_param.MaxRunTime;
end
execute_this_snr = c1&c2;
end










function EsNo = compute_capacity_snr_vector( sim_param )

switch sim_param.sim_type,
    case 'capacity',
        if ( sim_param.SNR_type(2) == 's' )
            EsNo = 10.^(sim_param.SNR/10);
        else
            error( 'The SNR for capacity simulations must be in terms of Es/No in dB' );
        end
        
    case 'exit',
        
        if ( sim_param.SNR_type(2) == 'b' )
            EbNo = 10.^(sim_param.SNR/10);
            symbol_energy_fraction = sim_param.exit_param.rate*log2(sim_param.mod_order);
            EsNo = symbol_energy_fraction * EbNo;
            
        else
            error('The SNR for EXIT simulations must be in terms of Eb/No in dB');
        end
        
end

end


function verbosity = determine_verbosity( sim_param )
if strcmp(sim_param.SimLocation, 'local'), verbosity = 'verbose'; else verbosity = 'silent'; end
end


function tempfile =name_tempfile()
tempfile = 'tempsave.mat';
end


function print_current_snr( sim_param, snrpoint )
snr_msg = [ '\n' sim_param.SNR_type ' = %f dB\n' ];
snr_data = sim_param.SNR(snrpoint);
CmlPrint( snr_msg, snr_data, 'verbose'  );
end


function sim_state = increment_trials_counter_capacity( sim_state, snrpoint)
sim_state.trials( snrpoint) = sim_state.trials( snrpoint) + 1;
end


function data = gen_random_data( code_param )
data = round( rand( 1, code_param.data_bits_per_frame ) );
end




function cap = compute_frame_capacity( sim_param, code_param, symbol_likelihood, data )

switch sim_param.bicm
    
    case 1,
        
        if (code_param.bpsk)
            bit_likelihood = symbol_likelihood;
        else
            bit_likelihood = Somap( symbol_likelihood, sim_param.demod_type );
        end
        cap = Capacity( bit_likelihood, data );
        
    otherwise,
        cap = Capacity( symbol_likelihood, data );
        
end
end



function [sim_state] = update_capacity_statistics( sim_state, cap, snrpoint )
sim_state.capacity_sum( snrpoint ) = sim_state.capacity_sum( snrpoint ) + cap;
sim_state.capacity_avg( snrpoint ) = sim_state.capacity_sum( snrpoint )/sim_state.trials(snrpoint);
end



function save_simulation_state_capacity( sim_state, sim_param, code_param, snrpoint, verbosity, tempfile )
% determine if it is time to save (either (1) last frame, or (2) once per save_rate)
condition1 = ( sim_state.trials(snrpoint ) == sim_param.max_trials( snrpoint ) );
condition2 = ~mod( sim_state.trials(snrpoint), sim_param.save_rate );

time_to_save = condition1|condition2;

if ( time_to_save )
    CmlPrint('.', [], verbosity );
    
    save_struct.tempfile = tempfile;
    save_struct.save_state = sim_state;
    save_struct.save_param = sim_param;
    save_struct.save_flag = code_param.save_flag;
    save_struct.code_param.filename = code_param.filename;
    
    CmlSave( save_struct, sim_param.SimLocation );
end


end
