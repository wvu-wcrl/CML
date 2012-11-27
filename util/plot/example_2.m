% example of plotting script usage

CmlPlot('TestLdpcDecod', [1:5]);
fhd = 1;
fs = 16;
zm = [0 10 10^(-3) 1];
it = 'pdf';
fp = '/home/tferrett/test'

plfig(fhd, fs, zm, it, fp);
