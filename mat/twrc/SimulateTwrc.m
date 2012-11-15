function sim_state = SimulateTwrc( sim_param, sim_state, code_param )
% SimulateTWRC runs a single coded/uncoded modulation simulation scenario
%  in the two-way relay channel environment
%
% The calling syntax is:
%     sim_state = SimulateTWRC( sim_param, sim_state )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining derived information.
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2005-2012, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on Oct. 17, 2012
%



%%% initialize global simulation parameters
[code_param] = create_bicm_interleaver(sim_param, code_param);
[EsNo EbNo] = compute_snr_vectors(sim_param, code_param);
[tempfile] = name_tempfile();
[ verbosity ] = determine_verbosity( sim_param );

t0 = clock;  % for profiling runtime
tic;              % for timing simulation execution


%%% enter primary simulation loop
session_time = toc;
snrpoint = 1;
continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, session_time );
while ( continue_simulation )
    print_current_snr( sim_param, snrpoint );
    %print_current_time( clock, sim_param, verbosity );
    
    
    %%% enter individual snr simulation loop
    execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, session_time );
    while ( execute_this_snr )
        [sim_state] =               increment_trials_counter( sim_state, code_param, snrpoint );
        
        
        %%% source 
        [data_1] =                       gen_random_data( code_param );
        [s_1]=                           CmlEncode( data_1, sim_param, code_param );
        
        [data_2] =                       gen_random_data( code_param );
        [s_2]=                           CmlEncode( data_2, sim_param, code_param );
        
        [ nc_data ] = compute_nc_data( data_1, data_2 );
        
        
        %%% relay channel
        [ r a_1 a_2 ] = CmlTwrcRelayChannel( s_1, s_2, code_param, EsNo(snrpoint) );
        
        
        %%% relay receiver
        [ sym_lh ] = CmlTwrcRelayComputeSymbolLh( r, a_1, a_2, EsNo(snrpoint), sim_param );
        
  
        
        switch sim_param.sim_type,
            
            case 'coded',
                
                bicm_iterations = init_bicm( sim_param, code_param );
                
                ap_llr = CmlInitSomap(sim_param, code_param);
                
                errors = 0;
                
                for iter = 1:bicm_iterations,
                    
                    [ ex_llr ] = CmlTwrcRelaySomap( sym_lh, ap_llr, sim_param );
                    
                    
                    ex_llr = Deinterleave_relay( ex_llr, sim_param, code_param );
                    
                    
                    [ detected_data, errors, ap_llr] = ...
                        CmlTwrcRelayDecode( ex_llr, nc_data, sim_param, code_param, errors, iter);
                    
                    
                    ap_llr = Interleave_relay( ap_llr, sim_param, code_param);
                    
                    
                    if errors(iter) == 0, break; end
                    
                end
                
                [ sim_state ] =     update_bit_frame_error_rate( sim_state, code_param, snrpoint, errors );
                
            case 'uncoded'
                
                ap_llr = CmlInitSomap(sim_param, code_param);
                
                [ ex_llr ] = CmlTwrcRelaySomap( sym_lh, ap_llr, sim_param );
                
                detected_data = ( ex_llr > 0 );
                errors = sum( xor ( detected_data, nc_data) );
                
                [ sim_state ] =  update_bit_frame_error_rate( sim_state, code_param, snrpoint, errors );
                [ sim_state ] =  update_symbol_error_rate( sim_param, sim_state, code_param, snrpoint, nc_data, detected_data );
        end
        
        
        
        
        
        %     switch sim_param.sim_type,
        %         case 'exit'
        %         otherwise
        %             if (code_param.outage == 0) % error rate simulation
        %                 [detected_data, errors] = CmlTWRCDecode( symbol_likelihood, data, sim_param, code_param );
        %                 echo_x_on_error( errors, code_param, verbosity );
        %                 [ sim_state ] =                 update_bit_frame_error_rate( sim_state, code_param, snrpoint, errors );
        %
        %                 if ~code_param.coded
        %                     [ sim_state ] =             update_symbol_error_rate( sim_param, sim_state, code_param, snrpoint, data, detected_data );
        %                 end
        %
        %                 sim_state = record_trial_time( sim_param, sim_state, code_param, snrpoint);
        %
        %             else % capacity simulation
        %                 if ( sim_param.bicm )             % bicm cap
        %                     cap = compute_bicm_capacity( sim_param, code_param, symbol_likelihood, bit_likelihood );
        %                 else                                        % cm cap
        %                     cap = log2(sim_param.mod_order)*Capacity( symbol_likelihood, data );
        %                 end
        %                 [sim_state] = update_fer_statistics( cap, code_param, sim_state, snrpoint, verbosity );
        %             end
        %
        %
        %     end
        
        
        
        %%% save and determine whether to continue simulating this snr
        
        
        session_time_dt = toc - session_time;
        session_time = toc;
        sim_state.timing_data.elapsed_time = update_global_sim_time( sim_state, session_time_dt );
        
        save_simulation_state( sim_state, sim_param, code_param, snrpoint, verbosity, tempfile );
        
        execute_this_snr = evaluate_snr_point_stopping_conditions( sim_param, sim_state, code_param, snrpoint, session_time );
    end
    
    
    breaksim = break_simulation(code_param, sim_param, sim_state, snrpoint, verbosity ); % halt if BER or FER is low enough
    if breaksim == 1,  break;  end
    
    CmlPrint( 'BER: %f', [sim_state.BER(code_param.max_iterations,snrpoint)], 'verbose');
    %%% determine whether to continue the simulation
    snrpoint = snrpoint + 1;  % next snr point
    session_time = toc;
    continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, session_time );
end


%%% print final messages and end the simulation
CmlPrint( 'Simulation Complete\n', [], 'verbose');
current_time = fix(clock);
CmlPrint( 'Clock %2d:%2d:%2d\n', [current_time(4) current_time(5) current_time(6)], verbosity);
end



function elapsed_time = update_global_sim_time( sim_state, session_time_dt)
elapsed_time = sim_state.timing_data.elapsed_time + session_time_dt;  % update global simulation timer
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
    E_1 = 1;
    E_2 = E_1*sim_param.twrc_param.energy_ratio;
    N_0 = (E_1 + E_2)/2 ./ 10.^(sim_param.SNR/10);
    EsNo = code_param.rate*1./N_0;
    EbNo = EsNo;  
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
    
    CmlPrint('.\n',[], verbosity);
    %CmlPrint('Elapsed simulation time: %.2f s\n', sim_state.timing_data.elapsed_time, 'verbose');
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



function continue_simulation = evaluate_simulation_stopping_conditions( sim_param, EsNo, snrpoint, session_time )
c1 = snrpoint <= length(EsNo);

if( sim_param.MaxRunTime == 0 || strcmp( sim_param.SimLocation, 'local') ),
    c2 = 1;
else
    c2 = session_time < sim_param.MaxRunTime;
end
if c2 == 0,
    if strcmp(sim_param.SimLocation, 'local'), verbosity = 'verbose'; else verbosity = 'silent'; end
    CmlPrint('\nSimulation time expired.\n', [], verbosity);
end
continue_simulation = c1&c2;
end


function execute_this_snr = evaluate_snr_point_stopping_conditions(sim_param, sim_state, code_param, snrpoint, session_time)
c1 =  sim_state.trials( code_param.max_iterations, snrpoint ) < sim_param.max_trials( snrpoint ) ;
c2 =  sim_state.frame_errors(code_param.max_iterations, snrpoint) < sim_param.max_frame_errors(snrpoint);
if( sim_param.MaxRunTime == 0 || strcmp( sim_param.SimLocation, 'local') ),
    c3 = 1;
else
    c3 = session_time < sim_param.MaxRunTime;
end
execute_this_snr = c1&c2&c3;
end


function sim_state = record_trial_time( sim_param, sim_state, code_param, snrpoint )

if sim_param.timing_sample_rate ~= 0,
    
    t = sim_state.timing_data.elapsed_time;    % total elapsed simulation time
    
    tsr = sim_param.timing_sample_rate;   % trials sampling rate
    
    bin = floor( t / tsr ) + 1;   % integer index of current time bin
    
    bin_st = (bin-1)*tsr;         % start time of current bin
    
    total_trials = sum( sim_state.trials( code_param.max_iterations, 1:snrpoint) );     % current trial total
    
    sim_state.timing_data.trial_samples( bin ) = total_trials;                      % sample trial total
    
    sim_state.timing_data.time_samples = [ 0 : tsr : bin_st ];                        % adjust time axis
    
end

end



function sym_lh = CmlTwrcRelayComputeSymbolLh( r, a_1, a_2, EsNo, sim_param )

switch sim_param.twrc_param.protocol
    case 'dnc'
        
        a_1_v = a_1(1,:);
        a_2_v = a_2(1,:);
        
        sqE1 = 1;   % temporary
        sqE2 = 1;
        sym_lh = Demod_PNC_FSK( r, EsNo, sim_param.csi_flag, a_1_v, a_2_v,...
            sqE1, sqE2, sim_param.twrc_param.csi1switch);
        
    case 'lnc'
        
        
end

end


function nc_data = compute_nc_data( data_1, data_2 )
nc_data = xor( data_1, data_2 );
end



function bicm_iterations = init_bicm( sim_param, code_param )

if ( sim_param.bicm == 2 ) % bicm-id
    bicm_iterations = code_param.max_iterations;
else
    bicm_iterations = 1;
end

end


function ex_llr = Deinterleave_relay( ex_llr, sim_param, code_param )

if sim_param.bicm
    ex_llr = Deinterleave( ex_llr, code_param.bicm_interleaver);
end

end

function ap_llr = Interleave_relay( ap_llr, sim_param, code_param )

if sim_param.bicm
    ap_llr = Interleave( ap_llr, code_param.bicm_interleaver );
end

end


%     Function SimulateTWRC is part of the Iterative Solutions Coded Modulation
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
