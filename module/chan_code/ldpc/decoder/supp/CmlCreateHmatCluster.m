% CmlCreateHmatCluster converts parity check matrices uploaded by web users
%   to the format expected by CML.
%
% The calling syntax is:
%     CmlCreateHmatCluster( obj, CurrentUser, pcm, cml_home )
%
%     Inputs
%       obj         CmlJobManager object
%       CurrentUser Current user selected by CmlJobManager
%       pcm         parity check matrix argument loaded from
%                     sim_param.parity_check_matrix
%       data_path   path to user data directory on cluster
%
%     Outputs
%       SuccessFlag      0 if no error, 1 if error
%       ErrMsg           Empty if no error, string if error
%
%
%     Copyright (C) 2013, Terry R. Ferrett, Mohammad Fanaei and Matthew C. Valenti
%
%     Last updated on 1/25/2013

function [SuccessFlag ErrMsg] = ...
    CmlCreateHmatCluster( obj, CurrentUser, pcm, cml_home )

SuccessFlag = 0;  % assume successful operation

hmat_type = get_hmat_type( pcm );

switch hmat_type
    case 'pchk'
        pcm_prefix = pcm(1:end-5);
        [ H_rows H_cols ErrMsg ] = cnv_pchk_hr_hc( obj, pcm, cml_home );
       
        if ~isempty(ErrMsg)
            SuccessFlag = 1;
            return;
        end
        
        [ErrMsg] = save_hrows_hcols( obj, CurrentUser, pcm_prefix, H_rows, H_cols);
    case 'alist'
        pcm_prefix = pcm(1:end-6);
        [JobInDir, JobRunningDir, JobOutDir, TempDir JobDataDir] =...
            obj.SetPaths(CurrentUser.JobQueueRoot);
        [H_rows H_cols] = CmlAlistToHrowsHcols( JobDataDir, pcm_prefix );
        [ErrMsg] = save_hrows_hcols( obj, CurrentUser, pcm_prefix, H_rows, H_cols);
    case 'mat'
        %
    case 'cml_dvbs2'
        %
    case 'not_supported';
        %
    otherwise
        %
end

if ~isempty(ErrMsg)
    SuccessFlag = 1;
    return;
end


end






function hmat_type = get_hmat_type( pcm )
if ~isempty(strfind( pcm, 'InitializeDVBS2' ))
    hmat_type = 'cml_dvbs2';
    
elseif strcmp( pcm(end-3:end), 'pchk')
    hmat_type = 'pchk';
    
elseif strcmp( pcm(end-4:end), 'alist')
    hmat_type = 'alist';
    
elseif strcmp( pcm(end-2:end), 'mat')
    hmat_type = 'mat';
    
else
    hmat_type = 'not_supported';
    
end
end


function [ H_rows H_cols ErrMsg ] = cnv_pchk_hr_hc( obj, pcm, cml_home )

[LdpcCodeGenP] = crp_codegen_cl( cml_home );

tmp_path = obj.JobManagerParam.TempJMDir;

[JobInDir, JobRunningDir, JobOutDir, TempDir JobDataDir] =...
    obj.SetPaths(CurrentUser.JobQueueRoot);

[ErrMsg] = cnv_pchk_alist_cl(LdpcCodeGenP, JobDataDir, tmp_path, pcm);

pcm_prefix = pcm(1:end-5);

[H_rows H_cols] = CmlAlistToHrowsHcols( tmp_path, pcm_prefix );

end


function [LdpcCodeGenP] = crp_codegen_cl( cml_home )

p1 = cml_home;
p2 = 'module';
p3 = 'chan_code';
p4 = 'ldpc';
p5 = 'code_gen';

LdpcCodeGenP = [p1 filesep p2 filesep p3 filesep p4 filesep p5];

end


function [ErrMsg] = cnv_pchk_alist_cl(LdpcCodeGenP, data_path, tmp_path, pchk_file)

% create alist creation command string
sp = [' '];
p1 = ['pchk-to-alist'];   % command name
p2 = [data_path filesep pchk_file];  % temporary filename
p3 = [tmp_path filesep pchk_file(1:end-5) '.alist'];

if ~ exist([LdpcCodeGenP filesep p1], 'file');
    ErrMsg1 = 'pchk-to-alist executable file does not exist.\n';
    ErrMsg2 = 'Please compile the LDPC code generation functions.';
    ErrMsg = [ErrMsg1 ErrMsg2];
else
    ErrMsg = [''];
end

% invoke external command to generate alist file
cmd = [ps sp LdpcCodeGenP filesep p1 sp p2 sp p3];
system(cmd);
end


function [ErrMsg] = save_hrows_hcols( obj, CurrentUser, pcm_prefix, H_rows, H_cols)
PcmMat = [ pcm_prefix '.mat' ];

PcmMatTmpP = fullfile(obj.JobManagerParam.TempJMDir, PcmMat);

save( PcmMatTmp, 'H_rows', 'H_cols');

[JobInDir, JobRunningDir, JobOutDir, TempDir] =...
    obj.SetPaths(CurrentUser.JobQueueRoot);

PcmMatDataP = [ JobDataDir filesep PcmMat ];

% error check
SuccessFlag = MoveFile(obj, PcmMatTmpP, PcmMatDataP,...
    SuccessMsg, ErrorMsg);
if SuccessFlag ~= 0,
    ErrMsg = ['Error saving %s.', PcmMatDataP];
else
    ErrMsg = [''];
end
end

%     Function CmlCreateHmatCluster is part of the Iterative Solutions Coded Modulation
%     Library (ISCML).
%
%     The Iterative Solutions Coded Modulation Library is free software;
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
