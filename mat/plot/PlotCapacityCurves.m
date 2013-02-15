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