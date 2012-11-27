% apply transformations in pl toolbox and export
%inputs
% fhd  figure handle
% fs   font size
% zm   zoom factor [xmin xmax ymin ymax]
% it   image type {eps, pdf}
% fp   full path to export

function plfig(fhd, fs, zm, it, fp)
plss(fhd);
plfmt(fhd, fs);
plsz(fhd, zm);
plexport(fhd, it, fp);
end
