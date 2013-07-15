% exports figure handles as .pdf files. Linux-specific.
function plexport(fhd, it, figpath)

switch it
    case 'eps'
        epsfn = [figpath '.eps']
        print(fhd, '-depsc', '-r600', epsfn);
    case 'pdf'
        tmpprefix = '/var/tmp/tmpimg';
        tmpeps = [tmpprefix '.eps'];
        print(fhd, '-depsc', tmpeps);
        
        % convert eps to pdf
        cmd = ['epstopdf' ' ' tmpeps];
        system_cml(cmd);
        
        % crop pdf
        tmppdf = [tmpprefix '.pdf'];
        cmd = ['pdfcrop' ' ' tmppdf ' ' tmppdf];
        system_cml(cmd);
        
        % move pdf to figure directory
        pdffn = [figpath '.pdf'];
        cmd = ['mv' ' ' tmppdf ' ' pdffn];
        system_cml(cmd);
    case 'png'
        pngfn = [figpath '.png'];
        
        tmpprefix = '/var/tmp/tmpimg';
        tmpeps = [tmpprefix '.eps'];
        print(fhd, '-depsc', tmpeps);
        
        cmd = ['convert' ' ' tmpeps ' ' pngfn];
        system_cml(cmd);
    case {'', 'mfig'}
        % do nothing
    otherwise
        error('Image export type must be {''eps'', ''pdf'', ''png''} ');
end

end


% system_cml( cmd )
%  CML specific function for executing UNIX shell commands.
%  This function clears the environment variable 
%    LD_LIBRARY_PATH
%  prior to running a MATLAB system() command to avoid library
%  incompatibilities.
%
% Terry Ferrett
%  6/23/2013
function system_cml( cmd )
% Get MATLAB's LD_LIBRARY_PATH
LD_LIBRARY_PATH_MATLAB = getenv('LD_LIBRARY_PATH');

% Clear LD_LIBRARY_PATH
setenv('LD_LIBRARY_PATH', ':');

system(cmd);

setenv('LD_LIBRARY_PATH',LD_LIBRARY_PATH_MATLAB);
end