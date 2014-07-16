% CmlCreateHmatLocal creates a parity check matrix for use with LDPC decoding.
%
% The calling syntax is:
%     [sim_param, code_param] = CmlCreateHmatLocal( sim_param, code_param, cml_home )
%
%     sim_param: A structure containing simulation parameters.
%     sim_state: A structure containing the simulation state.
%
%     code_param: A structure contining derived information.
%     cml_home: Location of the CML home directory
%
%     Note: The handling of H-matrices between the alist and pchk cases
%           is not consistent with random generation.
%     Solution: All H-matrices stored in data/ldpc/<scenario>
%
% Copyright (C) 2012-2014, Terry R. Ferrett and Matthew C. Valenti
%
% Last updated on 7/13/2014.
%
% Licensed under the Lesser GPL.  See source code file for more detail.


function [sim_param code_param] = CmlCreateHmatLocal(sim_param, code_param, cml_home)

pcm = sim_param.parity_check_matrix;    % shorten parity check matrix name

hmat_type = GetHmatType( pcm );

% type of parity check matrix to process
switch hmat_type
    
    case 'cml_wimax'
        [ sim_param code_param ] = process_wimax_cml( sim_param, code_param );
    case 'cml_dvbs2'
        [ sim_param code_param ] = process_dvb_cml( sim_param, code_param );
    case 'pchk'
        [ code_param ] = process_pchk( sim_param, code_param, cml_home, pcm );
    case 'alist'
        [ code_param ] = process_alist( sim_param, code_param, cml_home, pcm);
    case 'mat'
        [code_param] = process_mat( sim_param, code_param, cml_home, pcm );
    case 'random'
        [ sim_param code_param ] = process_random( sim_param, code_param, cml_home);
        
    case 'not_supported'
        error('Parity check matrix type not supported.')
end

end



function [sim_param code_param] = process_random( sim_param, code_param, cml_home)

%%%%% Random code generation not yet officially supported
%%%%% Current implementation specific to Linux operating system
%%%%% For official support, this functionality must be generalized to all
%%%%%   platforms
%%%%%
%%%%% For unofficial use in a Linux environment, comment the following
%%%%%  error message.
%error('Random code generation not yet officially supported.');


% Generate random H-matrix
[H_rows, H_cols, H_rows_no_eira, H_cols_no_eira, data_bits_per_frame ] =...
    generate_random_H_matrix( sim_param, cml_home );


% save randomly generated ldpc code to file
h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home );
loc = determine_location;
if strcmp(loc, 'clusterworker')
    save_hmat_cluster( h_mat_full_path, H_rows, H_cols,...
        H_rows_no_eira, H_cols_no_eira);
elseif strcmp(loc, 'local')
    save(h_mat_full_path,'H_rows','H_cols',...
        'H_rows_no_eira', 'H_cols_no_eira');
end


% modify this noise
code_param = assign_pcm_code_param( code_param, H_rows, H_cols,...
    H_rows_no_eira, H_cols_no_eira);
code_param.data_bits_per_frame = data_bits_per_frame;

code_param.P_matrix = CreatePMatrix( sim_param );

end



function P_matrix = CreatePMatrix( sim_param )
switch sim_param.ldpc_param.constraint
    case 'wimax'
        [dc, dc, P_matrix ] =...
            InitializeWiMaxLDPC(sim_param.ldpc_param.rate, ...
            sim_param.framesize,...
            sim_param.ldpc_param.ind );
        
    case 'dvbs2'
        P_matrix = [];
    otherwise
end
end


function [ sim_param code_param ] = process_dvb_cml( sim_param, code_param )

[code_param.H_rows_no_eira, code_param.H_cols_no_eira, code_param.P_matrix ] =...
    eval( sim_param.parity_check_matrix );

code_param.data_bits_per_frame = length(code_param.H_cols_no_eira) - length( code_param.P_matrix );

%  Append dual-diagonal 1 locations to H-cols
code_param.H_cols = ...
    DvbCreateFullHcols( code_param.H_cols_no_eira, code_param.H_rows_no_eira );

% Append dual-diagonal 1 locations to H-rows
code_param.H_rows = ...
    DvbCreateFullHrows( code_param.H_cols_no_eira, code_param.H_rows_no_eira );

end



function [ sim_param code_param ] = process_wimax_cml( sim_param, code_param )

[code_param.H_rows_no_eira, code_param.H_cols_no_eira, code_param.P_matrix] =...
    eval( sim_param.parity_check_matrix );

code_param.data_bits_per_frame = length(code_param.H_cols_no_eira) - length( code_param.P_matrix );

% append eira matrix
%  Append dual-diagonal 1 locations to H-cols
code_param.H_cols = WiMaxCreateFullHcols( sim_param,...
    code_param.H_cols_no_eira, code_param.H_rows_no_eira );

% Append dual-diagonal 1 locations to H-rows
code_param.H_rows = WiMaxCreateFullHrows( sim_param,...
    code_param.H_cols, code_param.H_rows_no_eira );

end



function code_param = process_pchk( sim_param, code_param, cml_home, pcm )

%%%%% Parity check matrix format .pchk not yet officially supported
%%%%% Current implementation specific to Linux operating system
%%%%% For official support, this functionality must be generalized to all
%%%%%   platforms
%%%%%
%%%%% For unofficial use in a Linux environment, comment the following
%%%%%  error message.
error('Parity check matrix format .pchk not yet officially supported.');

[ H_rows H_cols ] = convert_local_pchk_hrows_hcols( cml_home, pcm );

code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols );

code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;

code_param.P_matrix = CreatePMatrix( sim_param );

end


function [code_param] = process_mat( sim_param, code_param, cml_home, pcm )

% load H_rows, H_cols
pchk_path = [cml_home filesep 'data' filesep 'ldpc'];
pchk_path_file = [pchk_path filesep pcm];

load(pchk_path_file);   % assume mat file contains H_rows, H_cols

code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols, H_rows_no_eira, H_cols_no_eira );
code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;

code_param.P_matrix = CreatePMatrix( sim_param );

end



function [H_rows, H_cols, H_rows_no_eira, H_cols_no_eira, K] = ...
    generate_random_H_matrix( sim_param, cml_home )

% change
error_check_input(sim_param);

% generalize to 4
[N K C dv a constraint] = shorten_var_names(sim_param);

% move into gen_random_ldpc_code
%Tnew = a2+a3;     % compute sub-matrix degree distributions
%a2new = a2/Tnew;
%a3new = a3/Tnew;

%%% path and filename convention for hmat filename
%%% cml/localscenarios/<scenario>/supp/hmat/<scen>_<rec>_hmat.mat
%%% cml/data/ldpc/<scen>_<rec>_hmat.mat

h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home );

h_matrix_exists = exist( h_mat_full_path, 'file' );

if( h_matrix_exists )
    load(h_mat_full_path);
else
    [H_rows_no_eira H_cols_no_eira] = gen_random_ldpc_code(C, K, dv, a,  ...
        cml_home, h_mat_full_path, constraint);
    
    [H_rows H_cols H_rows_no_eira] = ...
        ApplyEiraRandom( sim_param, H_rows_no_eira, H_cols_no_eira );
end



end




function [H_rows H_cols H_rows_no_eira] = ...
    ApplyEiraRandom( sim_param, H_rows_no_eira, H_cols_no_eira )


switch sim_param.ldpc_param.constraint,
    case 'wimax'
        %%% Create dual-diagonal matrix in H_cols and H_rows %%%
        %       K   |N - K
        %     |           |
        % H = |           | N - K
        %     |           |
        %     |           |
        %
        %  Last N - K columns
        
        %  Append dual-diagonal 1 locations to H_cols
        H_cols = WiMaxCreateFullHcols( sim_param, H_cols_no_eira, H_rows_no_eira );
        
        % Append dual-diagonal 1 locations to H_rows.
        H_rows = WiMaxCreateFullHrows( sim_param, H_cols, H_rows_no_eira );
        
        % Append last z entries (denoted H0 in the standard) to H_rows_no_eira.
        %  This step is for encoding.
        %  Terry 6/7/2013
        H_rows_no_eira = WiMaxAppendH0( sim_param, H_rows_no_eira, H_cols );
        
    case 'dvbs2'
        
        %%% Create dual-diagonal matrix in H_cols and H_rows %%%
        %       K   |N - K
        %     |           |
        % H = |           | N - K
        %     |           |
        %     |           |
        %
        %  Append to last N - K columns
        
        %  Append dual-diagonal 1 locations to H-cols
        H_cols = DvbCreateFullHcols( H_cols_no_eira, H_rows_no_eira );
        
        % Append dual-diagonal 1 locations to H-rows
        H_rows = DvbCreateFullHrows( H_cols_no_eira, H_rows_no_eira );
                
    otherwise
        error('H-matrix type ''%s'' not supported.', ...
            sim_param.ldpc_param.constraint)
end
end



function H_cols = DvbCreateFullHcols( H_cols, H_rows )
% Append dual diagonal matrix to parity check submatrix

% get number of columns in submatrix
[k, max_col_weight]=size(H_cols);

% number of rows, m = n - k
m = size(H_rows,1);

% create diagonal matrix
H_cols_dual = zeros(m, max_col_weight);
for i=1:m-1
    H_cols_dual(i,1) = i;
    H_cols_dual(i,2) = i+1;
end

% final entry
H_cols_dual(m,1) = m;

% append eira matrix entries to H_cols
H_cols((k+1):(k+m),:)=H_cols_dual;

end



function H_rows = DvbCreateFullHrows( H_cols, H_rows )

%   maximum weight of each column
[n, max_col_weight]=size(H_cols);

m = size(H_rows,1);
k=n-m;

% Add location of dual-diagonl 1's to H_rows
for j=2:m
    row_weight = sum(H_rows(j,:)~=0);
    H_rows(j, row_weight+1) = k + j-1;
    H_rows(j, row_weight+2) = k + j;
end

% Final row
H_rows(1,row_weight(1)+1)=k + 1;

end



function [ H_cols ] = WiMaxCreateFullHcols( sim_param, H_cols, H_rows )

%   maximum weight of each column
[cols, max_col_weight]=size(H_cols);
rows = size(H_rows,1);

% z is a shift value defined in the WiMax standard to define
%  block size for partitioning the parity check matrix
% 24 is a magic number from the standard
n = sim_param.framesize;  % rename code length for clarity
z = n/24;
m = rows;


%%% Append first z cols of eIRA matrix to random H_rows and H_cols
hmat_type = GetHmatType(sim_param.parity_check_matrix);
if strcmp( hmat_type, 'random' )
    [ H_rowsTmp H_colsTmp ] = InitializeWiMaxLDPC(sim_param.ldpc_param.rate,...
        sim_param.framesize,...
        sim_param.ldpc_param.ind);
    
    %  extract the first z columns of the eIRA matrix
    %   append to randomly generated H_cols
    firstInd = n - m + 1;
    lastInd = n - m + z;
    for k = firstInd:lastInd,
        H_cols(k,:) = zeros(1,max_col_weight);
        for p = 1:3,
            H_cols(k,p) = H_colsTmp(k,p);
        end
    end
end
%%%



%%% Create WiMax eIRA dual-diagonal matrix and append.
% Size of H_cols has changed. Update.
[cols, max_col_weight]=size(H_cols);

%  Initialize sparse matrix to contain dual-diagonal matrix
H_cols_dual = zeros(rows-z, max_col_weight);

% Populate sparse matrix with 1 locations
for i=1:rows-z
    H_cols_dual(i,1) = i;
    H_cols_dual(i,2) = i+z;
end

% Append H_cols_dual to H_cols
H_cols((cols+1):(cols+rows-z),:)=H_cols_dual;
%%%
end




function H_rows = WiMaxCreateFullHrows( sim_param, H_cols, H_rows )

% 24 is a magic number from the wimax standard
n = sim_param.framesize;
z = n/24;

%   maximum weight of each column
[cols, max_col_weight]=size(H_cols);
rows = size(H_rows,1);
n = cols;
m = rows;


% Add location of dual-diagonal 1's to H_rows
% first diagonal of length z, top left of matrix
%1 0 0
%0 1 0
%  ...
%1 0 1

% append z columns of H_rows to randomly generated H_matrix
hmat_type = GetHmatType(sim_param.parity_check_matrix);
if strcmp( hmat_type, 'random' )    
    H_rows = AppendH0(n, m, z, sim_param, H_rows );    
end
%%%


%%% Append dual-diagonal eIRA matrix
[cols, max_col_weight]=size(H_cols);
cols = cols - rows + z;

% top left matrix block
for j= 1:z,
    row_weight = sum(H_rows(j,:)~=0);
    H_rows(j, row_weight+1) = cols + j;
end

% middle of matrix
for j= z+1:rows-z,
    row_weight = sum(H_rows(j,:)~=0);
    H_rows(j, row_weight+1) = cols + j - z;
    H_rows(j, row_weight+2) = cols + j;
end

% bottom right of matrix block
for j= rows-z+1:rows,
    row_weight = sum(H_rows(j,:)~=0);
    H_rows(j, row_weight+1) = cols + j - z;
end
%%%

end






function H_rows_no_eira = WiMaxAppendH0( sim_param, H_rows_no_eira, H_cols )

% 24 is a magic number from the wimax standard
n = sim_param.framesize;
z = n/24;

%   maximum weight of each column
[cols, max_col_weight]=size(H_cols);
rows = size(H_rows_no_eira,1);
n = cols;
m = rows;

H_rows_no_eira = AppendH0(n, m, z, sim_param, H_rows_no_eira );

end




function H_rows = AppendH0(n, m, z, sim_param, H_rows )

firstInd = n - m + 1;
lastInd = n - m + z;

[ H_rowsTmp H_colsTmp ] = InitializeWiMaxLDPC(sim_param.ldpc_param.rate,...
    sim_param.framesize,...
    sim_param.ldpc_param.ind);


% pad H_rows with 3 columns of zeros to ensure no entries are overwritten
H_rows = [ H_rows zeros(m, 3) ];


% Append nonzero eIRA values to H_rows
for cur_col = firstInd:lastInd,
    EiraCol = H_colsTmp(cur_col, :);  % current eIRA column
    for p = 1:3,
        cur_row = EiraCol(p);
        % find first zero entry in this row
        indTmp = find(H_rows(cur_row,:));
        zInd = indTmp(end) + 1;
        H_rows( cur_row, zInd ) = cur_col;
    end
end

% remove zero columns so that maximum row weight is correct
[ rows cols ] = size(H_rows);
for k = cols:-1:1;
    if sum(H_rows(:,k)) == 0,
        H_rows = H_rows(:,1:end-1);
    end
end

end





function code_param = process_alist( sim_param, code_param, cml_home, pcm )

% Processing requires modification to support eira type codes
%  Terry 6/8/2013
error('Parity check matrix format .alist not yet officially supported.');


% convert alist to H_rows, H_cols
pcm_path = [ cml_home filesep 'data' filesep 'ldpc' ];
pcm_prefix = pcm(1:end-6);
[H_rows H_cols ErrMsg] = CmlAlistToHrowsHcols( pcm_path, pcm_prefix );

if ~isempty(ErrMsg)
    error(ErrMsg);
end

% assign H_rows, H_cols to code_param
code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols );
code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;

code_param.P_matrix = CreatePMatrix( sim_param );

end


function error_check_input(sim_param)


len_dv = length(sim_param.ldpc_param.dv);
len_dv_dist = length(sim_param.ldpc_param.dv_dist);


lens_match = len_dv == len_dv_dist;
if ~lens_match
    error('Number of dv and dv_dist must be the same.');
end

dv_sum = sum(sim_param.ldpc_param.dv_dist);

%if (dv_sum - 1) > 10^(-3)
%    error('sim_param.ldpc_param.dv_dist must sum to 1.');
%end

% possible extension: stronger conditions for valid degree distribution
end


function [N K C dv a constraint] = ...
    shorten_var_names(sim_param)

N = sim_param.framesize;           %codeword length
K = N*sim_param.ldpc_param.rate;   % number of information bits
C = N - K;                         % number of check bits

dv = sim_param.ldpc_param.dv;      % degrees
a = sim_param.ldpc_param.dv_dist;  % degree distributions

% special code constraint
constraint = sim_param.ldpc_param.constraint;
end


function h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home )

scen_name = get_scen_name(sim_param);

h_matrix_path = form_h_matrix_path( cml_home, scen_name );

[ h_matrix_filename ]= form_h_matrix_filename(sim_param.filename);

h_mat_full_path = [h_matrix_path filesep h_matrix_filename];

end


function h_matrix_path = form_h_matrix_path( cml_home, scen_name )


h_matrix_path = [ cml_home filesep 'data' filesep 'ldpc' ];


% make directory with sudo permission
%[a b] = strtok(cml_home,'/');
%[user d] = strtok(b, '/');

%scen_path = [cml_home filesep 'output' filesep scen_name];
%cmd = ['sudo mkdir -p ' h_matrix_path ]; system(cmd);
%cmd = ['sudo chown -R ' user ':' user ' ' scen_path]; system(cmd);

end


function scen_name = get_scen_name(sim_param)

[a b] = strtok(sim_param.filename, '/'); [c d] = strtok(b, '/');

scen_name = c;

end



function filename = form_h_matrix_filename(path_filename)

% get output filename sans extension
[a b] = strtok( path_filename(end:-1:1), '/');
[c d ] = strtok( a(end:-1:1), '.');

filename = [c '_hmat.mat'];

end


function [H_rows H_cols] = gen_random_ldpc_code(C, K, dv, a, ...
    cml_home, h_mat_full_path, constraint)

[ldpc_code_gen_path tmp_path] =...
    create_path_to_tmp_gen_directory(cml_home);

% compute a based on code constraints
%   WiMax constraints 2 degrees, DVB-S2 constraints 1
[ dv_sub a_sub ] = ComputeSubMatrixDist( dv, a, constraint );

% changing
create_ldpc_pchk_file( C, K, dv_sub, a_sub,...
    tmp_path, ldpc_code_gen_path);

convert_pchk_alist(ldpc_code_gen_path, tmp_path,...
    tmp_path, 'tmpfile.pchk');

[H_rows H_cols] = CmlAlistToHrowsHcols( tmp_path, 'tmpfile' );


end

function [ dv_sub a_sub ] = ComputeSubMatrixDist( dv, a, constraint )

switch constraint,
    case 'dvbs2'
        
        a_sum = sum(a(2:end));
        % in dvbs2, the first degree is constrained to be 2
        a_sub = a(2:end)/a_sum;
        
        dv_sub = dv(2:end);
        
    case 'wimax'
        
        a_sum = sum( a(3:end) );
        % in WiMax, the first two degrees are 2 and 3
        a_sub = a(3:end)/a_sum;
        
        dv_sub = dv(3:end);
        
    otherwise
        error('LDPC code constraint  ''%s'' not recognized.',...
            constraint );
end

end



function save_hmat_cluster( h_mat_full_path, H_rows, H_cols )

% temporary save and move
tmp_file = '/home/pcs/tmp/tmp_hmat.mat';
save(tmp_file,'H_rows','H_cols');
cmd_str = ['sudo mv' ' ' tmp_file ' ' h_mat_full_path];
system(cmd_str);

% change ownership
[a b] = strtok(h_mat_full_path,'/');
[user d] = strtok(b, '/');

spc = ' ';
c1 = 'sudo';
c2 = 'chown';
c3 = [user ':' user];
c4 = h_mat_full_path;


cmd = [c1 spc c2 spc c3 spc h_mat_full_path];
system(cmd);

end


function create_ldpc_pchk_file( C, K, dv_sub, a_sub,...
    tmp_path, ldpc_code_gen_path)



% create ldpc creation command string
sp = [' '];
p1 = ['make-ldpc'];   % command name
p2 = [tmp_path filesep 'tmpfile.pchk'];  % temporary filename
p3 = int2str(C);        % number of check nodes
p4 = int2str(K);        % number information bits
p5 = ['3'];             % random number generation method
p6 = ['evenboth'];

ndv = length(dv_sub); % number of degrees

% append all degree distributions to string
p7 = [num2str(a_sub(1)) 'x' int2str(dv_sub(1))];
for k = 2:ndv,
    p7 = [ p7 filesep num2str(a_sub(k)) 'x' int2str(dv_sub(k)) ];
end

% p7 = [num2str(a2new) 'x' int2str(dv2)]; % degree dist 2
%p8 = [filesep];
%p9 = [num2str(a3new) 'x' int2str(dv3)]; % degree dist 3

% invoke external command to generate ldpc code
cmd = [ldpc_code_gen_path p1 sp p2 sp p3 sp p4 sp p5 sp p6 sp p7];

system(cmd);

end


function convert_pchk_alist(ldpc_code_gen_path, tmp_path,...
    pchk_path, pchk_file)

% create alist creation command string
sp = [' '];
p1 = ['pchk-to-alist'];   % command name
p2 = [pchk_path filesep pchk_file];  % temporary filename
p3 = [tmp_path filesep pchk_file(1:end-5) '.alist'];

% invoke external command to generate alist file
cmd = [ldpc_code_gen_path p1 sp p2 sp p3];
system(cmd);

end


function code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols, H_rows_no_eira, H_cols_no_eira )
code_param.H_rows = H_rows;
code_param.H_cols = H_cols;
code_param.H_rows_no_eira = H_rows_no_eira;
code_param.H_cols_no_eira = H_cols_no_eira;
end



function [ H_rows H_cols ] = convert_local_pchk_hrows_hcols( cml_home, pcm )

pchk_path = [cml_home filesep 'data' filesep 'ldpc'];
pchk_path_file = [pchk_path filesep pcm];

pcf_exists = exist(pchk_path_file, 'file');
if ~pcf_exists
    error('Parity check file %s does not exist.', pcm);
end

[ldpc_code_gen_path tmp_path] = create_path_to_tmp_gen_directory(cml_home);

convert_pchk_alist(ldpc_code_gen_path, tmp_path,...
    pchk_path, pcm);

pcm_prefix = pcm(1:end-5);
[H_rows H_cols] = CmlAlistToHrowsHcols( tmp_path, pcm_prefix );

end


function [ldpc_code_gen_path tmp_path] = create_path_to_tmp_gen_directory(cml_home)

ldpc_code_gen_path = [cml_home filesep 'module' filesep 'chan_code'...
    filesep 'ldpc' filesep 'code_gen' filesep];

loc = determine_location;
if strcmp(loc, 'clusterworker')
    tmp_path = [filesep 'home' filesep 'pcs' filesep 'tmp'];
elseif strcmp(loc, 'local')
    tmp_path = [ldpc_code_gen_path 'tmp'];
end

end


function loc = determine_location()

[a whoami] = system('whoami');
if strcmp( whoami(1:end-1) , 'pcs')
    loc = 'clusterworker';
else
    loc = 'local';
end
end
%     Function CmlCreateHmatLocal is part of the Iterative Solutions Coded Modulation
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
