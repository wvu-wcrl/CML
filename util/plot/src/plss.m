% set figure resolution
function plss(fhd)

        % Blow up the figure
        set(fhd, 'Position', [1 1 1024 768]);
        
        % Printed size the same as on-screen size
        set(fhd,'PaperPositionMode','auto')

end