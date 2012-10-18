function [ex_llr] = CmlTwrcRelaySomap( sym_lh, ap_llr, sim_param )
% CmlTwrcRelaySomap maps the symbols received at the relay during the
% multiple-access phase to llrs representing the network-coded source bits
%
% The calling syntax is:
%     [detected_data, errors] = CmlTwrcRelaySomap( sym_lh, ap_llr, sim_param )
%
%     Outputs:
%     ex_llr = Somap extrinsic llr output
%
%     Required inputs:
%     sym_lh = 
%     ap_llr = a-prior llr inputs. formed from decoder extrinsic llr.
%     sim_param = A structure containing simulation parameters.
%
%     Copyright (C) 2005-2012, Matthew C. Valenti and Terry Ferrett
%
%     Last updated on Oct 18, 2012

switch sim_param.twrc_param.protocol,

    case 'dnc'
    ex_llr = Somap_PNC( sym_lh, sim_param.mod_order, sim_param.demod_type, ap_llr );    
    
    case 'lnc'
end

end


%     Function CmlTwrcRelaySomap is part of the Iterative Solutions Coded Modulation
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


