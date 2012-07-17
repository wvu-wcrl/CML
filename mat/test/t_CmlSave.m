
% read the location of CML's home
%load('CmlHome.mat');

tempfile = 'tmp.mat'
sim_state.test = 1;
sim_param.test = 1;
code_param.save_flag = '-v6';
code_param.filename = 'filename.mat';

save_struct.tempfile = tempfile;
save_struct.save_state = sim_state;
save_struct.save_param = sim_param;
save_struct.save_flag = code_param.save_flag;
save_struct.code_param.filename = code_param.filename;

CmlSave(save_struct, 'local');































output_path = [cml_home '/scenarios' '/t_bersim' '/*'];
sys_cmd = ['rm' ' ' output_path];
try system(sys_cmd); catch end;


[sim_param sim_state] = ReadScenario('t_BerSim', 1);
JobParam = sim_param;
JobState = sim_state;



TaskParam.JobParam = JobParam;
TaskParam.JobState = JobState;
TaskParam.cml_home = cml_home;


TaskState = CmlWorker( TaskParam );
