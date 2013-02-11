
% read scenario name and record as strings
function [scenario_name record] = ReadScenarioNameAndRecord( name_record )
[scenario_name suffix] = strtok( name_record, '_' );
record = str2double( suffix(1:end-4) );

flipped_name_record = name_record(end:-1:1);
[rec_flip scen_flip] = strtok( flipped_name_record, '_' );


scenario_name = scen_flip( end : -1 : 1+1 );

rec_flipped_back = rec_flip(end:-1:1);
record = str2double( strtok(rec_flipped_back, '.') );
end
