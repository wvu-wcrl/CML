function exit_state = UpdateExitMetrics( exit_param, exit_state, exit_state_diff, snrpoint )
% UpdateExitMetrics  computes detector mutual information metrics for EXIT
% analysis
%
% The calling syntax is:
%     exit_state = UpdateExitMetrics( exit_param, exit_state, exit_state_diff, snrpoint )
%
%     Inputs
%     exit_param = parameters for exit analysis
%     exit_state   = current exit analysis state
%     exit_state_diff = state generated on this simulation loop iteration
%     snrpoint          = index of current snr point
%    
%     Outputs
%     exit_state       = updated mutual information metrics
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2012, Xingyu Xiang, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 9/4/2012


switch exit_param.exit_type,
    case 'ldpc',
        exit_state.IA_det_sum(:,snrpoint) = exit_state.IA_det_sum(:,snrpoint) + exit_state_diff.IA_det';
        exit_state.IE_det_sum(:, snrpoint) = exit_state.IE_det_sum(:,snrpoint) + exit_state_diff.IE_det';
        
        
    case 'turboproc',
        
    otherwise,
        
end



%     Function UpdateExitMetrics is part of the Iterative Solutions Coded Modulation
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
