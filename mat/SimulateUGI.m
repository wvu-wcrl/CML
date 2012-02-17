function sim_state = SimulateUGI( sim_param, sim_state, code_param )
% SimulateUGI simulates the information outage probability of 1 or 2-D
% modulation with an unconstrained Gaussian input (UGI)
%
% The calling syntax is:
%     sim_state = SimulateUGI( sim_param, sim_state )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     code_param = A structure contining derived information.
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2007, Matthew C. Valenti and David Buckingham
%
%     Last updated on Dec. 30, 2007
%
%     Function SimulateUGI is part of the Iterative Solutions Coded Modulation
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
%     USA

fprintf( 'Rate = %f\n', code_param.rate );

% determine Es/No
if ( sim_param.SNR_type(2) == 'b' ) % Eb/No
    EbNo = 10.^(sim_param.SNR/10);
    EsNo = EbNo*(code_param.rate);
else % Es/No
    EsNo = 10.^(sim_param.SNR/10);
end

% temporary filename
tempfile = 'tempsave.mat';


% simulate
for snrpoint = 1:length(EsNo)
    fprintf( strcat( '\n', sim_param.SNR_type, ' = %f dB\n'), sim_param.SNR(snrpoint) );
    current_time = fix(clock);
    fprintf(  'Clock %2d:%2d:%2d\n',  current_time(4), current_time(5), current_time(6) );

    % constant
    if ( sim_param.mod_order == 0 )
        const = log( 1 + EsNo(snrpoint) );        
    else
        const = 1/2*log(1+2*EsNo(snrpoint));
    end

    % Noise standard deviation
    noise_std = sqrt( 1/(2*EsNo(snrpoint)) );

    % loop until either there are enough trials or enough errors
    while ( ( sim_state.trials( snrpoint ) < sim_param.max_trials( snrpoint ) )&( sim_state.frame_errors( snrpoint) < sim_param.max_frame_errors(snrpoint) ) )

        % increment the trials counter
        sim_state.trials(snrpoint) = sim_state.trials(snrpoint) + 1;


        % mutual information random vector
        if ( sim_param.mod_order == 0) % 2-D
            % normalized (complex) Gaussian input
            x = sqrt(0.5).*( randn( 1, code_param.symbols_per_frame ) + ...
                j*randn( 1, code_param.symbols_per_frame ) );

            % Additive White (complex) Gaussian noise
            n = noise_std*( randn( 1, code_param.symbols_per_frame ) + ...
                j*randn( 1, code_param.symbols_per_frame ) );

            % received signal
            y = x + n;

            info = const + EsNo(snrpoint)*( (abs(y)).^2/( EsNo(snrpoint) + 1 ) - (abs(y-x)).^2 );
        else % 1-D so only consider real-part
            % normalized real-valued Gaussian input
            x = randn( 1, code_param.symbols_per_frame );

            % Additive White Gaussian noise
            n = noise_std*randn( 1, code_param.symbols_per_frame );

            % received signal
            y = x + n;

            info = const + EsNo(snrpoint)*( (y).^2/( 2*EsNo(snrpoint) + 1 ) - (y-x).^2 );
        end
        
        % Divide by ln(2) to convert from nats to bits for rate comparison
        result = mean( info )./log(2);
        
        % Compare instantaneous capacity with code rate
        if (result < code_param.rate)
            % Log error
            fprintf( 'x' );
            sim_state.frame_errors(snrpoint) = sim_state.frame_errors(snrpoint) + 1;
            sim_state.FER(snrpoint) = sim_state.frame_errors(snrpoint)./sim_state.trials(snrpoint);
        end
        
        % determine if it is time to save (either (1) last error, (2) last frame, or (3) once per save_rate)
        condition1 = ( sim_state.frame_errors(snrpoint) == sim_param.max_frame_errors(snrpoint) );
        condition2 = ( sim_state.trials(snrpoint) == sim_param.max_trials( snrpoint ) );
        condition3 = ~mod( sim_state.trials(snrpoint),sim_param.save_rate );
        if ( condition1|condition2|condition3 )
            fprintf('.');
            save_state = sim_state;
            save_param = sim_param;           
            save( tempfile, code_param.save_flag, 'save_state', 'save_param');

            % Store into local directory (if running locally)
            if ( sim_param.compiled_mode )
                copyfile( tempfile, sim_param.filename, 'f' );
            end

            movefile( tempfile, code_param.filename, 'f');

        end
    end
    
    % Recalculate FER
    sim_state.FER(snrpoint) = sim_state.frame_errors(snrpoint)./sim_state.trials(snrpoint);
    
    % Check to see if FER is low enough
    if ( sim_state.FER(snrpoint) < sim_param.minFER )
        break;
    end 
end

