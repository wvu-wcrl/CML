% convert job output file to cml output file, move to cml out, and delete
% job out
function MoveJobOutToCmlOut( full_path_to_job_output_file, scenario_name, record)
cur_record = record;

load( full_path_to_job_output_file );
save_param = JobParam;
save_state = JobState;

save_param = SetSimLocationLocal( save_param );

eval( scenario_name );

% issue arose with this syntax while testing scenario LdpcHmat record 3
%save( [cml_home sim_param(cur_record).filename], 'save_param', 'save_state';)
save( [sim_param(cur_record).filename], 'save_param', 'save_state');

delete( full_path_to_job_output_file );
end
