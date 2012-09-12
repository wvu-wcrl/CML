function sim_state = FinalExitMetrics( sim_param, sim_state, trials,snrpoint )
% FinalExitMetrics computes EXIT curves using detector mutual information
% metrics
%
% The calling syntax is:
%     sim_state = FinalExitMetrics( sim_param, sim_state, trials, snrpoint )
%
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     trials        = number of simulation trials per snr point
%     snrpoint   = index of current snr point
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2012, Xingyu Xiang, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 9/4/2012


switch sim_param.exit_param.exit_type,
    case 'ldpc',
               
        % detector transfer curve
        P = polyfit(sim_state.exit_state.IA_det_sum(:,snrpoint)/trials, sim_state.exit_state.IE_det_sum(:,snrpoint)/trials, 3);
                
        % VND transfer curve
        dv_dist = sim_param.exit_param.dv_dist;
        n = length( dv_dist );
        dv = sim_param.exit_param.dv;
        dc = sim_param.exit_param.dc;
        rate = sim_param.exit_param.rate;
        
        
        b = dv.*dv_dist/( (1-rate) * dc);
        
        
        for m = 1:n,            
            for k = 1:length( sim_param.exit_param.requested_IA )
                sigma_IA = invJ1(sim_param.exit_param.requested_IA(k));
                sim_state.exit_state.I_A_det(k,snrpoint) =J2( sqrt(dv(m)) * sigma_IA); % equation 20 in Brink paper, 2004
                sim_state.exit_state.I_E_det(k,snrpoint) = P(1)*sim_state.exit_state.I_A_det(k,snrpoint)^3 +...
                    P(2)*sim_state.exit_state.I_A_det(k,snrpoint)^2 +...
                    P(3)*sim_state.exit_state.I_A_det(k,snrpoint) +...
                    P(4); % equation 21 in Brink paper, 2004
                sigma = (dv(m)-1)* sigma_IA^2 + (invJ1(sim_state.exit_state.I_E_det(k,snrpoint)))^2;
                sim_state.exit_state.IE_vnd(k,snrpoint) = sim_state.exit_state.IE_vnd(k,snrpoint) + b(m)*J2(sqrt(sigma));  % equation 22 in Brink paper, 2004
            end           
        end
        
      
    % CND transfer curve
    requested_IE = sim_param.exit_param.requested_IA;
    len_IE = length(requested_IE);
    
    for IE_index = 1:len_IE
        sigma_temp = invJ1(1 - requested_IE(IE_index));
        sigma = sigma_temp/sqrt(sim_param.exit_param.dc-1);
        sim_state.exit_state.IA_cnd(IE_index, snrpoint) = 1 - J2(sigma);
    end
                    
    case 'turboproc',
        
    otherwise,
        
end



%     Function FinalExitMetrics is part of the Iterative Solutions Coded Modulation
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
