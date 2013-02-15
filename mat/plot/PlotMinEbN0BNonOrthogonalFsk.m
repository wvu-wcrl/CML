function [FigHandle, FigNumber] = PlotMinEbN0BNonOrthogonalFsk(sim_param, sim_state, FigHandle, FigNumber)
% Plot min Eb/N0 vs. B, eta vs. min Eb/N0, optimal h vs. B, optimal rate vs. B for nonorthogonal FSK under BW constraint B.

% plot min Eb/N0 vs. B.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_param(i).bwconstraint );
    plot( sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'Bandwidth (B)' );
ylabel( 'min Eb/N0 (in dB)' );
hold off

% plot eta vs. min Eb/N0.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_param(i).bwconstraint );
    % plot( sim_state(i).min_EbNodB(I), 1./sim_param(i).bwconstraint(I), sim_param(i).linetype );
    plot( 1./sim_param(i).bwconstraint(I), sim_state(i).min_EbNodB(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
% ylabel( '\eta' );
% xlabel( 'minimum Eb/N0 in dB' );
xlabel( '\eta in bps/Hz' );
ylabel( 'Minimum Eb/N0 in dB' );
hold off

% plot optimal h vs. B.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_param(i).bwconstraint );
    plot( sim_param(i).bwconstraint(I), sim_param(i).h(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'Bandwidth (B)' );
ylabel( 'Optimal h' );
hold off

% plot optimal rate vs. B.
FigNumber = FigNumber + 1;
FigHandle = [FigHandle figure( FigNumber )];

for i=1:length(sim_param)
    [Y,I] = sort( sim_param(i).bwconstraint );
    plot( sim_param(i).bwconstraint(I), sim_state(i).best_rate(I), sim_param(i).linetype );
    hold on
end

legend( sim_param.legend, 2 );
xlabel( 'Bandwidth (B)' );
ylabel( 'Optimal rate' );
hold off

end