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

if ~( isempty(sim_param_uncoded) || isempty(sim_param_coded) )
    legend( sim_param_uncoded.legend, sim_param_coded.legend, 0 );
elseif isempty(sim_param_uncoded)
    legend( sim_param_coded.legend, 0 );
elseif isempty(sim_param_coded)
    legend( sim_param_uncoded.legend, 0 );
end
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