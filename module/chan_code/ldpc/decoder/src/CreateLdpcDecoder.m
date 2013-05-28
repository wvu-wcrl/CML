% CreateLdpcDecoder.m
%  Create an LDPC decoder object given CML sim_param and code_param.
%
% Inputs
%  sim_param       CML structure containing general simulation parameters
%  code_param      CML structure containing channel_coding parameters
%
%  Last updated on 3/8/2013
%
%  Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%  For full copyright information see the bottom of this file.

function [ldpc_decoder] = CreateLdpcDecoder( sim_param, code_param )

% if ldpc code
if sim_param.code_configuration == 2,
    
    % new style decoder
    if strcmp(sim_param.ldpc_impl, 'new')
        
        % convert H_rows, H_cols to C-style indexing
        [row_one col_one] = PostProcessH( code_param.H_rows,...
            code_param.H_cols );
        
        % create LDPC decoder object.
        ldpc_decoder = LdpcDecoder();
        ldpc_decoder = ldpc_decoder.CreateTannerGraph( row_one, col_one,...
            code_param.code_bits_per_frame );
        
    else % old style decoder. do not create new decoder object.
        ldpc_decoder = [];
    end
else % some other decoder. create
    ldpc_decoder = [];
end

end




%     This library is free software;
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

