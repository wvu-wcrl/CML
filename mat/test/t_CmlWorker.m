
% read the location of CML's home
load('CmlHome.mat');


output_path = [cml_home '/scenarios' '/t_bersim' '/*'];
sys_cmd = ['rm' ' ' output_path];
system(sys_cmd);


[sim_param sim_state] = ReadScenario('t_BerSim', 1);
JobParam = sim_param;
JobState = sim_state;



TaskParam.JobParam = JobParam;
TaskParam.JobState = JobState;
TaskParam.cml_home = cml_home;


TaskState = CmlWorker( TaskParam );
