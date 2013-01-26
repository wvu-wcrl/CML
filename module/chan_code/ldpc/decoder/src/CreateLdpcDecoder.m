function [ldpc_decoder] = CreateLdpcDecoder( sim_param, code_param )



if strcmp(sim_param.ldpc_impl, 'new')    
    
    
    % load parity check matrix based on cluster or local
    
    
    
    % check parity check matrix (nyuk nyuk) for consistency
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
