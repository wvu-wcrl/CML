function plexport(fhd, it, figpath)

switch it
    case 'eps'
        print(fhd, '-depsc', '-r600', figpath);
    case 'pdf'
        tmpeps = '/var/tmp/tmpeps';
        print(fhd, '-depsc', '-r600', tmpeps);
        
        cmd = ['epstopdf' ' ' tmpeps '.eps'];
        system(cmd);
        
        cmd = ['mv' ' ' tmpeps '.eps' ' ' figpath '.pdf'];
        system(cmd);
    otherwise
        error('Image export type must be ''eps'' or ''pdf'' ');    
end

end