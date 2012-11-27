function run_loc = DetermineRunLocation()

[dc hostname] = system('hostname');
if strcmp(hostname, 'wcrlCluster')
    run_loc = 'cluster';
else
    run_loc = 'local';
end

end