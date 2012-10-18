function [ detected_data, errors, ex_llr ] = CmlTwrcRelayDecode( input_decoder_c, nc_data, sim_param, code_param, errors, iter )
% CmlTwrcRelayDecode performs a single iteration of iterative decoding at
% the relay.
%
% The calling syntax is:
%     [detected_data, errors, ex_llr] = CmlDecode( input_decoder_c, nc_data, sim_param, code_param,errors, iter )
%
%     Outputs:
%     detected_data = a row vector containing the detected data
%     errors = a column vector containing the number of errors per iteration
%     ex_llr = decoder extrinsic llr output
%
%     Required inputs:
%     input_decoder_c = Somap extrinsic llr output
%     nc_data = row vector of network-coded data bits
%     sim_param = A structure containing simulation parameters.
%     code_param = A structure containing the code paramaters.
%     errors = vector of errors encountered during each decoding iteration
%     iter = current decoding iteration
%
%     Copyright (C) 2005-2012, Matthew C. Valenti and Terry Ferrett
%
%     Last updated on Oct 18, 2012

persistent N1 K1 N2 K2 bicm_iterations turbo_iterations;
persistent input_decoder_u;


if( iter == 1 )
switch sim_param.code_configuration
    
    case {0} % convolutional
    
        [ N1 K1 input_decoder_u bicm_iterations ] = init_convolutional( sim_param, code_param );
    
    case {1,4} % PCCC
        
        
        [ N1 K1 N2 K2 bicm_iterations turbo_iterations input_decoder_u ] = init_pccc( sim_param, code_param );
        
    case {3} % HSDPA

        [ bicm_iteration turbo_iterations M_arq ] = init_hsdpa( sim_param, code_param );
        
end

errors = zeros(turbo_iterations*bicm_iterations,1);

end


  switch sim_param.code_configuration
        
        case {0} % convolutional
            
        case {1,4} % PCCC                  
            
            [detected_data, turbo_errors, output_decoder_c, output_decoder_u ] = TurboDecode( input_decoder_c,...
                nc_data,...
                turbo_iterations,...
                sim_param.decoder_type,...
                code_param.code_interleaver,...
                code_param.pun_pattern,...
                code_param.tail_pattern,...
                sim_param.g1,...
                sim_param.nsc_flag1,...
                sim_param.g2,...
                sim_param.nsc_flag2,...
                input_decoder_u );
            
            errors( (iter-1)*turbo_iterations+1:iter*turbo_iterations ) = turbo_errors;
            
    
                input_decoder_u = output_decoder_u;
    
        case {2} % LDPC
            [x_hat errors] = MpDecode( -input_decoder_c, code_param.H_rows, code_param.H_cols, code_param.max_iterations, sim_param.decoder_type, 1, 1, data );
            detected_data = x_hat(code_param.max_iterations,:);
            return; % BICM-ID is not supported for LDPC codes.
        case {3} % HSDPA
         
        case {5,6} % CTC code from WiMAX (5) or DVB-RCS (6)
          
        case {7} % BTC          
    
  end
    
  ex_llr = output_decoder_c - input_decoder_c;
      
    
    
end




function [ bicm_iterations turbo_iterations M L ] = init_params( sym_lh )

bicm_iterations = 1;
turbo_iterations = 1;

[ M L ] = size( sym_lh );
end




function [ N1 K1 input_decoder_u bicm_iter ] = init_convolutional( sim_param, code_param )
[N1,K1] = size( sim_param.g1 );
input_decoder_u = zeros(1, code_param.data_bits_per_frame ); % stays at zero
if ( length(code_param.max_iterations) )
    bicm_iter = code_param.max_iterations;
end
end



function [ N1 K1 N2 K2 bicm_iterations turbo_iterations input_decoder_u ] = init_pccc( sim_param, code_param )
[N1,K1] = size( sim_param.g1 );
if ( sim_param.bicm == 2 ) % bicm-id
    bicm_iterations = code_param.max_iterations;
    turbo_iterations = 1;
else
    turbo_iterations = code_param.max_iterations;
    bicm_iterations = 1;
end

[N2,K2] = size( sim_param.g2 );
input_decoder_u = zeros(1, code_param.data_bits_per_frame );
end


function [ bicm_iteration turbo_iterations M_arq ] = init_hsdpa( sim_param, code_param )
% BICM-ID not supported
bicm_iteration = 1;
turbo_iterations = code_param.max_iterations;

% Number of H-ARQ transmissions
M_arq = length(sim_param.X_set);
end








% switch sim_param.code_configuration
%     case {0} % convolutional
%             
%             
%             depuncture if necessary
%             if ( length (sim_param.pun_pattern1 ) )
%                 depunctured_output = Depuncture( input_decoder_c, sim_param.pun_pattern1, sim_param.tail_pattern1 );
%                 input_c = reshape( depunctured_output, 1, prod( size( depunctured_output ) ) );
%             else
%                 input_c = input_decoder_c;
%             end
%             
%             % decode
%             if ( sim_param.decoder_type < 0 )
%                 % fprintf( 'Viterbi decoding\n' );
%                 detected_data = ViterbiDecode( input_c, sim_param.g1, sim_param.nsc_flag1, sim_param.depth );
%             else
%                 [output_decoder_u, output_decoder_c] = SisoDecode( input_decoder_u, input_c, sim_param.g1, sim_param.nsc_flag1, sim_param.decoder_type );
%                 detected_data = (sign(output_decoder_u)+1)/2;
%             end
%             
%             % count errors
%             error_positions = xor( detected_data, data );
%             errors(bicm_iter) = sum( error_positions );
%             
%             % exit if all the errors are corrected or if a Viterbi decoder
%             if (errors(bicm_iter)==0)||( sim_param.decoder_type < 0 )
%                 return;
%             end
%             
%             % repuncture if necessary
%             if ( length (sim_param.pun_pattern1 )&&(sim_param.bicm > 0) )
%                 output_decoder_c = reshape( output_decoder_c, N1, length(output_decoder_c)/N1 );
%                 output_decoder_c = Puncture( output_decoder_c, sim_param.pun_pattern1, sim_param.tail_pattern1 );%             end
%             
%             
%             
%         case {1,4} % PCCC
%             [detected_data, turbo_errors, output_decoder_c, output_decoder_u ] = TurboDecode( input_decoder_c, data, turbo_iterations, sim_param.decoder_type, code_param.code_interleaver, code_param.pun_pattern, code_param.tail_pattern, sim_param.g1, sim_param.nsc_flag1, sim_param.g2, sim_param.nsc_flag2, input_decoder_u );
%             errors( (bicm_iter-1)*turbo_iterations+1:bicm_iter*turbo_iterations ) = turbo_errors;
%             
%             % exit if all the errors are corrected
%             if (turbo_errors(turbo_iterations)==0)
%                 return;
%             else
%                 % determine new input_decoder_u
%                 input_decoder_u = output_decoder_u;
%             end
%         case {2} % LDPC
%             [x_hat errors] = MpDecode( -input_decoder_c, code_param.H_rows, code_param.H_cols, code_param.max_iterations, sim_param.decoder_type, 1, 1, data );
%             detected_data = x_hat(code_param.max_iterations,:);
%             return; % BICM-ID is not supported for LDPC codes.
%         case {3} % HSDPA
%             % Dematch each H-ARQ transmission
%             LLR_buffer = zeros(code_param.number_codewords,code_param.N_TTI);
%             harq_input = reshape( input_decoder_c, code_param.number_codewords*code_param.N_data, M_arq )';
%             for harq_transmission=1:M_arq
%                 [LLR] = HarqDematch( reshape( harq_input(harq_transmission,:), code_param.U, code_param.number_codewords*sim_param.P)', sim_param.X_set(harq_transmission), sim_param.N_IR, code_param.N_TTI, code_param.number_codewords );
%                 % update the virtual buffer
%                 LLR_buffer = LLR_buffer + LLR;
%             end
%             
%             % Decode
%             [detected_data, errors, output_decoder_c ] = TurboDecode( LLR_buffer, data, turbo_iterations, sim_param.decoder_type,  code_param.code_interleaver, code_param.pun_pattern, code_param.tail_pattern, sim_param.g1, sim_param.nsc_flag1, sim_param.g2, sim_param.nsc_flag2 );
%             
%             % BICM-ID not currently supported, so return
%             return;
%         case {5,6} % CTC code from WiMAX (5) or DVB-RCS (6)
%             [x_hat errors] = TurboDuobinaryCRSCDecode( input_decoder_c, code_param.code_interleaver, code_param.pun_pattern, data, code_param.max_iterations, sim_param.decoder_type);
%             detected_data = x_hat;
%             return; % BICM-ID is not supported for Wimax CTC code.
%         case {7} % BTC
%             [detected_data, errors] = BtcDecode( input_decoder_c, data, sim_param.g1, sim_param.g2, sim_param.k_per_row, sim_param.k_per_column, sim_param.B, sim_param.Q, code_param.max_iterations, sim_param.decoder_type );
%             return; % BICM-ID is not supported
%     
%     
%     
%     end





%     Function CmlTwrcRelayDecode is part of the Iterative Solutions Coded Modulation
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
