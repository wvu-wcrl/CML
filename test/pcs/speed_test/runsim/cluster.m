function cluster(scenario, record, cml_root, data_file)

cd(cml_root);

CmlStartup;

CmlClusterConsume;
 
tic;

CmlClusterSubmit(scenario, record);

wait_for_job( scenario, record );

sim_time = toc;

save(data_file, 'sim_time');

CmlClusterConsume

exit

end


function wait_for_job( scenario, record )
[project_root] = CmlReadProjectRoot();

job_name = [ scenario '_' int2str(record) '.mat' ];

job_output_file = [ project_root filesep 'JobOut' filesep job_name ];


fprintf('Waiting for cluster CML job to complete.\n');
while ~exist(job_output_file)
fprintf('.');
pause(2);
end


end
