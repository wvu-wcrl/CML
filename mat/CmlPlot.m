function [sim_param, sim_state] = CmlPlot( varargin )
% CmlPlot plots simulation results
%
% The calling syntax is:
%     [sim_param, sim_state] = CmlPlot( scenario_filename, cases )
%
%     Outputs:
%     sim_param = A structure containing simulation parameters.
%     sim_state = A structure containing the simulation state.
%     Note: See readme.txt for a description of the structure formats.
%
%     Required inputs:
%	  scenario_filename = the name of the file containing an array of sim_param structures.
%     cases = a list of the array indices to plot.
%
%     Note: Multiple scenario files can be specified.  In this case, the argument list
%     should contain each scenario file to be used followed by the list of array indices
%     to read from that file.
%     
%     Example:
%     [sim_param, sim_state] = CmlPlot( 'Scenario1', [1 2 5], 'Scenario2', [1 4 6] );
%
%     Copyright (C) 2005-2006, Matthew C. Valenti
%
%     Last updated on June 4, 2006
%
%     Function CmlPlot is part of the Iterative Solutions Coded Modulation
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

% setup structures are retrieve data
% give an extra argument to force sim_param.reset = 0
[sim_param, sim_state] = ReadScenario( varargin{:}, [] );
number_cases = length( sim_param );

% determine the simulation types
sim_types = zeros( 8, number_cases );
for ( case_number=1:number_cases )
    if ( strcmp( sim_param(case_number).sim_type, 'capacity' ) )        
        sim_types(1,case_number) = 1; % capacity simulation
    elseif ( strcmp( sim_param(case_number).sim_type, 'exit' ) )
        sim_types(2,case_number) = 1; % EXIT
    elseif ( strcmp( sim_param(case_number).sim_type, 'uncoded' ) )
        sim_types(3,case_number) = 1; % uncoded modulation
    elseif ( strcmp( sim_param(case_number).sim_type, 'coded' ) )
        sim_types(4,case_number) = 1; % coded modulation
    elseif ( strcmpi( sim_param(case_number).sim_type, 'outage' )|strcmpi( sim_param(case_number).sim_type, 'bloutage' ) )
        sim_types(5,case_number) = 1; % outage probability
    elseif ( strcmp( sim_param(case_number).sim_type, 'throughput' ) )
        sim_types(6,case_number) = 1; % throughput of hybrid-ARQ
    elseif ( strcmp( sim_param(case_number).sim_type, 'bwcapacity' ) )
        sim_types(7,case_number) = 1; % capacity of FSK under BW constraint
    elseif ( strcmp( sim_param(case_number).sim_type, 'minSNRvsB' ) )
        sim_types(8,case_number) = 1; % Min SNR as a function of B
    end
end

fig_number = 0;

% first plot capacity vs. Eb/No and Es/No, if there are any capacity curves requested
if ( sum( sim_types(1,:) ) )
    fig_number = fig_number + 1;
    figure( fig_number );    
    
    for (i=find( sim_types(1,:) == 1 ) )
        EsNo = 10.^(sim_param(i).SNR/10); % assume SNR is Es/No in dB
        EbNo = EsNo./(sim_state(i).capacity_avg*log2(sim_param(i).mod_order));
        EbNodB = 10*log10( EbNo );
        plot( EbNodB, log2(sim_param(i).mod_order)*sim_state(i).capacity_avg, sim_param(i).linetype );        
        hold on;
    end 
    
    % compute unconstrained (Gaussian input) capacity
    EsNodB = sim_param(i).SNR;
    EsNo = 10.^(EsNodB/10);    
    cap_unconstrained = log2(1+EsNo);
    EbNo = EsNo./cap_unconstrained;
    EbNodB = 10*log10( EbNo );
    legend( sim_param( find( sim_types(1,:) == 1 ) ).legend ); 
    
    % uncomment if you want to show unconstrained 
    % plot( EbNodB, cap_unconstrained, '-.');    
    % legend( sim_param( find( sim_types(1,:) == 1 ) ).legend, 'Unconstrained', 2 ); 
    xlabel( 'Eb/No in dB' );
    ylabel( 'Capacity' );
    hold off;       
    
    % Eb/No vs. Capacity (useful for FSK modulation)
    fig_number = fig_number + 1;
    figure( fig_number );    
    
    for (i=find( sim_types(1,:) == 1 ) )
        EsNo = 10.^(sim_param(i).SNR/10); % assume SNR is Es/No in dB
        EbNo = EsNo./(sim_state(i).capacity_avg*log2(sim_param(i).mod_order));
        EbNodB = 10*log10( EbNo );      
        plot( sim_state(i).capacity_avg, EbNodB, sim_param(i).linetype ); 
        hold on;
    end 
    
    ylabel( 'Eb/No in dB' );
    xlabel( 'Rate' );
    hold off;  
   
    % plot capacity vs. Es/No
    fig_number = fig_number + 1;
    figure( fig_number );
    for (i=find( sim_types(1,:) == 1 ) )
        plot( sim_param(i).SNR, log2(sim_param(i).mod_order)*sim_state(i).capacity_avg, sim_param(i).linetype );      
        hold on;
    end 
    
    legend( sim_param( find( sim_types(1,:) == 1 ) ).legend );
    
    % uncomment if you want to show unconstrained 
    % plot( EsNodB, cap_unconstrained, '-.');    
    % legend( sim_param( find( sim_types(1,:) == 1 ) ).legend, 'Unconstrained', 2 );
    
    xlabel( 'Es/No in dB' );
    ylabel( 'Capacity' );
    hold off;  
end

% next plot BER vs. Eb/No if this is a coded or uncoded simulation
if ( sum( sum( sim_types(3:4,:) ) ) )
    % plot BER vs. Eb/No
    fig_number = fig_number + 1;
    figure( fig_number );
    
    % BER of uncoded modulation
    for (i=find( sim_types(3,:) == 1 ) )
        
        % Can only plot against Eb/No (add logic later)
        if ( sim_param(i).SNR_type(2) ~= 'b' )
            error( 'Uncoded modulation results must use SNR_type of Eb/No in dB' );
        end
        
        figure( fig_number );
        semilogy( sim_param(i).SNR, sim_state(i).BER, sim_param(i).linetype );      
        hold on;
    end   
    
    % BER of coded modulation
    for (i=find( sim_types(4,:) == 1 ) )
        % Convert to Eb/No (dB) if stored as Es/No (dB)
        if ( sim_param(i).SNR_type(2) ~= 'b' )
            % This is Es/No
            EsNodB = sim_param(i).SNR;
            % Convert to Eb/No
            EsNo = 10.^(EsNodB/10);
            EbNo = EsNo./sim_param(i).rate;
            EbNodB = 10*log10(EbNo);
        else
            EbNodB = sim_param(i).SNR;            
        end
        % only plot the last iteration
        if ( length( sim_param(i).max_iterations ) )
            max_iter = sim_param(i).max_iterations;
        else
            max_iter = 1;
        end
        
        semilogy( EbNodB, sim_state(i).BER( max_iter, : ), sim_param(i).linetype );      
        hold on;
    end       
    
    legend( sim_param( find( sim_types(3,:) == 1 ) ).legend, sim_param( find( sim_types(4,:) == 1 ) ).legend, 0 ); 
    xlabel( 'Eb/No in dB' );
    ylabel( 'BER' );    
    
    for (i=find( sim_types(4,:) == 1 ) )
        if ( length( sim_param(i).plot_iterations ) )
            % Convert to Eb/No (dB) if stored as Es/No (dB)
            if ( sim_param(i).SNR_type(2) ~= 'b' )
                % This is Es/No
                EsNodB = sim_param(i).SNR;
                % Convert to Eb/No
                EsNo = 10.^(EsNodB/10);
                EbNo = EsNo./sim_param(i).rate;
                EbNodB = 10*log10(EbNo);
            else
                EbNodB = sim_param(i).SNR;            
            end
            % plot the other iterations
            semilogy( EbNodB, sim_state(i).BER(sim_param(i).plot_iterations,:), sim_param(i).linetype );
        end     
    end
    
    hold off;   

    % Now plot against Es/No, if uncoded
    if sum( sim_types(4,:) )    
        fig_number = fig_number + 1;
        figure( fig_number ); 

        for (i=find( sim_types(4,:) == 1 ) )      
            
            % see if Es/No is defind, otherwise derive       
            if ( sim_param(i).SNR_type(2) == 'b' )
                % This is Eb/No
                EbNodB = sim_param(i).SNR;
                % Convert to Es/No
                EbNo = 10.^(EbNodB/10);
                EsNo = sim_param(i).rate*EbNo;
                EsNodB = 10*log10(EsNo);
            else
                % This is already in Es/No
                EsNodB = sim_param(i).SNR;
            end
            
            % only plot the last iteration
            if ( length( sim_param(i).max_iterations ) )
                max_iter = sim_param(i).max_iterations;
            else
                max_iter = 1;
            end            
            
            % Plot FER versus Es/No in dB
            figure( fig_number );
            semilogy( EsNodB, sim_state(i).BER( max_iter, : ), sim_param(i).linetype );             
            hold on;           
        end       
        
        figure( fig_number );
        legend( sim_param( find( sim_types(4,:) == 1 ) ).legend, 0 ); 
        xlabel( 'Es/No in dB' );
        ylabel( 'BER' );    
        
        for (i=find( sim_types(4,:) == 1 ) )
            if ( length( sim_param(i).plot_iterations ) )
                % see if Es/No is defind, otherwise derive          
                if ( sim_param(i).SNR_type(2) == 'b' )
                    % This is Eb/No
                    EbNodB = sim_param(i).SNR;
                    % Convert to Es/No
                    EbNo = 10.^(EbNodB/10);
                    EsNo = sim_param(i).rate*EbNo;
                    EsNodB = 10*log10(EsNo);
                else
                    % This is Es/No
                    EsNodB = sim_param(i).SNR;
                    % Convert to Eb/No
                    EsNo = 10.^(EsNodB/10);
                    EbNo = EsNo./sim_param(i).rate;
                    EbNodB = 10*log10(EbNo);
                end
                
                % plot the other iterations
                figure( fig_number );
                semilogy( EsNodB, sim_state(i).BER(sim_param(i).plot_iterations,:), sim_param(i).linetype );          
            end     
        end
        
        figure( fig_number );
        hold off;
    end
    
end

% Plot the SER if uncoded
if ( sum( sum( sim_types(3,:) ) ) )
    % plot SER vs. Eb/No
    fig_number = fig_number + 1;
    figure( fig_number );
    
    % SER of uncoded modulation
    for (i=find( sim_types(3,:) == 1 ) )
        % Convert to Eb/No (dB) if stored as Es/No (dB)
        if ( sim_param(i).SNR_type(2) ~= 'b' )
            error( 'The SNR should be stored as Eb/No' );
        end
        semilogy( sim_param(i).SNR, sim_state(i).SER, sim_param(i).linetype );      
        hold on;
    end       
    
    legend( sim_param( find( sim_types(3,:) == 1 ) ).legend, 0 ); 
    xlabel( 'Eb/No in dB' );
    ylabel( 'SER' );        
    
    hold off;   
end

% Plot the FER of coded and outage simulations
if ( sum( sum( sim_types(4:5,:) ) ) )
    
    % First plot FER vs. Eb/No
    fig_number = fig_number + 1;
    figure( fig_number );
    
    % Outage Probability
    for (i=find( sim_types(5,:) == 1 ) )
        % If stored as Es/No, convert to Eb/No       
        if ( sim_param(i).SNR_type(2) == 'b' )
            % This is Eb/No
            EbNodB = sim_param(i).SNR;
        else
            % This is stored as Es/No
            EsNodB = sim_param(i).SNR;
            % Convert to Eb/No
            EsNo = 10.^(EsNodB/10);
            EbNo = EsNo./sim_param(i).rate;
            EbNodB = 10*log10(EbNo);
        end            
        
        % Plot FER versus Eb/No in dB
        figure( fig_number );
        semilogy( EbNodB, sim_state(i).FER, sim_param(i).linetype );             
        hold on;
    end   
    
    % FER of coded modulation
    for (i=find( sim_types(4,:) == 1 ) )
        % If stored as Es/No, convert to Eb/No       
        if ( sim_param(i).SNR_type(2) == 'b' )
            % This is Eb/No
            EbNodB = sim_param(i).SNR;
        else
            % This is stored as Es/No
            EsNodB = sim_param(i).SNR;
            % Convert to Eb/No
            EsNo = 10.^(EsNodB/10);
            EbNo = EsNo./sim_param(i).rate;
            EbNodB = 10*log10(EbNo);
        end
        
        % only plot the last iteration
        if ( length( sim_param(i).max_iterations ) )
            max_iter = sim_param(i).max_iterations;
        else
            max_iter = 1;
        end        
        
        % Plot FER versus Eb/No in dB
        figure( fig_number );
        semilogy( EbNodB, sim_state(i).FER( max_iter, : ), sim_param(i).linetype );             
        hold on;
    end           

    figure( fig_number );
    legend( sim_param( find( sim_types(5,:) == 1 ) ).legend, sim_param( find( sim_types(4,:) == 1 ) ).legend, 0 ); 
    xlabel( 'Eb/No in dB' );
    ylabel( 'FER' ); 
    
    % Now plot the other iterations
    for (i=find( sim_types(4,:) == 1 ) )
        if ( length( sim_param(i).plot_iterations ) )
            % make sure that we get both Es/No and Eb/No        
            if ( sim_param(i).SNR_type(2) == 'b' )
                % This is Eb/No
                EbNodB = sim_param(i).SNR;
            else
                % This is stored as Es/No
                EsNodB = sim_param(i).SNR;
                % Convert to Eb/No
                EsNo = 10.^(EsNodB/10);
                EbNo = EsNo./sim_param(i).rate;
                EbNodB = 10*log10(EbNo);
            end
            
            % plot the other iterations            
            figure( fig_number );
            semilogy( EbNodB, sim_state(i).FER(sim_param(i).plot_iterations,:), sim_param(i).linetype );            
        end     
    end   
  
    figure( fig_number );
    hold off;    
    
    % plot FER vs. Es/No        
    fig_number = fig_number + 1;
    figure( fig_number );
    
    % Outage Probability
    for (i=find( sim_types(5,:) == 1 ) )
        % If stored as Eb/No, convert to Es/No      
        if ( sim_param(i).SNR_type(2) == 'b' )
            % This is Eb/No
            EbNodB = sim_param(i).SNR;
            % Convert to Es/No
            EbNo = 10.^(EbNodB/10);
            EsNo = sim_param(i).rate*EbNo;
            EsNodB = 10*log10(EsNo);
        else
            % This is Es/No
            EsNodB = sim_param(i).SNR;
        end
        % Plot FER versus Es/No in dB
        figure( fig_number );
        semilogy( EsNodB, sim_state(i).FER, sim_param(i).linetype );             
        hold on;
    end   
    
    % FER of coded modulation
    for (i=find( sim_types(4,:) == 1 ) )
        % If stored as Eb/No, convert to Es/No      
        if ( sim_param(i).SNR_type(2) == 'b' )
            % This is Eb/No
            EbNodB = sim_param(i).SNR;
            % Convert to Es/No
            EbNo = 10.^(EbNodB/10);
            EsNo = sim_param(i).rate*EbNo;
            EsNodB = 10*log10(EsNo);
        else
            % This is Es/No
            EsNodB = sim_param(i).SNR;
        end
        
        % only plot the last iteration
        if ( length( sim_param(i).max_iterations ) )
            max_iter = sim_param(i).max_iterations;
        else
            max_iter = 1;
        end        
        
        % Plot FER versus Es/No in dB
        figure( fig_number );
        semilogy( EsNodB, sim_state(i).FER( max_iter, : ), sim_param(i).linetype );             
        hold on;
    end           

    figure( fig_number );
    legend( sim_param( find( sim_types(5,:) == 1 ) ).legend, sim_param( find( sim_types(4,:) == 1 ) ).legend, 0 ); 
    xlabel( 'Es/No in dB' );
    ylabel( 'FER' ); 
    
    % Now plot the other iterations
    for (i=find( sim_types(4,:) == 1 ) )
        if ( length( sim_param(i).plot_iterations ) )
            % If stored as Eb/No, convert to Es/No      
            if ( sim_param(i).SNR_type(2) == 'b' )
                % This is Eb/No
                EbNodB = sim_param(i).SNR;
                % Convert to Es/No
                EbNo = 10.^(EbNodB/10);
                EsNo = sim_param(i).rate*EbNo;
                EsNodB = 10*log10(EsNo);
            else
                % This is Es/No
                EsNodB = sim_param(i).SNR;
            end
            % plot the other iterations            
            figure( fig_number );
            semilogy( EsNodB, sim_state(i).FER(sim_param(i).plot_iterations,:), sim_param(i).linetype );            
        end     
    end   
  
    figure( fig_number );
    hold off;    
    
end
        
% plot throughput vs. Es/No, if there are any throughput curves requested
if ( sum( sim_types(6,:) ) )
    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot throughput vs. Es/No
    for (i=find( sim_types(6,:) == 1 ) )
        plot( sim_param(i).SNR, sim_state(i).throughput, sim_param(i).linetype );      
        hold on;
    end     
    
    legend( sim_param( find( sim_types(6,:) == 1 ) ).legend, 2 ); 
    xlabel( 'Es/No in dB' );
    ylabel( 'Normalized throughput' );
    hold off;  
end


% plot min Eb/No vs. h for nonorthogonal FSK under BW constraints.
if ( sum( sim_types(7,:) ) )
    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot min Eb/No vs. h
    for (i=find( sim_types(7,:) == 1 ) )
        [Y,I] = sort( sim_param(i).h );
        plot( sim_param(i).h(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );   
        hold on;
    end     
    
    legend( sim_param( find( sim_types(7,:) == 1 ) ).legend, 2 ); 
    xlabel( 'h' );
    ylabel( 'min Eb/No (in dB)' );
    hold off;  

    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot min Eb/No vs. rate
    for (i=find( sim_types(7,:) == 1 ) )
        [Y,I] = sort( sim_state(i).best_rate );
        plot( sim_state(i).best_rate(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );   
        hold on;
    end     
    
    legend( sim_param( find( sim_types(7,:) == 1 ) ).legend, 2 ); 
    xlabel( 'code rate r' );
    ylabel( 'min Eb/No (in dB)' );
    hold off;  

end

% plot min Eb/No vs. B for nonorthogonal FSK under BW constraint B.
if ( sum( sim_types(8,:) ) )
    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot min Eb/No vs. B
    for (i=find( sim_types(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );   
        hold on;
    end     
    
    legend( sim_param( find( sim_types(8,:) == 1 ) ).legend, 2 ); 
    xlabel( 'Bandwidth B' );
    ylabel( 'min Eb/No (in dB)' );
    hold off; 
    
    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot eta vs. min Eb/No
    for (i=find( sim_types(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        % plot( sim_state(i).min_EbNodB(I), 1./sim_param(i).bwconstraint(I), sim_param(i).linetype );   
        plot( 1./sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype ); 
        hold on;
    end     
    
    legend( sim_param( find( sim_types(8,:) == 1 ) ).legend, 2 ); 
    % ylabel( '\eta' );
    % xlabel( 'minimum Eb/No in dB' );
    xlabel( '\eta in bps/Hz' );
    ylabel( 'Minimum Eb/No in dB' );
    hold off; 
    
    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot optimal h vs. B
    for (i=find( sim_types(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_param(i).h(I), sim_param(i).linetype );   
        hold on;
    end   
    
    legend( sim_param( find( sim_types(8,:) == 1 ) ).legend, 2 ); 
    xlabel( 'Bandwidth B' );
    ylabel( 'optimal h' );
    hold off;  

    fig_number = fig_number + 1;
    figure( fig_number );    

    % plot optimal rate vs. B
    for (i=find( sim_types(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_state(i).best_rate(I), sim_param(i).linetype );   
        hold on;
    end   
    
    legend( sim_param( find( sim_types(8,:) == 1 ) ).legend, 2 ); 
    xlabel( 'Bandwidth B' );
    ylabel( 'optimal rate' );
    hold off;  
    
end