% print the list of scenarios and records running using cluster cml
% Input
%  'running' - inspect running queue
%  'output'  - inspect output queue

function scenario_listing = PrintScenarioStatus(queue)

[project_root] = CmlReadProjectRoot();

switch queue,
    case 'running'
        queue_dir = [project_root '/' 'JobRunning']
    case 'output'
        queue_dir = [project_root '/' 'JobOut']
    otherwise
        error('queue dir must be ''running'' or ''output''');
end



listing = GetDirectoryListing( queue_dir );
N = size( listing );

switch queue,
    case 'running'
        scenario_listing = sprintf('Running scenarios:\n');
    case 'output'
        scenario_listing = sprintf('Completed scenarios:\n');
end

for k = 1:N,
    [scenario_name record] = ReadScenarioNameAndRecord( listing(k).name );
    
cur_scenario = sprintf([scenario_name ' ' int2str(record) '\n']);
    
    scenario_listing = [scenario_listing cur_scenario];
end

end
