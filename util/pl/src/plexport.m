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
        
        cmd = ['epstopdf' ' ' tmpeps];
        system(cmd);
        
        tmppdf = [tmpprefix '.pdf'];
        pdffn = [figpath '.pdf'];
        cmd = ['mv' ' ' tmppdf ' ' pdffn];
        system(cmd);
    case 'png'
        pngfn = [figpath '.png'];
        
        tmpprefix = '/var/tmp/tmpimg';
        tmpeps = [tmpprefix '.eps'];
        print(fhd, '-depsc', tmpeps);
        
        cmd = ['convert' ' ' tmpeps ' ' pngfn];
        system(cmd);
    case {'', 'mfig'}
        % do nothing
    otherwise
        error('Image export type must be {''eps'', ''pdf'', ''png''} ');
end

end