% fmtfig.m
% Script to increase line and text sizes.
%
% Input - Figure handle
% Output - Figure handle after font and line size adjustments

function plfmt(fhd, fs)

% Get axis handle
ah = get(fhd, 'CurrentAxes');

% Set size of all text to 18.
%c = findall(fig_handle_in);
set(ah, 'FontSize', fs);

d = findall(fhd,'Type','text');
set(d,'FontSize', fs);

%c = findall(axis_handle);
d = findall(ah,'Type','text');
set(d,'FontSize', fs);

% Set linewidth to 2.
line_handle = get(ah, 'Children');
set(line_handle,'LineWidth', 2);

grid on;
end