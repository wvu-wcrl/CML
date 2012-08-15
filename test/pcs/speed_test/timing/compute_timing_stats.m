function compute_timing_stats()

load timedata1;

local_time = sim_time/60;

load timedata2;

cluster_time = sim_time/60;

proportional_speedup = local_time/cluster_time;

fprintf('\n');
fprintf('Single-core simulation time: %.2f minutes.\n', local_time);
fprintf('Cluster simulation time: %.2f minutes.\n', cluster_time);
fprintf('Speedup: %.2f\n', proportional_speedup);

exit

end
