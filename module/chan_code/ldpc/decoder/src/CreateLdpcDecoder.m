function [ldpc_decoder] = CreateLdpcDecoder( sim_param, code_param )
if strcmp(sim_param.ldpc_impl, 'new')

    ldpc_decoder = LdpcDecoder();
    
    if strcmp(sim_param.parity_check_matrix, 'random')
    row_one = code_param.H_rows;
    col_one = code_param.H_cols;
    %[row_one col_one] = PostProcessH( code_param.H_rows, code_param.H_cols );     
    else        
        
    [row_one col_one] = PostProcessH( code_param.H_rows, code_param.H_cols );     
    end
    
    ldpc_decoder = ldpc_decoder.CreateTannerGraph( row_one, col_one,...
        code_param.code_bits_per_frame );
else
    
    
    
ldpc_decoder = [];
end
end
