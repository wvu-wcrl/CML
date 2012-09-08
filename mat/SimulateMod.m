function sim_state = SimulateMod( sim_param, sim_state, code_param )
% SimulateMod runs a single coded/uncoded modulation simulation scenario
%
% The calling syntax is:
%     sim_state = SimulateMod( sim_param, sim_state )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining derived information.
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2005-2007, Matthew C. Valenti
%
%     Last updated on Dec. 23, 2007
%



%%% initialize global simulation parameters
[code_param] = create_bicm_interleaver(sim_param, code_param);
[EsNo EbNo] = compute_snr_vectors(sim_param, code_param);
[tempfile] = name_tempfile();
[ verbosity ] = determine_verbosity( sim_param );

t0 = clock;  % for profiling runtime
tic;              % for timing simulation execution


%%% enter primary simulation loop
elapsed_time = toc;
snrpoint = 1;
continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, elapsed_time );
while ( continue_simulation )
    print_current_snr( sim_param, snrpoint );
    print_current_time( clock, sim_param, verbosity );
    
    
    %%% enter individual snr simulation loop
    execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, elapsed_time );
    while ( execute_this_snr )
        [sim_state] =               increment_trials_counter( sim_state, code_param, snrpoint );
        
        %%% source operations
        [data] =                       gen_random_data( code_param );
        [s] =                            CmlEncode( data, sim_param, code_param );
        % break CmlEncode down or return codeword
        
        
        
        %%% channel operations
        [symbol_likelihood] = CmlChannel( s, sim_param, code_param, EsNo(snrpoint) );
        
        
        %%% receiver operations
        
        switch sim_param.sim_type,
            case 'exit'
                
                        
            otherwise
                if (code_param.outage == 0) % error rate simulation
                    [detected_data, errors] = CmlDecode( symbol_likelihood, data, sim_param, code_param );
                    echo_x_on_error( errors, code_param, verbosity );
                    [ sim_state ] =                 update_bit_frame_error_rate( sim_state, code_param, snrpoint, errors );
                    
                    if ~code_param.coded
                        [ sim_state ] =             update_symbol_error_rate( sim_param, sim_state, code_param, snrpoint, data, detected_data );
                    end
                    
                else % capacity simulation
                    if ( sim_param.bicm )             % bicm cap
                        cap = compute_bicm_capacity( sim_param, code_param, symbol_likelihood, bit_likelihood );
                    else                                        % cm cap
                        cap = log2(sim_param.mod_order)*Capacity( symbol_likelihood, data );
                    end
                    [sim_state] = update_fer_statistics( cap, code_param, sim_state, snrpoint, verbosity );
                end
                
                
        end       
        
        
        
        %%% save and determine whether to continue simulating this snr
        save_simulation_state( sim_state, sim_param, code_param, snrpoint, verbosity, tempfile );
        
        elapsed_time = toc;
        execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, elapsed_time );
    end
    
    
    breaksim = break_simulation(code_param, sim_param, sim_state, snrpoint, verbosity ); % halt if BER or FER is low enough
    if breaksim == 1,  break;  end
    
       
    %%% determine whether to continue the simulation
    snrpoint = snrpoint + 1;  % next snr point
    elapsed_time = toc;
    continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, elapsed_time );
end


%%% print final messages and end the simulation
CmlPrint( 'Simulation Complete\n', [], 'verbose');
current_time = fix(clock);
CmlPrint( 'Clock %2d:%2d:%2d\n', [current_time(4) current_time(5) current_time(6)], verbosity);
end






function code_param = create_bicm_interleaver(sim_param, code_param)
if (code_param.coded)
    if ( sim_param.bicm > 0 )
        code_param.bicm_interleaver = randperm(code_param.code_bits_per_frame)-1;
    end
end
end


function [EsNo EbNo] = compute_snr_vectors(sim_param, code_param)
if ( sim_param.SNR_type(2) == 'b' )  % in terms of energy per bit
    EbNo = 10.^(sim_param.SNR/10);
    EsNo = EbNo*code_param.rate;
else % Es/No
    EsNo = 10.^(sim_param.SNR/10); % in terms of energy per symbol
    EbNo = 0;
end
end


function tempfile =name_tempfile()
tempfile = 'tempsave.mat';
end


function print_current_snr( sim_param, snrpoint )
snr_msg = [ '\n' sim_param.SNR_type ' = %f dB\n' ];
snr_data = sim_param.SNR(snrpoint);
CmlPrint( snr_msg, snr_data, 'verbose'  );
end


function verbosity = determine_verbosity( sim_param )
if strcmp(sim_param.SimLocation, 'local'), verbosity = 'verbose'; else verbosity = 'silent'; end
end


function print_current_time(clock, sim_param, verbosity)
current_time = fix(clock);
CmlPrint(  'Clock %2d:%2d:%2d\n',  [current_time(4) current_time(5) current_time(6)], verbosity );
end


function sim_state = increment_trials_counter( sim_state, code_param, snrpoint)
sim_state.trials(1:code_param.max_iterations, snrpoint) = sim_state.trials(1:code_param.max_iterations, snrpoint) + 1;
end


function data = gen_random_data( code_param )
data = round( rand( 1, code_param.data_bits_per_frame ) );
end


function echo_x_on_error( errors, code_param, verbosity )
% Echo an x if there was an error
if ( errors( code_param.max_iterations ) );
    
    CmlPrint('x',[], verbosity);
    %fprintf( 'x' );
end

end


function sim_state = update_bit_frame_error_rate( sim_state, code_param, snrpoint, errors);
% update frame error and bit error counters
sim_state.bit_errors( 1:code_param.max_iterations, snrpoint ) = sim_state.bit_errors( 1:code_param.max_iterations, snrpoint ) + errors;
sim_state.frame_errors( 1:code_param.max_iterations, snrpoint ) = sim_state.frame_errors( 1:code_param.max_iterations, snrpoint ) + (errors>0);

sim_state.BER(1:code_param.max_iterations, snrpoint) = sim_state.bit_errors(1:code_param.max_iterations, snrpoint)./sim_state.trials(1:code_param.max_iterations, snrpoint)/code_param.data_bits_per_frame;
sim_state.FER(1:code_param.max_iterations, snrpoint) = sim_state.frame_errors(1:code_param.max_iterations, snrpoint)./sim_state.trials(1:code_param.max_iterations, snrpoint);
end


function sim_state = update_symbol_error_rate( sim_param, sim_state, code_param, snrpoint, data, detected_data)
if ( sim_param.mod_order > 2 )
    error_positions = xor( detected_data(1:code_param.data_bits_per_frame), data );
    
    % update symbol, frame, and bit error counters
    sim_state.symbol_errors(snrpoint) = sim_state.symbol_errors( snrpoint) + sum( max( reshape( error_positions, code_param.bits_per_symbol, code_param.symbols_per_frame ),[],1 ) );
    sim_state.SER(snrpoint) = sim_state.symbol_errors(snrpoint)/sim_state.trials(snrpoint)/code_param.symbols_per_frame;
else
    sim_state.symbol_errors(snrpoint) = sim_state.bit_errors(snrpoint);
    sim_state.SER(snrpoint) = sim_state.BER(snrpoint);
end
end


function compute_bicm_capacity( sim_param, code_param, symbol_likelihood, bit_likelihood )
% BICM capacity
if (code_param.bpsk)
    bit_likelihood = symbol_likelihood; % later this should be moved to Somap function
else
    bit_likelihood = Somap( symbol_likelihood, sim_param.demod_type );
end
% BICM capacity (added log2(mod_order) on 12/23/07)
cap = log2(sim_param.mod_order)*Capacity( bit_likelihood, data );
end


function sim_state = update_fer_statistics( cap, code_param, sim_state, snrpoint, verbosity )
if ( cap < code_param.rate )
    sim_state.frame_errors( 1, snrpoint ) = sim_state.frame_errors( 1, snrpoint ) + 1;
    sim_state.FER(1, snrpoint) = sim_state.frame_errors(1, snrpoint)./sim_state.trials(1, snrpoint);
    % Echo an x if there was an error
        
    CmlPrint('x',[], verbosity);    
end
end


function save_simulation_state(sim_state, sim_param, code_param, snrpoint, verbosity, tempfile )
% determine if it is time to save (either (1) last error, (2) last frame,
% or (3) once per save_rate)
condition1 = ( sim_state.frame_errors(code_param.max_iterations, snrpoint) == sim_param.max_frame_errors(snrpoint) );
condition2 = ( sim_state.trials( code_param.max_iterations, snrpoint ) == sim_param.max_trials( snrpoint ) );
condition3 = ~mod( sim_state.trials(code_param.max_iterations, snrpoint),sim_param.save_rate );
if ( condition1|condition2|condition3 )
    
    CmlPrint('.',[], verbosity);
    
    save_struct.tempfile = tempfile;
    save_struct.save_state = sim_state;
    save_struct.save_param = sim_param;
    save_struct.save_flag = code_param.save_flag;
    save_struct.code_param.filename = code_param.filename;
    
    CmlSave(save_struct, sim_param.SimLocation);
    
    code_param = create_bicm_interleaver(sim_param, code_param); % redraw the BICM interleaver (so that it is uniform)
    
end
end


function breaksim = break_simulation(code_param, sim_param, sim_state, snrpoint, verbosity )
if ( ~code_param.outage & ( sim_state.BER(code_param.max_iterations, snrpoint) < sim_param.minBER  ) )
    % adjust max_iterations to be the last iteration that has not yet dropped below the BER threshold
    % Logic has changed on 7-28-06
    iteration_index = max( find( sim_state.BER(sim_param.plot_iterations,snrpoint) >= sim_param.minBER ) );
    
    if isempty( iteration_index )
        breaksim = 1;
    else
        code_param.max_iterations = sim_param.plot_iterations( iteration_index );
        
        CmlPrint( '\nNumber of iterations = %d\n', code_param.max_iterations, verbosity);
        breaksim= 0;
    end
    
elseif ( sim_state.FER(code_param.max_iterations, snrpoint) < sim_param.minFER  )
    breaksim = 1;
else
    breaksim = 0;
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
c1 =  sim_state.trials( code_param.max_iterations, snrpoint ) < sim_param.max_trials( snrpoint ) ;
c2 =  sim_state.frame_errors(code_param.max_iterations, snrpoint) < sim_param.max_frame_errors(snrpoint);
if( sim_param.MaxRunTime == 0 || strcmp( sim_param.SimLocation, 'local') ),
    c3 = 1;
else
    c3 = elapsed_time < sim_param.MaxRunTime;
end
execute_this_snr = c1&c2&c3;
end

%     Function SimulateMod is part of the Iterative Solutions Coded Modulation
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
