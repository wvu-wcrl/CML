% FindExitThreshold.m
% Given a CML scenario and record for EXIT analysis, FindExitThreshold finds the largest EsNo point for
% which the VND and CND curves touch.
%
%   Referenced work
%   [J23] M.C. Valenti and X. Xiang, “Constellation shaping for bit-interleaved LDPC coded APSK,” IEEE Transactions on Communications
%
% The calling syntax is:
%     EsNo = FindExitThreshold(  scenario, record )
%
%     Inputs
%     scenario     - CML scenario
%     record        - CML record of EXIT analysis
%
%     Outputs
%     EsNo           - largest simulated EsNo value for which VND and CND
%     curves touch
%
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 10/9/2012

function EsNo = FindExitThreshold(  scenario, record )

n = length(record);

for k = 1:n,
[ sim_param sim_state ] = read_exit_results( scenario, record(k) );

EsNo(k) = find_exit_threshold( sim_param, sim_state );
end


end


function [ sim_param sim_state ] = read_exit_results( scenario, record )
[sim_param sim_state] = CmlPlot( scenario, record );
end


function EsNo = find_exit_threshold( sim_param, sim_state )

IE_vnd = sim_state.exit_state.IE_vnd;  % shorten variable names
IA_cnd = sim_state.exit_state.IA_cnd;

I_diff = IE_vnd - IA_cnd;                       % determine where vnd and cnd curves cross
I_diff_less_than_0 = I_diff <= 0;          

snr_metric = sum(I_diff_less_than_0);  % define convenient metric for identifying cross
snrs_0 = find( snr_metric );                  % find indices of snr points having cross

if isempty( snrs_0 )
  EsNo = -1000;   % return -1000 if no cross found
else
    snr_ind = snrs_0(end);
    EsNo = sim_param.SNR( snr_ind );
end

end


%     Function SimExit is part of the Iterative Solutions Coded Modulation
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
