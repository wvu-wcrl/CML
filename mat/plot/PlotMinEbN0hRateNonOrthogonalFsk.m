function [FigHandle, FigNumber] = PlotMinEbN0hRateNonOrthogonalFsk(sim_param, sim_state, FigHandle, FigNumber)
% Plot min Eb/N0 vs. h and min Eb/N0 vs. rate for nonorthogonal FSK under BW constraints B.

% plot min Eb/N0 vs. h.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_param(i).h );
    plot( sim_param(i).h(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'h' );
ylabel( 'min Eb/N0 (in dB)' );
hold off

% plot min Eb/N0 vs. rate.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_state(i).best_rate );
    plot( sim_state(i).best_rate(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'Code Rate (R)' );
ylabel( 'min Eb/N0 (in dB)' );
hold off

end