% ReadScenarioNameAndRecord.m
%  Read scenario name and record from underscore delimited string
%
% Inputs
%  name_record        underscore delimited string containing scenarion and
%                      record
%
%  Example
%    name_record = 'FskScenarios_1'
%    -scenario_name becomes 'FskScenarios'
%    -record becomes '1'
%
%
%     Last updated on 2/11/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.


% read scenario name and record from underscore delimited string
function [scenario_name record] = ReadScenarioNameAndRecord( name_record )
[scenario_name suffix] = strtok( name_record, '_' );
record = str2double( suffix(1:end-4) );

flipped_name_record = name_record(end:-1:1);
[rec_flip scen_flip] = strtok( flipped_name_record, '_' );

scenario_name = scen_flip( end : -1 : 1+1 );

rec_flipped_back = rec_flip(end:-1:1);
record = str2double( strtok(rec_flipped_back, '.') );
end

%     This library is free software;
%     you can redistribute it and/or modify it under the terms of
%     the GNU Lesser General Public License as published by the
%     Free Software Foundation; either version 2.1 of the License,
%     or (at your option) any later version.
%
%     This library is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%     Lesser General Public License for more details.
%
%     You should have received a copy of the GNU Lesser General Public
%     License along with this library; if not, write to the Free Software
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
