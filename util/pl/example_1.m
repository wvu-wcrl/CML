% example of plotting script usage


CmlPlot('TestLdpcDecod', [1:5]);  % plot a result

plss(1);  % scale

plfmt(1, 16); % format

plsz(1, [0 10 10^(-2) 1] );  % zoom

plexport(1, '/home/tferrett/cmlmerge/cmlnew/util/plot/test.eps');  % export


