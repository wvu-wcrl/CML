% CmlCreateHmatLocal creates a parity check matrix for use with
%  LDPC decoding.
%
% The calling syntax is:
%     [ sim_param code_param ] = CmlCreateHmatLocal( sim_param, code_param, cml_home )
%
%     Input
%       sim_param
%       code_param
%       cml_home
%
%     Output
%       sim_param
%       code_param
%
%     Note: The handling of H-matrices between the alist and pchk cases
%            is not consistent with random generation.
%            Solution:
%             All H-matrices stored in data/ldpc/<scenario>
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on 1/26/2013.

function [sim_param code_param] = CmlCreateHmatLocal(sim_param, code_param, cml_home)

pcm = sim_param.parity_check_matrix;    % shorten parity check matrix name

hmat_type = GetHmatType( pcm );

% type of parity check matrix to process
switch hmat_type
    
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
error('Random code generation not yet officially supported.');

% check for constraint, if not set, assume eira
if ~isfield(sim_param.ldpc_param, 'constraint')
    sim_param.ldpc_param.constraint = 'eira';
end

[H_rows, H_cols, data_bits_per_frame ] =...
    generate_random_H_matrix( sim_param, cml_home );

code_param = assign_pcm_code_param( code_param, H_rows, H_cols );
code_param.data_bits_per_frame = data_bits_per_frame;
code_param.P_matrix = [];

end


function [ sim_param code_param ] = process_dvb_cml( sim_param, code_param )

[code_param.H_rows, code_param.H_cols, code_param.P_matrix ] = eval( sim_param.parity_check_matrix );

code_param.data_bits_per_frame = length(code_param.H_cols) - length( code_param.P_matrix );

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
code_param.P_matrix = [];
code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;

end


function [code_param] = process_mat( sim_param, code_param, cml_home, pcm )

% load H_rows, H_cols
pchk_path = [cml_home filesep 'data' filesep 'ldpc'];
pchk_path_file = [pchk_path filesep pcm];

load(pchk_path_file);   % assume mat file contains H_rows, H_cols

code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols );
code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;
code_param.P_matrix = [];

end


function [H_rows, H_cols, K] = generate_random_H_matrix( sim_param, cml_home )

error_check_input(sim_param);

[N K C dv1 dv2 dv3 a1 a2 a3 constraint] = shorten_var_names(sim_param);

if strcmp(constraint, 'eira')
    
    Tnew = a2+a3;     % compute sub-matrix degree distributions
    a2new = a2/Tnew;
    a3new = a3/Tnew;
    
    %%% path and filename convention for hmat filename
    %%% cml/localscenarios/<scenario>/supp/hmat/<scen>_<rec>_hmat.mat
    
    h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home );
    
    h_matrix_exists = exist( h_mat_full_path, 'file' );
    
    if( h_matrix_exists )
        load(h_mat_full_path);
    else
        [H_rows H_cols] = gen_random_ldpc_code(C, K, dv2, dv3, a2new, a3new, ...
            cml_home, h_mat_full_path);
    end
else
    % non-eira code generation not implemented yet
end

end


function code_param = process_alist( sim_param, code_param, cml_home, pcm )

% convert alist to H_rows, H_cols
pcm_path = [ cml_home filesep 'data' filesep 'ldpc' ];
pcm_prefix = pcm(1:end-6);
[H_rows H_cols] = CmlAlistToHrowsHcols( pcm_path, pcm_prefix );

% assign H_rows, H_cols to code_param
code_param = assign_pcm_code_param( code_param, ...
    H_rows, H_cols );
code_param.data_bits_per_frame =...
    sim_param.framesize*sim_param.ldpc_param.rate;
code_param.P_matrix = [];

end


function error_check_input(sim_param)

if length(sim_param.ldpc_param.dv)  ~= 3,
    error('Only 3 distinct variable node degrees (D=3) supported');
end

if length(sim_param.ldpc_param.dv_dist) ~= 3
    error('Only 3 distinct variable node degrees (D=3) supported');
end

if abs(sum(sim_param.ldpc_param.dv_dist) - 1) > 10^(-3),
    error('Elements of sim_param.ldpc_param.dv_dist must sum to 1');
end

% possible extension: stronger conditions for valid degree distribution
end


function [N K C dv1 dv2 dv3 a1 a2 a3 constraint] = ...
    shorten_var_names(sim_param)

N = sim_param.framesize;           %codeword length
K = N*sim_param.ldpc_param.rate;   % number of information bits
C = N - K;                         % number of check bits

dv1 = sim_param.ldpc_param.dv(1);  % check node degrees
dv2 = sim_param.ldpc_param.dv(2);
dv3 = sim_param.ldpc_param.dv(3);

a1 = sim_param.ldpc_param.dv_dist(1); % degree distributions
a2 = sim_param.ldpc_param.dv_dist(2);
a3 = sim_param.ldpc_param.dv_dist(3);

constraint = sim_param.ldpc_param.constraint;   % special ldpc code constraint
end


function h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home )

scen_name = get_scen_name(sim_param);

h_matrix_path = form_h_matrix_path( cml_home, scen_name );

[ h_matrix_filename ]= form_h_matrix_filename(sim_param.filename);

h_mat_full_path = [h_matrix_path filesep h_matrix_filename];

end


function h_matrix_path = form_h_matrix_path( cml_home, scen_name )

h_matrix_path = [cml_home filesep 'output' filesep scen_name filesep...
    'supp' filesep 'hmat' ];


% make directory with sudo permission
[a b] = strtok(cml_home,'/');
[user d] = strtok(b, '/');

scen_path = [cml_home filesep 'output' filesep scen_name];
cmd = ['sudo mkdir -p ' h_matrix_path ]; system(cmd);
cmd = ['sudo chown -R ' user ':' user ' ' scen_path]; system(cmd);

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


function [H_rows H_cols] = gen_random_ldpc_code(C, K, dv2, dv3, a2new, a3new, ...
    cml_home, h_mat_full_path)

[ldpc_code_gen_path tmp_path] =...
    create_path_to_tmp_gen_directory(cml_home);

create_ldpc_pchk_file( C, K, dv2, dv3, a2new, a3new,...
    tmp_path, ldpc_code_gen_path);

convert_pchk_alist(ldpc_code_gen_path, tmp_path,...
    tmp_path, 'tmpfile.pchk');

[H_rows H_cols] = CmlAlistToHrowsHcols( tmp_path, 'tmpfile' );

loc = determine_location;

if strcmp(loc, 'clusterworker')
    save_hmat_cluster( h_mat_full_path, H_rows, H_cols );
elseif strcmp(loc, 'local')
    save(h_mat_full_path,'H_rows','H_cols');
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


function create_ldpc_pchk_file( C, K, dv2, dv3, a2new, a3new,...
    tmp_path, ldpc_code_gen_path)

% create ldpc creation command string
sp = [' '];
p1 = ['make-ldpc'];   % command name
p2 = [tmp_path filesep 'tmpfile.pchk'];  % temporary filename
p3 = int2str(C);        % number of check nodes
p4 = int2str(K);        % number information bits
p5 = ['3'];             % random number generation method
p6 = ['evenboth'];
p7 = [num2str(a2new) 'x' int2str(dv2)]; % degree dist 2
p8 = [filesep];
p9 = [num2str(a3new) 'x' int2str(dv3)]; % degree dist 3

% invoke external command to generate ldpc code
cmd = [ldpc_code_gen_path p1 sp p2 sp p3 sp p4 sp p5 sp p6 sp p7 p8 p9];

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
    H_rows, H_cols )
code_param.H_rows = H_rows;
code_param.H_cols = H_cols;
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
