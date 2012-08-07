% InputParam data structures
load('CmlHome.mat');
[dc path_suffix] = strtok(cml_home, '/');
cml_home_remote = ['/rhome' path_suffix];

[sim_param sim_state] = ReadScenario('t_BerSim', 2);


% TaskParam data structures
FunctionPath = [cml_home_remote '/' 'mat'];
FunctionName = 'CmlWorker';

% read code_param short from disk
load('code_param_short.mat');


% copy code_param_long example to data directory  
load('code_param_long.mat');
save('/home/tferrett/Projects/cml/data/t_BerSim_2.mat', 'code_param_long');


% create TaskParam
clear TaskParam;
TaskParam.FunctionName = FunctionName;
TaskParam.FunctionPath = FunctionPath;
TaskParam.InputParam.JobParam = sim_param;
TaskParam.InputParam.JobParam.code_param_long_filename = ['t_BerSim' '_' '2' '.mat'];
TaskParam.InputParam.JobParam.code_param_short = code_param_short;
TaskParam.InputParam.JobParam.cml_rhome = cml_home_remote;
TaskParam.InputParam.RandSeed = 100;
TaskParam.InputParam.JobState = sim_state;


% save task to file
save('cml_test_task.mat', 'TaskParam');
