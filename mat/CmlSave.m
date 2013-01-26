function CmlSave( save_struct, SimLocation )
% Inputs
%
%     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%     For full copyright information see the bottom of this file.

switch SimLocation
    
    case { 'local', 'clusterlocal' }
             save_state = save_struct.save_state;
             save_param = save_struct.save_param;
             save( save_struct.tempfile, save_struct.save_flag, 'save_state', 'save_param');
        
        % Store into local directory (if running locally)
        if ( save_struct.save_param.compiled_mode )
            copyfile( save_struct.tempfile, save_struct.save_param.filename, 'f' );
        end
        
        movefile( save_struct.tempfile, save_struct.code_param.filename, 'f');
        
    case 'clusterworker'
        % currently, take no action
        
         
    otherwise
        
end

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
