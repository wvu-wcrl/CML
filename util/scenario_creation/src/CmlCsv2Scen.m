% CmlCsv2Scen.m
% CmlCsv2Scen converts CSV files describing CML scenarios to
%  .m files for execution.
%
%   Place CSV files in <CMLROOT>/util/scenario_creation/csv
%
% The calling syntax is:
%     CmlCsv2Scen([scenario_csv_file])
%
%     Inputs
%       Optional
%         scenario_csv_file   CSV file describing CML scenario
%       
%         Providing no input argument processes all .csv files in
%          <CMLROOT>/util/scenario_creation/csv
%
%     Output
%       Scenario file placed in <CMLROOT>/localscenarios
%
%
%
%     Example:
%       - User creates <CMLROOT>/util/scenario_creation/csv/fsk_uncoded.csv
%
%        >> CmlCsv2Scen('fsk_uncoded.csv');
%
%
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on August 12/03/2012.
function CmlCsv2Scen(varargin)

cml_home = CmlLoadCmlHome('local');

num_input_args = nargin;
[csv_path csv_files] = read_input( cml_home, num_input_args, varargin );

conv_path = set_path_to_conversion_script( cml_home );

localscen_path = set_path_to_localscenarios( cml_home );

convert_csv_and_copy_to_localscenarios( conv_path, csv_path,...
    localscen_path, csv_files );


end


function [csv_path csv_files] = read_input( cml_home, num_input_args, varargin )


if num_input_args == 0,
    csv_path = [cml_home filesep 'util' filesep 'scenario_creation' ...
        filesep 'csv'];
    
    csv_file_struct = dir([csv_path filesep '*.csv']);
    
    num_csv_files = length(csv_file_struct);
    
    % form cell array of paths
    for k = 1:num_csv_files,
        csv_files{k} = csv_file_struct(k).name;
    end
    
elseif num_input_args == 1,
    csv_path = [cml_home filesep 'util' filesep 'scenario_creation' ...
        filesep 'csv'];
    csv_files{1} = varargin{1}{1};
else
    error('Exactly 0 or 1 input arguments required.');
end

end



function conv_path = set_path_to_conversion_script( cml_home )
conv_path = [cml_home filesep 'util' filesep 'scenario_creation' ...
    filesep 'src' filesep 'csv2cml'];
end


function localscen_path = set_path_to_localscenarios( cml_home )
localscen_path = [cml_home filesep 'localscenarios'];
end


function convert_csv_and_copy_to_localscenarios( conv_path, csv_path,...
    localscen_path, csv_files )

num_csv_files = length(csv_files);

for k = 1:num_csv_files
    % execute python script to convert to .m
    cmd = [conv_path ' ' csv_path filesep csv_files{k} ' ' localscen_path];
    system(cmd);
end

end


%     Function CmlCsv2Scen is part of the Iterative Solutions Coded Modulation
%     Library (ISCML).
%
%     The Iterative Solutions Coded Modulation Library is free software;
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
