function [ ] = CmlPlotOp( HCF, Op, Mark, varargin )
% CmlPlotOp plots on the given capacity figure the SNR for each BER record
%  required to achieve  a particular error rate.
%
% The calling syntax is:
%     [ ] = CmlPlotOp( HCF, Op, Mark, <ber scen 1>, <recs1>,...
%                                     <ber scen N>, <recsN>)
%  where
%       HCF       Handle to capacity figure to annotate
%       Op        Operating BER point
%       Mark      Markers to use for plotting SNRs
%                   There must be one marker for each record
%
%      varagin contains 2-tuples, each of which contains
%       BerScen   BER scenario name
%       BRec      Vector of records with BER scenario to plot
%
%     Outputs
%       None
%
%
%     == Example ==
%     Consider a capacity plot having figure handle 2.
%     We wish to plot the Eb/N0 required to achieve BER 10^(-4)
%      for the LDPC simulations given by
%        scenario 'LdpcHmat', records 1 and 2.
%
%      >> CmlPlotOp( 2, 10^(-4), ['*' 'x'], 'LdpcHmat', [ 1 2 ] )
%
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     Last updated on May 4, 2013

%%% verify that each specified scenario has an accompaying record list
NV = length(varargin); % number of BER/record inputs
if rem( NV, 2 ) ~= 0,
    error('Each scenario be paired with an argument list.')
end


%%% manipulate BER and record inputs for convenient reference
BerScen = varargin(1:2:NV);    % extract BER scenarios
BRec = varargin(2:2:NV);       % extract BER records for each scenario


%%% loop over all specified scenario/record pairs plotting 
%%%  SNR required for the considered code rate
NScen = length(BerScen);    % Number of Ber scenarios
MCnt = 1;                   % Marker counter

for k = 1:NScen,
    BerScenk = BerScen{k};  % k-th BER scenario
    
    BRecN = BRec{k};        % N-th record vector
    BRecNM = length(BRecN); % Length of N-rth record vector
    
    % loop over all records for this scenario
    for m = 1:BRecNM,
        BRecNm = BRecN(m);  % m-th record
        
        % read simulation state for this scenario and record
        [sim_param_km sim_state_km] = ReadScenario( BerScenk, BRecNm );
        
        % find operating Eb/N0 point
        [EbnoOp] = find_op_ebno( sim_param_km, sim_state_km, Op );
    
        % plot marker
        figure(HCF); hold on;
        plot( sim_param_km.rate, EbnoOp, Mark(MCnt) );
        MCnt = MCnt + 1;
    end        
end

end


% determine Eb/N0 required to achieve the specified operating point
%  for the given scenario and record
function [EbnoOp] = find_op_ebno( sim_param_km, sim_state_km, Op )

% assume SNR is specified as Eb/N0
SNRdb = sim_param_km.SNR;
BER = sim_state_km.BER(end, :);  % consider final iteration

BER = BER( ~isnan(BER) );        % correct infinities

EbnoOp = interp1(BER,SNRdb,Op);

end

%     Function CmlPlotOp is part of the Iterative Solutions
%      Coded Modulation Library (ISCML).
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
%     US