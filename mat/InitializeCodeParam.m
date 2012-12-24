function [sim_param, code_param] = InitializeCodeParam( sim_param, cml_home )
% InitializeCodeParam sets up the code_param structure, which contains
% information derived from the sim_param structure.
%
% The calling syntax is:
%     code_param = InitializeCodeParam( sim_param )
%
%     sim_param = A structure containing simulation parameters. (input and output)
%     code_param = A structure contining derived information.
%
%     cml_home = location of cml_home directory
%
%     Note: See readme.txt for a description of the structure formats.
%
% Copyright (C) 2006-2008, Matthew C. Valenti
%
% Last updated on May 3, 2008
%
% Function InitializeCodeParam is part of the Iterative Solutions Coded Modulation
% Library (ISCML).
%
% The Iterative Solutions Coded Modulation Library is free software;
% you can redistribute it and/or modify it under the terms of
% the GNU Lesser General Public License as published by the
% Free Software Foundation; either version 2.1 of the License,
% or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

% initialize code

% Initialize code_param (in case it does not get defined)
% Fixed 12/7/07
if length( sim_param.rate )
    code_param.rate = sim_param.rate;
else
    code_param.rate = [];
end

% derive the modulation parameters.
if ( ( strcmp( sim_param.sim_type, 'coded' ) )||( strcmp( sim_param.sim_type, 'uncoded' ) )...
        ||( strcmp( sim_param.sim_type, 'capacity' ) )||(strcmpi( sim_param.sim_type, 'bloutage' ) )...
        || ( strcmp( sim_param.sim_type, 'exit' ) ) )
    code_param.bits_per_symbol = log2(sim_param.mod_order);
    
    % bpsk is a special case (runs faster that way)
    code_param.bpsk = 0;
    code_param.fsk = 0;
    if ( strcmpi( sim_param.modulation, 'custom' ) )
        % custom modulation.  Read in S directly from scenario file
        code_param.S_matrix = sim_param.S_matrix;
        
    elseif( sim_param.code_configuration == 3 )
        % HSDPA
        code_param.S_matrix = CreateConstellation( 'HSDPA', sim_param.mod_order );
    elseif ( strcmpi( sim_param.modulation, 'FSK' ) )
        code_param.fsk = 1;
        if (length( sim_param.h )==0)
            sim_param.h = 1;
        end
        
        if ( length( sim_param.mapping ) == 0)
            sim_param.mapping = 'natural';
        end
        
        [code_param.S_matrix, code_param.mapping] = CreateConstellation( 'FSK', sim_param.mod_order, sim_param.mapping, sim_param.h );
        
        % Determine noise correlation
        if ( sim_param.h == 1 )
            code_param.fil_noise = eye( sim_param.mod_order );
        else
            % the correlation does not depend on mapping.
            for m = 1:sim_param.mod_order
                for n = 1:sim_param.mod_order
                    R(n,m) = sinc((m-n)*sim_param.h)* exp(-j*pi*(m-n)*sim_param.h);
                end
            end
            
            [U,Delta,V] = svd(R);
            fil_noise = U*diag( diag(Delta).^0.5);
            T = abs( fil_noise*fil_noise' - R);
            if ( max(max(T)) > 1E-10)
                disp('wrong fil_noise matrix');
            end
            code_param.fil_noise = fil_noise;
            
        end
    elseif ( strcmpi( sim_param.modulation, 'bpsk' ) )
        code_param.bpsk = 1;
        code_param.S_matrix = [1 -1];
    else
        % Not bpsk or HSDPA, so generate the S_matrix
        code_param.S_matrix = CreateConstellation( sim_param.modulation, sim_param.mod_order, sim_param.mapping );
    end
end

% if iterative, need to determine number of iterations
% this has a distinct purpose from max_iterations, as the simulator will
% adjust to make smaller when appropriate
if ( length(sim_param.max_iterations) )
    code_param.max_iterations = sim_param.max_iterations;
else
    code_param.max_iterations = 1;
end

% defaults
code_param.coded = 0;
code_param.outage = 0;

% derive the code parameters.
if strcmp( sim_param.sim_type, 'coded' )
    code_param.coded = 1;
    switch sim_param.code_configuration
        case {1} % PCCC
            % create the channel interleaver
            code_param.code_interleaver = eval( sim_param.code_interleaver );
            code_param.data_bits_per_frame = length( code_param.code_interleaver );
            
            % determine the puncturing pattern
            if ( length (sim_param.pun_pattern1 ) )
                % use the pattern in the scenario file
                code_param.pun_pattern = [sim_param.pun_pattern1
                    sim_param.pun_pattern2];
                code_param.tail_pattern = [sim_param.tail_pattern1
                    sim_param.tail_pattern2];
            else
                % puncture pattern not defined, so use default
                [N1,K1] = size( sim_param.g1 );
                [N2,K2] = size( sim_param.g2 );
                code_param.tail_pattern = ones(N1+N2,K1-1); % send all tail bits once, as in UMTS
                code_param.pun_pattern = ones(N1+N2,1);
                code_param.pun_pattern(N1+1,1) = 0; % don't send lower systematic
            end
        case {2} % LDPC
            
            switch( sim_param.parity_check_matrix )
                case 'random' % if random, generate based on params and constraints
                    
                    % check for constraint, if not set, assume eira
                    if ~isfield(sim_param.ldpc_param, 'constraint')
                        sim_param.ldpc_param.constraint = 'eira';
                    end
                    
                    [H_rows, H_cols, data_bits_per_frame ] =...
                        generate_random_H_matrix( sim_param, cml_home );
                    code_param.H_rows = H_rows;
                    code_param.H_cols = H_cols;
                    code_param.data_bits_per_frame = data_bits_per_frame;
                    
                    code_param.P_matrix = [];
                    
                otherwise
                    % if not random, use specified parity check matrix
                    [code_param.H_rows, code_param.H_cols, code_param.P_matrix ] = eval( sim_param.parity_check_matrix );
                    code_param.data_bits_per_frame = length(code_param.H_cols) - length( code_param.P_matrix );
            end
        case {3} % HSDPA
            % derived constants
            K_crc = sim_param.framesize + 24; % add CRC bits
            
            % see if there needs to be more than one block
            code_param.number_codewords = ceil( K_crc/5114 ); % number of blocks
            data_bits_per_block = ceil( K_crc/code_param.number_codewords ); % length of each block
            code_param.data_bits_per_frame = code_param.number_codewords*data_bits_per_block; % includes the filler bits, if any
            
            code_param.code_interleaver = eval( strcat( 'CreateUmtsInterleaver(', int2str( data_bits_per_block ), ')' ) );
            
            if ( sim_param.mod_order == 4 )
                % QPSK
                code_param.modulation = 0;
                code_param.U = 960;
                % sim_param.modulation = 'HSDPA';
            else
                % 16-QAM
                code_param.modulation = 1;
                code_param.U = 1920;
                % sim_param.modulation = 'HSDPA';
            end
            code_param.N_data = code_param.U*sim_param.P;
            code_param.N_TTI = 3*data_bits_per_block + 12;
            
            % Puncturing pattern
            code_param.pun_pattern = [1 1 0 1]';
            
            % tail pattern
            code_param.tail_pattern = ones(4,3);
            
            % generators
            sim_param.g1 = [1 0 1 1
                1 1 0 1];
            sim_param.g2 = sim_param.g1;
            sim_param.nsc_flag1 = 0;
            sim_param.nsc_flag2 = 0;
        case {4} % UMTS Turbo code
            % generator polynomials for UMTS
            sim_param.g1 = [1 0 1 1
                1 1 0 1];
            sim_param.g2 = sim_param.g1;
            sim_param.nsc_flag1 = 0;
            sim_param.nsc_flag2 = 0;
            
            % the code interleaver
            sim_param.code_interleaver = ...
                strcat( 'CreateUmtsInterleaver(', int2str(sim_param.framesize ), ')' );
            code_param.code_interleaver = eval( sim_param.code_interleaver );
            code_param.data_bits_per_frame = length( code_param.code_interleaver );
            
            % the puncturing pattern
            if length( sim_param.code_bits_per_frame )
                [code_param.pun_pattern, code_param.tail_pattern] = UmtsPunPattern( sim_param.framesize, sim_param.code_bits_per_frame );
            else
                code_param.pun_pattern = [1 0 1 1]';
                code_param.tail_pattern = ones(4,3);
            end
            
        case {5} % Wimax CTC code
            code_param.code_interleaver = CreateWimaxInterleaver( sim_param.framesize );
            code_param.data_bits_per_frame = sim_param.framesize;
            code_param.pun_pattern = CreateWimaxPuncturingPattern( sim_param.code_bits_per_frame );
        case {6} % DVB-RCS turbo code
            code_param.code_interleaver = CreateDvbInterleaver( sim_param.framesize );
            code_param.data_bits_per_frame = sim_param.framesize;
            code_param.pun_pattern = CreateDvbPuncturingPattern( sim_param.code_bits_per_frame, 3*sim_param.framesize );
        otherwise % convolutional (0) or BTC (7)
            code_param.data_bits_per_frame = sim_param.framesize;
    end
    
    % Encode a test word in order to determine the length
    code_param.bicm_interleaver = [];
    data = zeros(1, code_param.data_bits_per_frame);
    [s, codeword] = CmlEncode( data, sim_param, code_param );
    code_param.code_bits_per_frame = length( codeword );
    code_param.symbols_per_frame = length( s );
    
    if ( sim_param.code_configuration == 3 )
        code_param.rate = sim_param.framesize/code_param.symbols_per_frame; % HSDPA
    else
        code_param.rate = code_param.data_bits_per_frame/code_param.symbols_per_frame;
    end
    
    % check number of symbols per frame for consistency
    if ( code_param.symbols_per_frame ~= ceil( code_param.code_bits_per_frame / code_param.bits_per_symbol ) )
        error( 'Symbols per frame is inconsistent' );
    end
elseif ( strcmpi( sim_param.sim_type, 'uncoded' )||strcmpi( sim_param.sim_type, 'capacity' )...
        || strcmpi( sim_param.sim_type, 'exit') )
    code_param.symbols_per_frame = sim_param.framesize;
    code_param.data_bits_per_frame = code_param.symbols_per_frame*code_param.bits_per_symbol;
    code_param.rate = code_param.data_bits_per_frame/code_param.symbols_per_frame;
elseif ( strcmpi( sim_param.sim_type, 'bloutage' ) )
    code_param.outage = 1;
    code_param.rate = sim_param.rate; % rate specified by the user.
    code_param.symbols_per_frame = ceil( sim_param.framesize/sim_param.rate );
    code_param.data_bits_per_frame = code_param.symbols_per_frame*log2(sim_param.mod_order);
end

% determine channel type
if (strcmpi( sim_param.channel, 'rayleigh' ) )
    code_param.channel_type = 1;
elseif (strcmpi( sim_param.channel, 'awgn' ) )
    code_param.channel_type = 0; % AWGN
elseif (strcmpi( sim_param.channel, 'block' ) )
    if strcmp( sim_param.sim_type, 'coded' )
        code_param.channel_type = 2; % block fading
        code_param.symbols_per_block = ceil( code_param.symbols_per_frame/sim_param.blocks_per_frame );
        % bug fix below: Sept. 4, 2007
        if ( code_param.symbols_per_block*sim_param.blocks_per_frame ~= code_param.symbols_per_frame )
            error( 'There must be an integer number of blocks per frame' );
        end
    else
        
        error( 'block channel type is only for coded simulations' );
    end
end

% determine matlab version
version_text = version;
if ( str2num( version_text(1) ) > 6)
    code_param.save_flag = '-v6';
else
    code_param.save_flag = '-mat';
end

% determine where your root directory is (added 10-12-07)
code_param.filename = [cml_home sim_param.filename];

% determine where input filename is for modulation-constrained outage
% (added 12-7-07)
if (strcmpi( sim_param.sim_type, 'outage' ) )
    code_param.input_filename = [cml_home sim_param.input_filename];
end

% need to let sim_param know what the rate is (for proper plotting)
sim_param.rate = code_param.rate;


end





function [H_rows, H_cols, K] = generate_random_H_matrix( sim_param, cml_home )

error_check_input(sim_param);

[N K C dv1 dv2 dv3 a1 a2 a3 constraint] = ...
    shorten_var_names(sim_param);


%[cml_home] = CmlLoadCmlHome('local');

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

constraint = sim_param.ldpc_param.constraint;   % special constraint
% on ldpc code
end


% Xingyu's code
function [H_rows H_cols] = translate_alist_to_hrows_hcols(tmp_path)

alistfile = [tmp_path 'tmpfile.alist'];
fid = fopen(alistfile, 'r');

dim = fscanf(fid, '%d', [1,2]);
cols=dim(2); rows = dim(1);

max_weight= fscanf(fid, '%d', [1,2]);
max_col_weight=max_weight(2); max_row_weight=max_weight(1);

row_weight = fscanf(fid, '%d', [1,rows]);
col_weight = fscanf(fid, '%d', [1,cols]);


H_rows = fscanf(fid, '%d', [max_row_weight, rows])';
H_cols = fscanf(fid, '%d', [max_col_weight, cols])';


fclose(fid);

end



%%%%%% forming h matrix filename

% get scenario name from sim_param.filename
function h_mat_full_path = form_h_matrix_full_path( sim_param, cml_home )

scen_name = get_scen_name(sim_param);

h_matrix_path = form_h_matrix_path( cml_home, scen_name );

[ h_matrix_filename ]= form_h_matrix_filename(sim_param.filename);

h_mat_full_path = [h_matrix_path filesep h_matrix_filename];

end


function scen_name = get_scen_name(sim_param)

[a b] = strtok(sim_param.filename, '/'); [c d] = strtok(b, '/');

scen_name = c;

end


function h_matrix_path = form_h_matrix_path( cml_home, scen_name )

h_matrix_path = [cml_home filesep 'output' filesep scen_name filesep...
    'supp' filesep 'hmat' ];

id = 'MATLAB:MKDIR:DirectoryExists';

warning('off', id);

mkdir(h_matrix_path); % create directory if it doesn't exist

end

function filename = form_h_matrix_filename(path_filename)

% get output filename sans extension
[a b] = strtok( path_filename(end:-1:1), '/');
[c d ] = strtok( a(end:-1:1), '.');

filename = [c '_hmat.mat'];

end

%%%%%%%%%%%%%%%%%%% h matrix filename



function [H_rows H_cols] = gen_random_ldpc_code(C, K, dv2, dv3, a2new, a3new, ...
    cml_home, h_mat_full_path)

[ldpc_code_gen_path tmp_path] =...
    create_path_to_tmp_gen_directory(cml_home);

create_ldpc_pchk_file( C, K, dv2, dv3, a2new, a3new,...
    tmp_path, ldpc_code_gen_path);

create_ldpc_alist_file(ldpc_code_gen_path, tmp_path);

[H_rows H_cols] = translate_alist_to_hrows_hcols( tmp_path );

% if cluster
loc = determine_location;

if strcmp(loc, 'cluster')
    save_hmat_cluster( h_mat_full_path, H_rows, H_cols );    
elseif strcmp(loc, 'local')
    save(h_mat_full_path,'H_rows','H_cols');
end

end



function loc = determine_location()
[a hostname] = system('hostname');
if strcmp( hostname(1:end-1) , 'wcrlCluster')
    loc = 'cluster';
else
    loc = 'local';
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


function [ldpc_code_gen_path tmp_path] = create_path_to_tmp_gen_directory(cml_home)

ldpc_code_gen_path = [cml_home filesep 'module' filesep 'chan_code'...
    filesep 'ldpc' filesep 'code_gen' filesep];

loc = determine_location;
if strcmp(loc, 'cluster')
    tmp_path = [filesep 'home' filesep 'pcs' filesep 'tmp'];    
elseif strcmp(loc, 'local')
    tmp_path = [ldpc_code_gen_path 'tmp' filesep];
end

end



function create_ldpc_pchk_file( C, K, dv2, dv3, a2new, a3new,...
    tmp_path, ldpc_code_gen_path)

% create ldpc creation command string
sp = [' '];
p1 = ['make-ldpc'];   % command name
p2 = [tmp_path 'tmpfile.pchk'];  % temporary filename
p3 = int2str(C);        % number of check nodes
p4 = int2str(K);        % number information bits
p5 = ['3'];             % random number generation method
p6 = ['evenboth'];
p7 = [num2str(a2new) 'x' int2str(dv2)]; % degree dist 2
p8 = ['/'];
p9 = [num2str(a3new) 'x' int2str(dv3)]; % degree dist 3

% invoke external command to generate ldpc code
cmd = [ldpc_code_gen_path p1 sp p2 sp p3 sp p4 sp p5 sp p6 sp p7 p8 p9];

system(cmd);

end


function create_ldpc_alist_file(ldpc_code_gen_path, tmp_path)
% create alist creation command string
sp = [' '];
p1 = ['pchk-to-alist'];   % command name
p2 = [tmp_path 'tmpfile.pchk'];  % temporary filename
p3 = [tmp_path 'tmpfile.alist'];

% invoke external command to generate alist file
cmd = [ldpc_code_gen_path p1 sp p2 sp p3];
system(cmd);
end
