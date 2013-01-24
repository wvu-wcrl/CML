% FindBestFits.m
% Given an EXIT scenario file and range of records, find best curve fits
%  based on SNR threshold.
%
% The calling syntax is:
%     [ best_thresh best_records ] = FindExitThreshold(  scenario,...
%                                                    candidate_records,...
%                                                         N  )
%
%     Inputs
%     scenario          - EXIT scenario
%     candidate_records - records within scenario to consider
%     N                 - number of records to return
%
%     Outputs
%     best_thresh       - best threshold values
%     best_records      - records of best thresholds
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 10/9/2012

function [best_thresh best_records] = FindBestExitFits(  scenario,...
                                                candidate_records,...
                                                N )

thresh = FindExitThreshold(scenario, candidate_records);

[best_thresh I] = sort(thresh);
best_thresh = best_thresh(1:N);

best_records = candidate_records(I);
best_records = best_records(1:N);

end


%     Function FindBestFits is part of the Iterative Solutions Coded Modulation
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
