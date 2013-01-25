% CmlSetupAccount.m
%  Creates configuration file for WebCML
%
% Inputs
%
% 
% Outputs
%  WebCML configuration file in <cml_root>/cfg/webcml
%
%
%     Last updated on 1/24/2013
%
%     Copyright (C) 2013, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

function CmlSetupAccount()

[ cml_home ] = CmlLoadCmlHome('local');

Ex = CmlCfgEx();

switch Ex 
    case 'yes'
        p1 = 'WebCML account information';
        p2 = 'already configured. Modify? y/n [n]:';
        spc = ' ';
        AccntPrompt = [p1 spc p2];
        reply = input(AccntPrompt, 's');
        
        switch lower(reply)
            case 'y'
                get_accnt_from_u();
            otherwise
        end        
    case 'no'
        get_accnt_from_u();            
end



end


function get_accnt_from_u()
AccntCfgd=0;
while( AccntCfgd == 0 )
    
    username = input('Please enter your WebCML username: ', 's');
    NameEntered = ~isempty(username);
    
    if NameEntered == 1, NameEntered = 'yes'; else NameEntered = 'no'; end
    
    switch NameEntered
        case 'yes'
            write_webcml_cf(username);
            AccntCfgd = 1;
            fprintf('WebCML configuration complete.\n');
        case 'no'
            AccntCfgd = 0;            
    end
    
end
end


function write_webcml_cf(username)

[ cml_home ] = CmlLoadCmlHome('local');
CfgFi = [ cml_home filesep 'cfg' filesep 'webcml'];

CfgFiID = fopen(CfgFi,'w');

fprintf(CfgFiID, '[cfg]\n');
fprintf(CfgFiID, 'USER = %s\n', username);

RemCmlRoot = [ 'REMOTE_CMLROOT = ' '/home/pcs/projects/cml' ];
fprintf(CfgFiID, '%s\n', RemCmlRoot);

RemProjRoot = [ 'REMOTE_PROJROOT = ' '/home' '/' username '/Projects/cml' ];
fprintf(CfgFiID, '%s\n', RemProjRoot);

fclose(CfgFiID);

end


%     This library is free software;
%     you can redistribute it and/or modify it under the terms of
%     the GNU Lesser General Public License as published by the
%     Free Software Foundation; either version 2.1 of the License,
%     or (at your option) any later version.
%
%     This library is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%     Lesser General Public License for more details.
%
%     You should have received a copy of the GNU Lesser General Public
%     License along with this library; if not, write to the Free Software
%     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
