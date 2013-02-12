function [sim_param, sim_state, varargout] = CmlPlot( varargin )
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

% add exit plotting
% accept snr point as input

% setup structures are retrieve data
% give an extra argument to force sim_param.reset = 0
[sim_param, sim_state] = ReadScenario( varargin{:}, [] );
number_cases = length( sim_param );


% determine the simulation type


% determine the simulation types
SimTypes = DetermineSimTypePerRecord(sim_param);


fig_number = 0;
FigHandle = [];

% First, plot capacity vs. Eb/No and Es/No, if there are any capacity curves requested.
if( sum( SimTypes(1,:) ) )
    [FigHandle, fig_number] = PlotCapacityCurves(sim_param( SimTypes(1,:) == 1 ), sim_state( SimTypes(1,:) == 1 ), FigHandle, fig_number);
end


% Plot exit curves, if there are any exit curves requested.
if ( sum( SimTypes(2,:) ) )
    % get snr point
    [ return_data_or_plot ] = process_exit_input(varargin, sim_param, number_cases);
    
    if strcmp( return_data_or_plot, 'plot')
        
        [snrpoint snr_ind] = get_snr_point( varargin, sim_param );
        
        for i=find( SimTypes(2,:) == 1 )
            fig_number = fig_number + 1;
            clf;  %%% added 12/15/2012.
            FigHandle = [FigHandle figure( fig_number )];
            
            plot( sim_param(i).exit_param.requested_IA, sim_state(i).exit_state.IE_vnd(:,snr_ind), 'k-' );
            hold on
            plot( sim_param(i).exit_param.requested_IA, sim_state(i).exit_state.IA_cnd(:,snr_ind), 'r--' );
            hold off
            
            xlabel('I_{A,VND}, I_{E,CND}');
            ylabel('I_{E,VND}, I_{E,CND}');
            legend('VND', 'CND');
            
            annotate_exit_params( sim_param(i), snr_ind );
            
        end
        
    end
end


% next plot BER vs. Eb/N0 for coded or uncoded simulations, AND BER vs. Es/N0 for coded simulations.
% AND SER vs. Eb/N0 for uncoded simulations.
if ( sum( sum( SimTypes(3:4,:) ) ) )
    sim_param_uncoded = sim_param(SimTypes(3,:) == 1);
    sim_state_uncoded = sim_state(SimTypes(3,:) == 1);
    sim_param_coded = sim_param(SimTypes(4,:) == 1);
    sim_state_coded = sim_state(SimTypes(4,:) == 1);
    [FigHandle, fig_number] = PlotBerSerCodedUncoded( ...
        sim_param_uncoded, sim_state_uncoded, sim_param_coded, sim_state_coded, FigHandle, fig_number);
end


% Plot the FER of coded and outage simulations.
if ( sum( sum( SimTypes(4:5,:) ) ) )
    sim_param_coded = sim_param(SimTypes(4,:) == 1);
    sim_state_coded = sim_state(SimTypes(4,:) == 1);
    sim_param_outage = sim_param(SimTypes(5,:) == 1);
    sim_state_outage = sim_state(SimTypes(5,:) == 1);
    
    [FigHandle, fig_number] = PlotFerCodedOutage( ...
        sim_param_coded, sim_state_coded, sim_param_outage, sim_state_outage, FigHandle, fig_number);
end


% Plot throughput vs. Es/N0, if there are any throughput curves requested.
if ( sum( SimTypes(6,:) ) )
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot throughput vs. Es/N0.
    for (i=find( SimTypes(6,:) == 1 ) )
        plot( sim_param(i).SNR, sim_state(i).throughput, sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(6,:) == 1 ) ).legend, 2 );
    xlabel( 'Es/N0 in dB' );
    ylabel( 'Normalized Throughput' );
    hold off
end


% ebn0 vs h:
% plot min Eb/N0 vs. h and min Eb/N0 vs. rate for nonorthogonal FSK under BW constraints B.
if ( sum( SimTypes(7,:) ) )
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot min Eb/N0 vs. h.
    for i=find( SimTypes(7,:) == 1 )
        [Y,I] = sort( sim_param(i).h );
        plot( sim_param(i).h(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(7,:) == 1 ) ).legend, 2 );
    xlabel( 'h' );
    ylabel( 'min Eb/N0 (in dB)' );
    hold off
    
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot min Eb/N0 vs. rate.
    for (i=find( SimTypes(7,:) == 1 ) )
        [Y,I] = sort( sim_state(i).best_rate );
        plot( sim_state(i).best_rate(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(7,:) == 1 ) ).legend, 2 );
    xlabel( 'Code Rate (R)' );
    ylabel( 'min Eb/N0 (in dB)' );
    hold off
end


% plot min Eb/N0 vs. B, eta vs. min Eb/N0, optimal h vs. B, optimal rate vs. B for nonorthogonal FSK under BW constraint B.
if ( sum( SimTypes(8,:) ) )
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot min Eb/N0 vs. B.
    for i=find( SimTypes(8,:) == 1 )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(8,:) == 1 ) ).legend, 2 );
    xlabel( 'Bandwidth (B)' );
    ylabel( 'min Eb/N0 (in dB)' );
    hold off
    
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot eta vs. min Eb/N0.
    for i=find( SimTypes(8,:) == 1 )
        [Y,I] = sort( sim_param(i).bwconstraint );
        % plot( sim_state(i).min_EbNodB(I), 1./sim_param(i).bwconstraint(I), sim_param(i).linetype );
        plot( 1./sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(8,:) == 1 ) ).legend, 2 );
    % ylabel( '\eta' );
    % xlabel( 'minimum Eb/N0 in dB' );
    xlabel( '\eta in bps/Hz' );
    ylabel( 'Minimum Eb/N0 in dB' );
    hold off
    
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot optimal h vs. B.
    for (i=find( SimTypes(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_param(i).h(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(8,:) == 1 ) ).legend, 2 );
    xlabel( 'Bandwidth (B)' );
    ylabel( 'Optimal h' );
    hold off
    
    fig_number = fig_number + 1;
    FigHandle = [FigHandle figure( fig_number )];
    
    % plot optimal rate vs. B.
    for (i=find( SimTypes(8,:) == 1 ) )
        [Y,I] = sort( sim_param(i).bwconstraint );
        plot( sim_param(i).bwconstraint(I), sim_state(i).best_rate(I), sim_param(i).linetype );
        hold on
    end
    
    legend( sim_param( find( SimTypes(8,:) == 1 ) ).legend, 2 );
    xlabel( 'Bandwidth (B)' );
    ylabel( 'Optimal rate' );
    hold off
end

varargout{1} = FigHandle;

end



function annotate_exit_params(sim_param, snr_ind)

snr_str = ['E_b/N_0 = ' num2str(sim_param.SNR(snr_ind)) ' dB'];
dv_st = ['d_v = ' int2str(sim_param.exit_param.dv)];
dc_st = ['d_c = ' int2str(sim_param.exit_param.dc)];
rate_st = ['r = ' num2str(sim_param.exit_param.rate)];

cell_str = {snr_str, dv_st, dc_st, rate_st};

a = annotation('textbox',[0.70 0.2 0.2 0.2]);
set(a, 'String', cell_str)
set(a, 'FontSize', 10)
set(a, 'LineStyle', 'none')

end



function [snrpoint snr_ind] = get_snr_point( varargin, sim_param )
snrpoint = varargin{3};
snr_ind = get_snr_ind( sim_param, snrpoint );
end



function [return_data_or_plot] = process_exit_input(varargin, sim_param, number_cases)

if length(varargin) > 3
    error('Too many input arguments');
end

if length(varargin) == 3
    
    return_data_or_plot = 'plot';
    
    snrpoint = varargin{3};
    
    if length(snrpoint) > 1
        error('Please supply a single SNR point.');
    end
    
    snr_ind = get_snr_ind( sim_param, snrpoint);
    
    if isempty( snr_ind )
        error(['SNR point ' num2str(snrpoint) ' dB not found.']);
    end
    
end

if length(varargin) == 2
    return_data_or_plot = 'return_data';
end

if number_cases > 1
    error('Please specify a single EXIT record.');
end

end



function snr_ind = get_snr_ind( sim_param, snrpoint )
snr_diff = abs(sim_param.SNR - snrpoint) < 10^(-3);
snr_ind = find( snr_diff );
end



function SimTypes = DetermineSimTypePerRecord(sim_param)

number_cases = length( sim_param );

SimTypes = zeros( 8, number_cases );

for case_number=1:number_cases
    if strcmp( sim_param(case_number).sim_type, 'capacity' )
        SimTypes(1,case_number) = 1; % capacity simulation
    elseif strcmp( sim_param(case_number).sim_type, 'exit' )
        SimTypes(2,case_number) = 1; % EXIT
    elseif strcmp( sim_param(case_number).sim_type, 'uncoded' )
        SimTypes(3,case_number) = 1; % uncoded modulation
    elseif strcmp( sim_param(case_number).sim_type, 'coded' )
        SimTypes(4,case_number) = 1; % coded modulation
    elseif( strcmpi( sim_param(case_number).sim_type, 'outage' ) || strcmpi( sim_param(case_number).sim_type, 'bloutage' ) )
        SimTypes(5,case_number) = 1; % outage probability
    elseif strcmp( sim_param(case_number).sim_type, 'throughput' )
        SimTypes(6,case_number) = 1; % throughput of hybrid-ARQ
    elseif strcmp( sim_param(case_number).sim_type, 'bwcapacity' )
        SimTypes(7,case_number) = 1; % capacity of FSK under BW constraint
    elseif strcmp( sim_param(case_number).sim_type, 'minSNRvsB' )
        SimTypes(8,case_number) = 1; % Min SNR as a function of B
    end
end

end



function [FigHandle, FigNumber] = PlotCapacityCurves(sim_param, sim_state, FigHandle, FigNumber)
% Plot capacity vs. Eb/N0 and Es/N0, and Eb/N0 vs. capacity (useful for FSK modulation).

% plot Capacity vs. Eb/N0.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    EsN0 = 10.^(sim_param(i).SNR/10); % assume SNR is Es/N0 in dB
    EbN0 = EsN0./(sim_state(i).capacity_avg*log2(sim_param(i).mod_order));
    EbN0dB = 10*log10( EbN0 );
    plot( EbN0dB, log2(sim_param(i).mod_order)*sim_state(i).capacity_avg, sim_param(i).linetype );
    hold on
end

legend( sim_param.legend );

% compute unconstrained (Gaussian input) capacity.
EsN0dB = sim_param(i).SNR;
EsN0 = 10.^(EsN0dB/10);
cap_unconstrained = log2(1+EsN0);
EbN0 = EsN0./cap_unconstrained;
EbN0dB = 10*log10( EbN0 );

% uncomment if you want to show unconstrained.
% plot( EbN0dB, cap_unconstrained, '-.');
% legend( sim_param.legend, 'Unconstrained', 2 );
xlabel( 'Eb/N0 in dB' );
ylabel( 'Capacity' );
hold off


% plot Eb/N0 vs. Capacity (useful for FSK modulation).
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    EsN0 = 10.^(sim_param(i).SNR/10); % assume SNR is Es/N0 in dB
    EbN0 = EsN0./(sim_state(i).capacity_avg*log2(sim_param(i).mod_order));
    EbN0dB = 10*log10( EbN0 );
    plot( sim_state(i).capacity_avg, EbN0dB, sim_param(i).linetype );
    hold on
end

ylabel( 'Eb/N0 in dB' );
xlabel( 'Rate' );
hold off


% plot Capacity vs. Es/N0.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    plot( sim_param(i).SNR, log2(sim_param(i).mod_order)*sim_state(i).capacity_avg, sim_param(i).linetype );
    hold on
end

legend( sim_param.legend );

% uncomment if you want to show unconstrained.
% plot( EsN0dB, cap_unconstrained, '-.');
% legend( sim_param.legend, 'Unconstrained', 2 );

xlabel( 'Es/N0 in dB' );
ylabel( 'Capacity' );
hold off

end



function [FigHandle, FigNumber] = PlotBerSerCodedUncoded(sim_param_uncoded, sim_state_uncoded, sim_param_coded, sim_state_coded, FigHandle, FigNumber)

% plot BER vs. Eb/N0 for Coded and Uncoded Modulations.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

% BER of uncoded modulation.
for i=1:length(sim_param_uncoded)
    
    % Can only plot against Eb/N0 (add logic later).
    if ( sim_param_uncoded(i).SNR_type(2) ~= 'b' )
        error( 'Uncoded modulation results must use SNR_type of Eb/No in dB.' );
    end
    
    figure( FigNumber );
    semilogy( sim_param_uncoded(i).SNR, sim_state_uncoded(i).BER, sim_param_uncoded(i).linetype );
    hold on
end

% BER of coded modulation only for the last iteration.
for i=1:length(sim_param_coded)
    % Convert to Eb/N0 (dB) if stored as Es/N0 (dB).
    if ( sim_param_coded(i).SNR_type(2) ~= 'b' )
        % This is Es/N0.
        EsN0dB = sim_param_coded(i).SNR;
        % Convert to Eb/N0.
        EsN0 = 10.^(EsN0dB/10);
        EbN0 = EsN0./sim_param_coded(i).rate;
        EbN0dB = 10*log10(EbN0);
    else
        EbN0dB = sim_param_coded(i).SNR;
    end
    % only plot the last iteration.
    if ( length( sim_param_coded(i).max_iterations ) )
        max_iter = sim_param_coded(i).max_iterations;
    else
        max_iter = 1;
    end
    
    semilogy( EbN0dB, sim_state_coded(i).BER( max_iter, : ), sim_param_coded(i).linetype );
    hold on
end

legend( sim_param_uncoded.legend, sim_param_coded.legend, 0 );
xlabel( 'Eb/N0 in dB' );
ylabel( 'BER' );

% BER of coded modulation for the other iterations.
for i=1:length(sim_param_coded)
    if ( length( sim_param_coded(i).plot_iterations ) )
        % Convert to Eb/N0 (dB) if stored as Es/N0 (dB).
        if ( sim_param_coded(i).SNR_type(2) ~= 'b' )
            % This is Es/N0.
            EsN0dB = sim_param_coded(i).SNR;
            % Convert to Eb/N0.
            EsN0 = 10.^(EsN0dB/10);
            EbN0 = EsN0./sim_param_coded(i).rate;
            EbN0dB = 10*log10(EbN0);
        else
            EbN0dB = sim_param_coded(i).SNR;
        end
        % plot the other iterations.
        semilogy( EbN0dB, sim_state_coded(i).BER(sim_param_coded(i).plot_iterations,:), sim_param_coded(i).linetype );
        hold on
    end
end

hold off


% plot BER vs. Es/N0 (dB) for Coded Modulation.
if ~isempty(sim_param_coded)
    FigNumber = FigNumber + 1;
    FigHandle = [FigHandle figure( FigNumber )];
    
    % only plot the last iteration.
    for i=1:length(sim_param_coded)
        
        % see if Es/N0 is defined, otherwise derive it.
        if ( sim_param_coded(i).SNR_type(2) == 'b' )
            % This is Eb/N0.
            EbN0dB = sim_param_coded(i).SNR;
            % Convert to Es/N0.
            EbN0 = 10.^(EbN0dB/10);
            EsN0 = sim_param_coded(i).rate*EbN0;
            EsN0dB = 10*log10(EsN0);
        else
            % This is already in Es/N0.
            EsN0dB = sim_param_coded(i).SNR;
        end
        
        % only plot the last iteration.
        if ( length( sim_param_coded(i).max_iterations ) )
            max_iter = sim_param_coded(i).max_iterations;
        else
            max_iter = 1;
        end
        
        % Plot BER versus Es/N0 in dB.
        figure( FigNumber );
        semilogy( EsN0dB, sim_state_coded(i).BER( max_iter, : ), sim_param_coded(i).linetype );
        hold on
    end
    
    figure( FigNumber );
    legend( sim_param_coded.legend, 0 );
    xlabel( 'Es/N0 in dB' );
    ylabel( 'BER' );
    
    % plot other iterations.
    for i=1:length(sim_param_coded)
        if ( length( sim_param_coded(i).plot_iterations ) )
            % see if Es/N0 is defind, otherwise derive it.
            if ( sim_param_coded(i).SNR_type(2) == 'b' )
                % This is Eb/N0.
                EbN0dB = sim_param_coded(i).SNR;
                % Convert to Es/N0.
                EbN0 = 10.^(EbN0dB/10);
                EsN0 = sim_param_coded(i).rate*EbN0;
                EsN0dB = 10*log10(EsN0);
            else
                % This is Es/N0.
                EsN0dB = sim_param_coded(i).SNR;
                % Convert to Eb/N0.
                EsN0 = 10.^(EsN0dB/10);
                EbN0 = EsN0./sim_param_coded(i).rate;
                EbN0dB = 10*log10(EbN0);
            end
            
            % plot other iterations.
            figure( FigNumber );
            semilogy( EsN0dB, sim_state_coded(i).BER(sim_param_coded(i).plot_iterations,:), sim_param_coded(i).linetype );
        end
    end
    
    figure( FigNumber );
    hold off
end


% plot SER vs. Eb/N0 (dB) for Uncoded Modulation.
if ~isempty(sim_param_uncoded)
    FigNumber = FigNumber + 1;
    FigHandle = [FigHandle figure( FigNumber )];
    
    % SER of uncoded modulation.
    for i=1:length(sim_param_uncoded)
        % Convert to Eb/N0 (dB) if stored as Es/N0 (dB).
        if ( sim_param_uncoded(i).SNR_type(2) ~= 'b' )
            error( 'The SNR should be stored as Eb/N0.' );
        end
        semilogy( sim_param_uncoded(i).SNR, sim_state_uncoded(i).SER, sim_param_uncoded(i).linetype );
        hold on
    end
    
    legend( sim_param_uncoded.legend, 0 );
    xlabel( 'Eb/N0 in dB' );
    ylabel( 'SER' );
    
    hold off
end

end



function [FigHandle, FigNumber] = PlotFerCodedOutage(sim_param_coded, sim_state_coded, sim_param_outage, sim_state_outage, FigHandle, FigNumber)
% Plot the FER of coded and outage simulations.

% First plot FER vs. Eb/N0 for Coded and Outage Simulations.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

% Plot FER vs. Eb/N0 in dB for Outage Probability Simulations.
for i=1:length(sim_param_outage)
    % If stored as Es/N0, convert to Eb/N0.
    if ( sim_param_outage(i).SNR_type(2) == 'b' )
        % This is Eb/N0.
        EbN0dB = sim_param_outage(i).SNR;
    else
        % This is stored as Es/N0.
        EsN0dB = sim_param_outage(i).SNR;
        % Convert to Eb/N0.
        EsN0 = 10.^(EsN0dB/10);
        EbN0 = EsN0./sim_param_outage(i).rate;
        EbN0dB = 10*log10(EbN0);
    end
    
    figure( FigNumber );
    semilogy( EbN0dB, sim_state_outage(i).FER, sim_param_outage(i).linetype );
    hold on
end

% Plot FER vs. Eb/N0 in dB for Coded Modulation Simulations.
% only plot the last iteration.
for i=1:length(sim_param_coded)
    % If stored as Es/N0, convert to Eb/N0.
    if ( sim_param_coded(i).SNR_type(2) == 'b' )
        % This is Eb/N0.
        EbN0dB = sim_param_coded(i).SNR;
    else
        % This is stored as Es/N0.
        EsN0dB = sim_param_coded(i).SNR;
        % Convert to Eb/N0.
        EsN0 = 10.^(EsN0dB/10);
        EbN0 = EsN0./sim_param_coded(i).rate;
        EbN0dB = 10*log10(EbN0);
    end
    
    % only plot the last iteration.
    if ( length( sim_param_coded(i).max_iterations ) )
        max_iter = sim_param_coded(i).max_iterations;
    else
        max_iter = 1;
    end
    
    figure( FigNumber );
    semilogy( EbN0dB, sim_state_coded(i).FER( max_iter, : ), sim_param_coded(i).linetype );
    hold on
end

figure( FigNumber );
legend( sim_param_outage.legend, sim_param_coded.legend, 0 );
xlabel( 'Eb/N0 in dB' );
ylabel( 'FER' );

% Now plot the other iterations.
% Plot FER vs. Eb/N0 in dB for Coded Modulation Simulations.
for i=1:length(sim_param_coded)
    if ( length( sim_param_coded(i).plot_iterations ) )
        % make sure that we get both Es/N0 and Eb/N0.
        if ( sim_param_coded(i).SNR_type(2) == 'b' )
            % This is Eb/N0.
            EbN0dB = sim_param_coded(i).SNR;
        else
            % This is stored as Es/N0.
            EsN0dB = sim_param_coded(i).SNR;
            % Convert to Eb/N0.
            EsN0 = 10.^(EsN0dB/10);
            EbN0 = EsN0./sim_param_coded(i).rate;
            EbN0dB = 10*log10(EbN0);
        end
        
        % plot other iterations.
        figure( FigNumber );
        semilogy( EbN0dB, sim_state_coded(i).FER(sim_param_coded(i).plot_iterations,:), sim_param_coded(i).linetype );
    end
end

figure( FigNumber );
hold off

% Plot FER vs. Es/N0 for Coded and Outage Simulations.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

% Plot FER vs. Es/N0 in dB for Outage Probability Simulations.
for i=1:length(sim_param_outage)
    % If stored as Eb/N0, convert to Es/N0.
    if ( sim_param_outage(i).SNR_type(2) == 'b' )
        % This is Eb/N0.
        EbN0dB = sim_param_outage(i).SNR;
        % Convert to Es/N0.
        EbN0 = 10.^(EbN0dB/10);
        EsN0 = sim_param_outage(i).rate*EbN0;
        EsN0dB = 10*log10(EsN0);
    else
        % This is Es/N0.
        EsN0dB = sim_param_outage(i).SNR;
    end
    % Plot FER versus Es/N0 in dB.
    figure( FigNumber );
    semilogy( EsN0dB, sim_state_outage(i).FER, sim_param_outage(i).linetype );
    hold on
end

% Plot FER vs. Es/N0 in dB for Coded Modulation Simulations.
% only plot the last iteration.
for i=1:length(sim_param_coded)
    % If stored as Eb/N0, convert to Es/N0.
    if ( sim_param_coded(i).SNR_type(2) == 'b' )
        % This is Eb/N0.
        EbN0dB = sim_param_coded(i).SNR;
        % Convert to Es/N0.
        EbN0 = 10.^(EbN0dB/10);
        EsN0 = sim_param_coded(i).rate*EbN0;
        EsN0dB = 10*log10(EsN0);
    else
        % This is Es/N0.
        EsN0dB = sim_param_coded(i).SNR;
    end
    
    % only plot the last iteration.
    if ( length( sim_param_coded(i).max_iterations ) )
        max_iter = sim_param_coded(i).max_iterations;
    else
        max_iter = 1;
    end
    
    % Plot FER versus Es/N0 in dB.
    figure( FigNumber );
    semilogy( EsN0dB, sim_state_coded(i).FER( max_iter, : ), sim_param_coded(i).linetype );
    hold on
end

figure( FigNumber );
legend( sim_param_outage.legend, sim_param_coded.legend, 0 );
xlabel( 'Es/N0 in dB' );
ylabel( 'FER' );

% Now plot the other iterations.
% Plot FER vs. Es/N0 in dB for Coded Modulation Simulations.
for i=1:length(sim_param_coded)
    if ( length( sim_param_coded(i).plot_iterations ) )
        % If stored as Eb/N0, convert to Es/N0.
        if ( sim_param_coded(i).SNR_type(2) == 'b' )
            % This is Eb/N0.
            EbN0dB = sim_param_coded(i).SNR;
            % Convert to Es/N0.
            EbN0 = 10.^(EbN0dB/10);
            EsN0 = sim_param_coded(i).rate*EbN0;
            EsN0dB = 10*log10(EsN0);
        else
            % This is Es/N0.
            EsN0dB = sim_param_coded(i).SNR;
        end
        % plot the other iterations.
        figure( FigNumber );
        semilogy( EsN0dB, sim_state_coded(i).FER(sim_param_coded(i).plot_iterations,:), sim_param_coded(i).linetype );
    end
end

figure( FigNumber );
hold off

end



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
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
%     US