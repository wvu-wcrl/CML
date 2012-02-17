function cap = CapacityTableLookup( EsNo_AWGN, capacity_AWGN, slope, gamma )
% CapacityTableLookup returns the instantaneous capacity for a particular
% channel realization by using a precalculated AWGN capacity table.
% Since the table does not generally contain capacity values for the exact
% SNR, linear interpolation is used to estimate the value.
%
% The calling syntax is:
%     cap = CapacityTableLoookup( EsNo_AWGN, capacity_AWGN, slope, gamma )
%
%     cap = The instantaneous capacity, a column vector with same number of
%     rows as gamma.
%
%     EsNo_AWGN = The SNR values stored in the table
%     capacity_AWGN = The AWGN capacity values stored in the table.
%     slope = The slope of the AWGN capacity curve.
%     gamma = The instantaneous SNRs for the channel realization.
%             Each row correpsonds to a distinct codeword,
%             And the columns correspond to the blocks of that codeword.
%
%     Copyright (C) 2005, Tarik Ghanim and Matthew C. Valenti
%
%     Last updated on Dec. 23, 2005
%
%     Function CapacityTableLookup is part of the Iterative Solutions Coded Modulation
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

% L is the number of blocks per codeword,
% while trial_size is the number of codewords per trial
[trial_size, L] = size( gamma );

max_SNR = max( EsNo_AWGN );
min_SNR = min( EsNo_AWGN );
max_cap = max( capacity_AWGN );

cap = zeros(size(gamma,1),1);

for codeword=1:trial_size
    for block=1:L
        if ( gamma(codeword,block) >= max_SNR )
            % SNR above smallest value in table; use largest capacity
            inst_cap(block) = max_cap;
        elseif ( gamma(codeword,block) > min_SNR )
            % Need to interpolate
            index_below = max( find( EsNo_AWGN < gamma(codeword,block) ) );
            correction = slope(index_below)*(gamma(codeword,block)-EsNo_AWGN(index_below));
            inst_cap(block) = capacity_AWGN(index_below) + correction;
        else
            % SNR below smallest value in table; assume capacity is zero
            inst_cap(block) = 0;
        end
        % add instantaneous capacities
        cap(codeword) = sum( inst_cap );
    end
end
