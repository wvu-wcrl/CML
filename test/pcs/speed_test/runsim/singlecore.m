function singlecore(scenario, record, cml_root, data_file)

cd(cml_root);

CmlStartup;

tic;

CmlSimulate(scenario, record);

sim_time = toc;

save(data_file, 'sim_time');

exit

end
