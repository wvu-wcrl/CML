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

% create a random channel (BICM) interleaver
if (code_param.coded)
    if ( sim_param.bicm > 0 )
        code_param.bicm_interleaver = randperm(code_param.code_bits_per_frame)-1;
    end
end

% determine Es/No
if ( sim_param.SNR_type(2) == 'b' ) % Eb/No
    EbNo = 10.^(sim_param.SNR/10);
    EsNo = EbNo*code_param.rate;
else % Es/No
    EsNo = 10.^(sim_param.SNR/10);
end

% temporary filename
tempfile = 'tempsave.mat';

% FOR PROFILING RUNTIME
t0 = clock;

% simulate
for snrpoint = 1:length(EsNo)
    fprintf( strcat( '\n', sim_param.SNR_type, ' = %f dB\n'), sim_param.SNR(snrpoint) );
    current_time = fix(clock);
    fprintf(  'Clock %2d:%2d:%2d\n',  current_time(4), current_time(5), current_time(6) );

    % loop until either there are enough trials or enough errors
    while ( ( sim_state.trials( code_param.max_iterations, snrpoint ) < sim_param.max_trials( snrpoint ) )&( sim_state.frame_errors(code_param.max_iterations, snrpoint) < sim_param.max_frame_errors(snrpoint) ) )

        % increment the trials counter
        sim_state.trials(1:code_param.max_iterations, snrpoint) = sim_state.trials(1:code_param.max_iterations, snrpoint) + 1;

        % generate random data
        data = round( rand( 1, code_param.data_bits_per_frame ) );

        % code  and modulate
        s = CmlEncode( data, sim_param, code_param );

        % Put through the channel
        symbol_likelihood = CmlChannel( s, sim_param, code_param, EsNo(snrpoint) );

        if (code_param.outage == 0)
            % Decode
            [detected_data, errors] = CmlDecode( symbol_likelihood, data, sim_param, code_param );

            % Echo an x if there was an error
            if ( errors( code_param.max_iterations ) );
                fprintf( 'x' );
            end

            % update frame error and bit error counters
            sim_state.bit_errors( 1:code_param.max_iterations, snrpoint ) = sim_state.bit_errors( 1:code_param.max_iterations, snrpoint ) + errors;
            sim_state.frame_errors( 1:code_param.max_iterations, snrpoint ) = sim_state.frame_errors( 1:code_param.max_iterations, snrpoint ) + (errors>0);

            sim_state.BER(1:code_param.max_iterations, snrpoint) = sim_state.bit_errors(1:code_param.max_iterations, snrpoint)./sim_state.trials(1:code_param.max_iterations, snrpoint)/code_param.data_bits_per_frame;
            sim_state.FER(1:code_param.max_iterations, snrpoint) = sim_state.frame_errors(1:code_param.max_iterations, snrpoint)./sim_state.trials(1:code_param.max_iterations, snrpoint);

            % if uncoded, update symbol error rate, too.
            if ~code_param.coded
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
        else
            % determine capacity
            if ( sim_param.bicm )
                % BICM capacity
                if (code_param.bpsk)
                    bit_likelihood = symbol_likelihood; % later this should be moved to Somap function
                else
                    bit_likelihood = Somap( symbol_likelihood, sim_param.demod_type );
                end
                % BICM capacity (added log2(mod_order) on 12/23/07)
                cap = log2(sim_param.mod_order)*Capacity( bit_likelihood, data );
            else
                % CM capacity (added log2(mod_order) on 12/23/07)
                cap = log2(sim_param.mod_order)*Capacity( symbol_likelihood, data );
            end
            % compare to threshold and update FER counter
            if ( cap < code_param.rate )
                sim_state.frame_errors( 1, snrpoint ) = sim_state.frame_errors( 1, snrpoint ) + 1;
                sim_state.FER(1, snrpoint) = sim_state.frame_errors(1, snrpoint)./sim_state.trials(1, snrpoint);
                % Echo an x if there was an error
                fprintf( 'x' );
            end
        end

        % determine if it is time to save (either (1) last error, (2) last frame, or (3) once per save_rate)
        condition1 = ( sim_state.frame_errors(code_param.max_iterations, snrpoint) == sim_param.max_frame_errors(snrpoint) );
        condition2 = ( sim_state.trials( code_param.max_iterations, snrpoint ) == sim_param.max_trials( snrpoint ) );
        condition3 = ~mod( sim_state.trials(code_param.max_iterations, snrpoint),sim_param.save_rate );
        if ( condition1|condition2|condition3 )
            % FOR PROFILING RUNTIME
            % fprintf( '%f\n', etime(clock,t0) );
            % t0=clock;
            
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
            
            % redraw the BICM interleaver (so that it is uniform)
            if (code_param.coded)
                if ( sim_param.bicm > 0 )
                    code_param.bicm_interleaver = randperm(code_param.code_bits_per_frame)-1;
                end
            end

        end
    end

    % halt if BER or FER is low enough
    if ( ~code_param.outage & ( sim_state.BER(code_param.max_iterations, snrpoint) < sim_param.minBER  ) )
        % adjust max_iterations to be the last iteration that has not yet dropped below the BER threshold
        % Logic has changed on 7-28-06
        iteration_index = max( find( sim_state.BER(sim_param.plot_iterations,snrpoint) >= sim_param.minBER ) );        
       
        if isempty( iteration_index )
            break;
        else
            code_param.max_iterations = sim_param.plot_iterations( iteration_index );
            fprintf( '\nNumber of iterations = %d\n', code_param.max_iterations );
        end
    % elseif ( code_param.outage & ( sim_state.FER(code_param.max_iterations, snrpoint) < sim_param.minFER  ) )
    % break when the FER is low enough (changed on 12-31-07)
    elseif ( sim_state.FER(code_param.max_iterations, snrpoint) < sim_param.minFER  )
        break;
    end  
end

fprintf( 'Simulation Complete\n' );
current_time = fix(clock);
fprintf(  'Clock %2d:%2d:%2d\n',  current_time(4), current_time(5), current_time(6) );