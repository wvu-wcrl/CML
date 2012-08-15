% compute_timing_stats.
%  Load timing data resulting from local and cluster simulation and compute stats
%
%  Inputs 
%   Two data files are read.
%     1. timedata1 - Contains single-core timing info
%     2. timedata2 - Contains cluster timing info.
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.




function compute_timing_stats()

load timedata1;
local_time = sim_time/60;

load timedata2;
cluster_time = sim_time/60;

proportional_speed = local_time/cluster_time;

fprintf('\n');
fprintf('Single-core simulation time: %.2f minutes.\n', local_time);
fprintf('Cluster simulation time: %.2f minutes.\n', cluster_time);
fprintf('Speedup: %.2f\n', proportional_speed);

exit

end
