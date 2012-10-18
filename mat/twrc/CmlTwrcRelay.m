function [ r a_1 a_2 ] = CmlTwrcRelay( s_1, s_2, code_param, EsNo )
% CmlTwrcRelay simulates transmission of symbols from both sources
% to the relay.
%
%     r = channel-corrupted received signal vector
%     s_1 = symbols transmitted by source 1
%     s_2 = symbols transmitted by source 2%
%     code_param = A structure containing the code paramaters.
%     EsNo = Ratio of Es/No (linear units -- not dB).
%
%     Copyright (C) 2012, Terry Ferrett
%
%     Last updated on 10/17/2012

switch code_param.channel_type
    
    case 1,   
    
        [ r a_1 a_2 ] = CmlTwrcRayleigh( s_1, s_2, EsNo, code_param );
        
    otherwise 
        
        % r = CmlTwrcAwgn( s_1, s_2, EsNo, code_param );
        
end
        
end


function [ r a_1 a_2 ] = CmlTwrcRayleigh( s_1, s_2, EsNo, code_param )

[ M_1 N_1 ] = get_symbol_vector_dimensions(s_1);

[ n ]   = generate_noise_samples( M_1, N_1, EsNo, code_param );
[ a_1 ] = generate_fading_coefficients( M_1, N_1 );
[ a_2 ] = generate_fading_coefficients( M_1, N_1 );

[ r ] = transmit_symbols_through_channel( s_1, s_2, a_1, a_2, n );

end


function n = generate_noise_samples( M, N, EsNo, code_param )

var = 1/(2*EsNo);

n = sqrt(var) * ( randn( M, N ) + j*randn( M, N ) );

n = code_param.fil_noise * n;

end


function a = generate_fading_coefficients( M, N )

a = sqrt( 1/2 ) * ( randn( 1, N ) + j * randn( 1, N ) );

a = repmat( a, M, 1 );

% same fading coefficient for all dimensions
end


function [ M_1 N_1 ] = get_symbol_vector_dimensions(s)

[ M_1 N_1 ] = size(s);

end


function r = transmit_symbols_through_channel( s_1, s_2, a_1, a_2, n )

r = a_1.*s_1 + a_2.*s_2 + n;

end




%     Function CmlTwrcRelay is part of the Iterative Solutions Coded Modulation
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

