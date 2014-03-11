% CalculateMinSNR determines that capacity of FSK under bandwidth
% constraints, by returning min Eb/No (dB) as a function of h.
%
% The calling syntax is:
%     [sim_param, sim_state] = CalculateMinSNR( sim_param, sim_state, code_param )
%
%     sim_param: A structure containing simulation parameters.
%     sim_state: A structure containing the simulation state.
%
%     code_param: A structure contining derived information.
%
%     Note: See readme.txt for a description of the structure formats.
%
% Copyright (C) 2006-2014, Matthew C. Valenti
%
% Last updated on Oct. 12, 2007
%
% Licensed under the Lesser GPL.  See the source code file for more detail.

function  [sim_param, sim_state] = CalculateMinSNR( sim_param, sim_state, code_param )

epsilon = 1e-4; % a small number

% read in the simulation results
[read_param, read_state] = ReadScenario( sim_param.input_filename, sim_param.scenarios );
number_records = length( sim_param.scenarios );

% read in the database
% should contain a BwMatrix matrix with three columns
% First column is M, second is h, and third is uncoded BW
load( sim_param.bwdatabase );

% go through each record
for record=1:number_records

    % store the h value
    sim_param.h(record) = read_param(record).h;

    % for this h and M, determine the bandwidth from the database
    M_values = find( BwMatrix(:,1) == read_param(record).mod_order );
    h_values = find( abs(BwMatrix(:,2) - read_param(record).h) < epsilon);
    Matching_row = min( intersect( M_values, h_values ) );
    bandwidth = BwMatrix( Matching_row, 3 );

    % determine the minimum allowable code rate
    min_rate = bandwidth/log2(read_param(record).mod_order)/sim_param.bwconstraint;
    sim_state.min_rate(record) = min_rate;

    % determine which Es/No point corresponds to the min_rate
    r = read_state(record).capacity_avg;
    rindex = find( r>epsilon & r< 1-epsilon);    
   
    if ( ( min_rate < 1 )&(length(rindex)>1) )

        best_EsNodB = interp1( r(rindex), read_param(record).SNR(rindex), min_rate );

        % convert to Eb/No (dB)
        best_EsNo = 10.^(best_EsNodB/10);
        best_EbNo = best_EsNo/(min_rate*log2( read_param(record).mod_order ));
        best_EbNodB = 10*log10( best_EbNo );

        % see if a higher rate is actually better
        EsNo = 10.^( read_param(record).SNR/10 );
        rindex = find( r >= min_rate & r < 1-epsilon);
        rvalues = r( rindex );

        EbNo = (EsNo(rindex)./rvalues)/log2( read_param(record).mod_order );
        EbNodB = 10*log10( EbNo );

        if ( min( EbNodB ) < best_EbNodB )
            [y,i] = min(EbNodB);
            best_EbNodB = y;
            min_rate = rvalues(i);

            EsNodB_rindex = read_param(record).SNR(rindex);
            best_EsNodB = EsNodB_rindex(i);
            % fprintf( 'best rate is %f\n', min_rate );
        end

        sim_state.min_EbNodB(record) = best_EbNodB;
        sim_state.min_EsNodB(record) = best_EsNodB;
        sim_state.best_rate(record) = min_rate;
    else
        sim_state.min_EbNodB(record) = NaN;
        sim_state.min_EsNodB(record) = NaN;        
        sim_state.best_rate(record) = NaN;
    end
end

% save results
save_state = sim_state;
save_param = sim_param;
save( code_param.filename, code_param.save_flag, 'save_state', 'save_param');

end

%     Function CalculateMinSNR is part of the Iterative Solutions Coded Modulation
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

