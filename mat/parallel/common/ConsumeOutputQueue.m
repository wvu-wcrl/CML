function ConsumeOutputQueue( output_queue, listing )
N = size( listing );
for k = 1:N,
    [scenario_name record] = ReadScenarioNameAndRecord( listing(k).name );
    full_path_to_output_file = [ output_queue filesep listing(k).name ];
    MoveJobOutToCmlOut( full_path_to_output_file, scenario_name, record);
end
end
