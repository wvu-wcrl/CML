function [FigHandle, FigNumber] = PlotExitCurves(sim_param, sim_state, FigHandle, FigNumber, SnrPoint)
% Plot exit curves.

for i=1:length(sim_param)
    % get snr points.
    [ return_data_or_plot, CurrentSnrPoint ] = process_exit_input(sim_param(i), SnrPoint);
    
    % if strcmp( return_data_or_plot, 'plot')
        
        for s = 1:length(CurrentSnrPoint)
            [SingleSnrPoint, snr_ind] = get_snr_point( sim_param(i), CurrentSnrPoint(s) );
            FigNumber = FigNumber + 1;
            % clf;  %%% added 12/15/2012.
            FigHandle = [FigHandle figure( FigNumber )];
            
            plot( sim_param(i).exit_param.requested_IA, sim_state(i).exit_state.IE_vnd(:,snr_ind), 'k-' );
            hold on
            plot( sim_param(i).exit_param.requested_IA, sim_state(i).exit_state.IA_cnd(:,snr_ind), 'r--' );
            hold off
            
            xlabel('I_{A,VND}, I_{E,CND}');
            ylabel('I_{E,VND}, I_{E,CND}');
            legend('VND', 'CND');
            
            annotate_exit_params( sim_param(i), snr_ind );
            
        end
    % end
end
end


function [return_data_or_plot, SnrPoint] = process_exit_input(sim_param, SnrPoint)

% if VarArgLength > 3
%     error('Too many input arguments!');
%     
% elseif VarArgLength == 3
    
    return_data_or_plot = 'plot';
    
    % if length(SnrPoint) > 1
    %    error('Please supply a single SNR point.');
    % end
    
    IndNotValidSnr = [];
    for s = 1:length(SnrPoint)
        snr_ind = get_snr_ind( sim_param, SnrPoint(s));
        
        if isempty( snr_ind )
            fprintf(['\nSNR point ' num2str(SnrPoint(s)) ' dB was not found.\n']);
            IndNotValidSnr = [IndNotValidSnr ,s];
        end
    end
    if ~isempty(IndNotValidSnr)
        SnrPoint(IndNotValidSnr) = [];
    end
    
% elseif VarArgLength == 2
%     return_data_or_plot = 'return_data';
% end

% if NumberCases > 1
%     error('Please specify a single EXIT record.');
% end
end


function [SnrPoint snr_ind] = get_snr_point( sim_param, SnrPoint )
snr_ind = get_snr_ind( sim_param, SnrPoint );
end


function snr_ind = get_snr_ind( sim_param, snrpoint )
snr_diff = abs(sim_param.SNR - snrpoint) < 1e-3;
snr_ind = find( snr_diff );
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