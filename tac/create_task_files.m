% create pcs task files for cml scenarios and records
function create_task_files(cmlpath, scenarios, records, tmp_dir)


% create task file data structure
TaskParam.FunctionName = 'ClusterStartup';
TaskParam.FunctionPath = cmlpath;


num_scenarios = length(scenarios);

for scenario_count = 1:num_scenarios,

     cur_scenario = scenarios{scenario_count};

     num_records = length(records{scenario_count});

     for record_count = 1:num_records,

          cur_record = records{scenario_count}(record_count);
          TaskParam.InputParam = {cur_scenario cur_record};


          task_filename = [cur_scenario '_' int2str(cur_record) '.mat'];
          full_path_to_task = [tmp_dir '/' task_filename];
          save(full_path_to_task, 'TaskParam');

     end
end




end
