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

if sim_param.code_configuration == 2,
    
    if strcmp(sim_param.ldpc_impl, 'new')
        
        % check parity check matrix for consistency
        check_pcm( code_param.H_rows, code_param.H_cols,...
            code_param.data_bits_per_frame,...
            sim_param.framesize);
        
        % currently no difference in logic between random and otherwise
        if strcmp(sim_param.parity_check_matrix, 'random')
            [row_one col_one] = PostProcessH( code_param.H_rows, code_param.H_cols );
        else
            % check H_rows, H_cols for consistency
            [row_one col_one] = PostProcessH( code_param.H_rows, code_param.H_cols );
        end
        
        % create LDPC decoder object.
        ldpc_decoder = LdpcDecoder();
        ldpc_decoder = ldpc_decoder.CreateTannerGraph( row_one, col_one,...
            code_param.code_bits_per_frame );
    else
        ldpc_decoder = [];
    end
else
    ldpc_decoder = [];
end
end


function check_pcm( H_rows, H_cols,...
    data_bits_per_frame,...
    framesize)

% parity check matrix dimensions
K = length(H_cols);
NMinusK = length(H_rows);
N = NMinusK + K;


% code bits per frame specified in scenario file
%  consistent with H-matrix size
if N ~= framesize,
    ErrMsg = ['Frame size specified in scenario file' ' ',...
        'not consistent with H-matrix dimensions.'];
    error(ErrMsg);
end


% data bits per frame specified in scenario file
%  consistent with H-matrix size
if K ~= data_bits_per_frame,
    ErrMsg = ['Data bits per frame specified in scenario file' ' ',...
        'not consistent with H-matrix dimensions.'];
    error(ErrMsg);
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

