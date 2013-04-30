% apply transformations in pl toolbox and export
%inputs
% fhd  figure handle
% fs   font size
% zm   zoom factor [xmin xmax ymin ymax]
% it   image type {eps, pdf}
% fp   full path to export

function plfig(fhd, fs, zm, lloc, it, fp)
plss(fhd);       % set figure size
plfmt(fhd, fs);  % set font size and line width
plsl( fhd, lloc); % set legend location
plsz(fhd, zm);   % set zoom
plexport(fhd, it, fp); % export plot
end
