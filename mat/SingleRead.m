function [sim_param_out, sim_state] = SingleRead( sim_param_in )
% CodedRead reads a single coded simulation from a file.
%
% The calling syntax is:
%     [sim_param, sim_state] = SingleRead( sim_param )
%
%     Required inputs/outputs:
%     sim_param = A structure containing simulation parameters.
%
%     Required output
%     sim_state = A structure containing the simulation state.
%
%     Note: See readme.txt for a description of the structure formats.
%
%     Copyright (C) 2005-2007, Matthew C. Valenti
%
%     Last updated on Oct. 12, 2007
%
%     Function SingleRead is part of the Iterative Solutions Coded Modulation
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

% the minimum SNR spacing
epsilon = 1e-5;

% define the structures
[sim_param_changeable, sim_param_unchangeable, sim_state_prototype] = DefineStructures;
sim_param_out = struct;
sim_state = struct;

% get a list of field names
sim_param_changeable_fieldnames = fieldnames( sim_param_changeable );
sim_param_unchangeable_fieldnames = fieldnames( sim_param_unchangeable );
sim_state_fieldnames = fieldnames( sim_state_prototype );

% variable used for determining if the SNR has changed
SNR_has_changed = 0;

if isfield( sim_param_in, 'SNR' )
    number_new_SNR_points = length( sim_param_in.SNR );
end

% make sure that number of trials and number SNR points are the same
if isfield( sim_param_in, 'max_trials' )
    if ( length( sim_param_in.max_trials ) ~= length( sim_param_in.SNR ) )
        error( 'number of trials must match number of SNR points' );
    end
end

% set the changeable parameters to the value in sim_param_in
for i=1:length( sim_param_changeable_fieldnames )        
    if isfield( sim_param_in, sim_param_changeable_fieldnames{i} )
        fieldvalue = getfield( sim_param_in, sim_param_changeable_fieldnames{i} );
        sim_param_out = setfield( sim_param_out, sim_param_changeable_fieldnames{i},  fieldvalue );
    else
        % if not defined, then set to default
        fieldvalue = getfield( sim_param_changeable, sim_param_changeable_fieldnames{i} ) ;
        sim_param_out = setfield( sim_param_out, sim_param_changeable_fieldnames{i}, fieldvalue );
    end
end

% determine where your root directory is (added 10-12-07)
load( 'CmlHome.mat' );

% determine if sim_param_in.filename is relative or absolute
if ( length( sim_param_in.filename ) >= length( cml_home ) )
    temp_string = sim_param_in.filename(1:length(cml_home));
    if strcmp( temp_string, cml_home )
        % this is an absolute path. strip out cml home
        sim_param_out.filename = sim_param_in.filename( length(cml_home)+1: length( sim_param_in.filename ) );
    end
end

% determine if a saved file exists
fid = fopen( [cml_home sim_param_out.filename], 'r');

% load the file unless the simulation has been reset
if ( (fid > 0)&( sim_param_out.reset < 1 ) )
    
    % load the saved file
    load( [cml_home sim_param_out.filename], '-mat' ); 
    
    % validate the unchangeable parameters
    for i=1:length( sim_param_unchangeable_fieldnames )        
        if isfield( save_param, sim_param_unchangeable_fieldnames{i} )
            
            % fprintf( ['\nValidating ' sim_param_unchangeable_fieldnames{i} '\n' ] );
            
            % see if field is specified in the input scenario
            if isfield( sim_param_in, sim_param_unchangeable_fieldnames{i} )                                                                               
                
                % test to see if stored is same.  Start with length
                test_length = abs( length( getfield( save_param, sim_param_unchangeable_fieldnames{i} ) ) - length( getfield( sim_param_in, sim_param_unchangeable_fieldnames{i} ) ) );
                test_value = 1;
                if ~test_length
                    % test value
                    test_value = sum( abs( getfield( save_param, sim_param_unchangeable_fieldnames{i} ) ) - abs( getfield( sim_param_in, sim_param_unchangeable_fieldnames{i} ) ) );
                end
                if test_value              
                    % they don't match, trigger a warning
                    % if set to [] in save file, should set it to the default value
                    if ~length( getfield( sim_param_in, sim_param_unchangeable_fieldnames{i} ) )
                        fprintf( ['Warning: Field "' sim_param_unchangeable_fieldnames{i} '" undefined in the scenario file, using default value\n' ] );  
                        save_param = setfield( save_param, sim_param_unchangeable_fieldnames{i}, getfield( sim_param_unchangeable, sim_param_unchangeable_fieldnames{i} ) );
                    elseif ~length( getfield( save_param, sim_param_unchangeable_fieldnames{i} ) )
                        fprintf( ['Warning: stored value of field ' sim_param_unchangeable_fieldnames{i} ' is set to [], using default value\n' ] );  
                        save_param = setfield( save_param, sim_param_unchangeable_fieldnames{i}, getfield( sim_param_unchangeable, sim_param_unchangeable_fieldnames{i} ) );
                    else
                        % otherwise use saved value
                        fprintf( ['Warning: field ' sim_param_unchangeable_fieldnames{i} ' does not match stored value, using stored value\n' ] );
                    end
                end
               
            else
                % fprintf( ['Warning: field ' sim_param_unchangeable_fieldnames{i} ' not defined in the scenario file, using stored value\n' ] );
            end
            
            % set the value to the saved value
            sim_param_out = setfield( sim_param_out, sim_param_unchangeable_fieldnames{i}, getfield( save_param, sim_param_unchangeable_fieldnames{i} ) );

        else
            % Set to default value when a new value is defined
            sim_param_out = setfield( sim_param_out, sim_param_unchangeable_fieldnames{i}, getfield( sim_param_unchangeable, sim_param_unchangeable_fieldnames{i} ) );
        end        
    end        
else
    % setup the "unchangeable" sim_param_out fields    
    for i=1:length( sim_param_unchangeable_fieldnames )
        % fprintf( ['\nValidating ' sim_param_unchangeable_fieldnames{i} '\n' ] );        
        % initialize to default value (Corrected on 9-8-07)
        sim_param_out = setfield( sim_param_out, sim_param_unchangeable_fieldnames{i}, getfield( sim_param_unchangeable, sim_param_unchangeable_fieldnames{i} ) );
        
        if isfield( sim_param_in, sim_param_unchangeable_fieldnames{i} )                        
            if ( length( getfield( sim_param_in, sim_param_unchangeable_fieldnames{i} ) ) )            
                % value is in the scenario file, so use it
                sim_param_out = setfield( sim_param_out, sim_param_unchangeable_fieldnames{i}, getfield( sim_param_in, sim_param_unchangeable_fieldnames{i} ) );
            end
        end
    end                       
end

% intialize sim_state
sim_state = sim_state_prototype;
    
% stuff that is specific to the simulation type
if ( strcmpi( sim_param_in.sim_type, 'capacity' ) )
    % capacity simulation
    sim_state.trials = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.capacity_sum = zeros( 1, number_new_SNR_points );
    sim_state.capacity_avg = sim_state.trials;
elseif ( strcmpi( sim_param_in.sim_type, 'exit' ) )
    error( 'EXIT curve generation is not yet supported' );
elseif ( strcmpi( sim_param_in.sim_type, 'uncoded' ) )
    % uncoded modulation
    sim_state.trials = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.frame_errors = zeros( 1, number_new_SNR_points );
    sim_state.symbol_errors = zeros( 1, number_new_SNR_points );
    sim_state.bit_errors = zeros( 1, number_new_SNR_points );
    sim_state.BER = sim_state.trials;
    sim_state.SER = sim_state.trials;
elseif ( strcmpi( sim_param_in.sim_type, 'coded' ) )
    % coded modulation
    sim_state.trials = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.frame_errors = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.bit_errors = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.BER = sim_state.trials;
    sim_state.FER = sim_state.trials;
elseif ( strcmpi( sim_param_in.sim_type, 'bloutage' ) )
    % coded modulation
    sim_state.trials = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.frame_errors = zeros( sim_param_out.max_iterations, number_new_SNR_points );
    sim_state.FER = sim_state.trials;
elseif ( strcmpi( sim_param_in.sim_type, 'outage' ) )
    % outage probability in block fading
    sim_state.trials = zeros( 1, number_new_SNR_points );
    sim_state.frame_errors = zeros( 1, number_new_SNR_points );
    sim_state.FER = sim_state.trials;
elseif ( strcmpi( sim_param_in.sim_type, 'throughput' ) )
    % throughput of hybrid-ARQ
    if ( (fid > 0)&( sim_param_out.reset < 1 ) )
        sim_param_out.SNR = save_param.SNR;
    end
elseif ( strcmpi( sim_param_in.sim_type, 'bwcapacity' ) )
    % Bandwidth constrained capacity
    if ( (fid > 0)&( sim_param_out.reset < 1 ) )
        sim_param_out.h = save_param.h;
    end
elseif ( strcmpi( sim_param_in.sim_type, 'minSNRvsB' ) )
    % Minimum SNR as a function of bandwidth constraint
    if ( (fid > 0)&( sim_param_out.reset < 1 ) )
        sim_param_out.h = save_param.h;
        sim_param_out.bwconstraint = save_param.bwconstraint;
    end
else
    error( 'simulation type not supported\n' );
end

% restore the saved sim_state
if ( (fid > 0)&( sim_param_out.reset < 1 ) )

    % determine if the SNR has changed
    if ~exist( 'number_new_SNR_points' )
        SNR_has_changed = 0;
    elseif ( length( save_param.SNR ) ~= number_new_SNR_points )
        SNR_has_changed = 1; % a different number of SNR points
    elseif max( save_param.SNR ~= sim_param_in.SNR )
        SNR_has_changed = 1; % different SNR points (but same number)
    end

    % will need to add or delete SNR points to the state
    if SNR_has_changed
        fprintf( 'Warning: SNR vector does not matched saved vector\n' );
    end
    
    % restore saved state, one structure element at a time
    for i=1:length( sim_state_fieldnames )
        if isfield( save_state, sim_state_fieldnames{i} )
            saved_vector = getfield( save_state, sim_state_fieldnames{i} );            
            if ( SNR_has_changed & ~isempty( saved_vector ) )
                % fix 6-11-06
                row_count = size( saved_vector, 1 );
                new_vector = zeros( row_count, number_new_SNR_points );
                
                % this logic needs to be verified 8-10-06
                for j=1:number_new_SNR_points
                    index = find( (save_param.SNR  <= sim_param_in.SNR(j) + epsilon)&(save_param.SNR >= sim_param_in.SNR(j)-epsilon) );
                    if (length( index ) > 1)
                        error( 'Duplicate SNR points in saved sim' );
                    elseif (length(index) == 1)
                        new_vector(:,j) = saved_vector(:,index);
                    end
                end
                sim_state = setfield( sim_state, sim_state_fieldnames{i}, new_vector);
            else
                sim_state = setfield( sim_state, sim_state_fieldnames{i}, saved_vector );
            end
        end
    end

end

% alphabetize fields
sim_param_out = orderfields( sim_param_out );
sim_state = orderfields( sim_state );

if (fid>0)
    fclose( fid );
end

return;    







  
    
