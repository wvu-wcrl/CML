
% read the location of CML's home
load('CmlHome.mat');




[sim_param sim_state] = ReadScenario('PcsBer', 1);
JobParam = sim_param;
JobState = sim_state;



TaskParam.JobParam = JobParam;
TaskParam.JobState = JobState;
TaskParam.cml_home = cml_home;


TaskState = CmlWorker( TaskParam );
