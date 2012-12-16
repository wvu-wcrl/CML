function CmlPlotTextBox(txtlines, pos, fs, fhd)
% txtlines - text box contents. cell array of strings.
% pos      - text box position
% fs       - fontsize
% fhd      - figure handle

figure(fhd);  % select figure
annotation('textbox', pos, 'String', txtlines);

end
