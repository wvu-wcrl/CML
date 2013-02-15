function [FigHandle, FigNumber] = PlotThroughputEsN0(sim_param, sim_state, FigHandle, FigNumber)
% Plot throughput vs. Es/N0.

FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

% plot throughput vs. Es/N0.
for i=1:length(sim_param)
    plot( sim_param(i).SNR, sim_state(i).throughput, sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'Es/N0 in dB' );
ylabel( 'Normalized Throughput' );
hold off

end