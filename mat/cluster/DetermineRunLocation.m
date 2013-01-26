function run_loc = DetermineRunLocation()

  [dc hostname] = system('hostname');
  hostname = hostname(1:end-1);

if strcmp(hostname, 'wcrlCluster')
    run_loc = 'clusterworker';
else
    run_loc = 'local';
end

end
