function tac( cml_scenarios, cml_records, tmp_dir )
% tac.m
% create task files to launch cml using pcs and move to user input queue
%
% cml_scenarios   cell array of cml scenarios
% cml_records     cell array of cml records to run for each scenario
%
% task files are created in a temporary directory and moved to input queue




[tmp_dir cml_path]  = set_paths(); 

[iq rq oq] = read_pcs_queue_locations();   

create_task_files(cml_path, scenarios, records, tmp_dir); 

             move_task_files_to_iq(tmp_dir, iq);




end






