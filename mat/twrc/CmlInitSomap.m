function ap_llr = CmlInitSomap( sim_param, code_param )
% CmlInitSomap initializes a-priori Somap inputs.
%
% The calling syntax is:
%     sim_state = CmlInitSomap( sim_param, code_param )
%
%     sim_param = A structure containing simulation parameters.
%     code_param = A structure contining derived information.
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2005-2012, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on Oct. 18, 2012


switch sim_param.sim_type,
    case 'coded',
    ap_llr = zeros(1, code_param.code_bits_per_frame );

    case 'uncoded',
    ap_llr = zeros(1, code_param.data_bits_per_frame );
end
    
end

%     Function CmlInitSomap is part of the Iterative Solutions Coded Modulation
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
