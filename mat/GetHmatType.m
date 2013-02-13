

function hmat_type = GetHmatType( pcm )
if ~isempty(strfind( pcm, 'InitializeDVBS2' ))
    hmat_type = 'cml_dvbs2';
    
elseif strcmp( pcm(end-3:end), 'pchk')
    hmat_type = 'pchk';
    
elseif strcmp( pcm(end-4:end), 'alist')
    hmat_type = 'alist';
    
elseif strcmp( pcm(end-2:end), 'mat')
    hmat_type = 'mat';
    
elseif strcmp( pcm, 'random')
    hmat_type = 'random';
    
else
    hmat_type = 'not_supported';
    
end
end

