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