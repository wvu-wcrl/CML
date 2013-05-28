% DegreeDist.m
% Computes valid LDPC degree distributions under the following
%  assumptions:
%
%  Any number of constrained degrees
%  Two free degrees
%
%  Example: WiMax
%   dv,1 = 2
%   dv,2 = 3
%   dv,3 = <free>
%   dv,4 = <free>
%
%
%  Inputs
%    dv_cn       M constrained degrees
%                Mx1
%    a_cn        Mx1 constrained degree distributions
%    d_v1_r      Range of requested degrees for free degree 1
%    d_v2_r      Range of requested degrees for free degree 2
%    d_c         check node degree
%    N           LDPC codeword length
%    K           information sequence length
%
%   Outputs
%    dv_out      Nx(M+2) matrix of valid degree tuples
%    a_out       Nx(M+2) matrix of degree distributions
%
%
%     Example:
%
%     >> [dv_out a_out] = ...
%           DegreeDist( [2;3], [[1:25], [1:25], 11, 64800, 38880 )
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on August 12/04/2012.
function [ dv_cn d_vDm1_v d_vD_v a_cn a_Dm1 a_D ] = ...
    DegreeDist(dv_cn, a_cn, d_v1_r, d_v2_r,  d_c, N, K)


% number of constrained degrees
n_cn = length(dv_cn);

% number of requested variable node degrees
num_d_v1_r = length(d_v1_r);
num_d_v2_r = length(d_v2_r);


%%% compute constants
c1 = 1 - sum(a_cn);
c2 = (N-K)/N*d_c - sum( dv_cn.*a_cn );

c = [c1 ; c2 ];
%%%

vc = 1;
for k = 1:num_d_v1_r,
    for m = 1:num_d_v2_r,        
        
        % form D
        D = [ 1       1;
            d_v1_r(k)  d_v2_r(m) ];
        
        warning off;   % disable warnings regarding matrix singularity
        A = D\c;
        warning on;
        
        %%% check for valid a's
        dont_save = check_valid_degree_dist(A, N);
        
        
        %%% record degree distribution if valid
        if(~dont_save)
            a_Dm1(vc) = A(1);
            a_D(vc) = A(2);            
            
            d_vDm1_v(vc) = d_v1_r(k);
            d_vD_v(vc) = d_v2_r(m);
            vc = vc + 1;
        end
    end
end

no_distributions_found = ~exist('a_Dm1', 'var');

if( no_distributions_found )
    error('No valid degree distributions found.');
end

for k= 1:vc-1,
    fprintf('[ ');
    for m = 1:n_cn,
        fprintf('%5.4f ', a_cn(m));
    end    
fprintf('%5.4f %5.4f ]\n', a_Dm1(k), a_D(k));
end



fprintf('\n');
for k= 1:vc-1,
    fprintf('[ ');
    for m = 1:n_cn,
        fprintf('%d ', dv_cn(m));
    end    
fprintf('%d %d ]\n', d_vDm1_v(k), d_vD_v(k));
end

end


function skip = check_valid_degree_dist(C, N)
% consistency check
skip = 0;

% check for infinities
f1= isnan(C(1));
f2= isnan(C(2));
if( f1 | f2 )
    skip = 1;
end

% check for negative values
if ( ~skip)
    f1 = C(1) < 0;
    f2 = C(2) < 0;
    if ( f1 | f2 )
        skip = 1;
    end
end



% check for zero values
if ( ~skip)
    f1 = C(1) < 10^(-4);
    f2 = C(2) < 10^(-4);
    if ( f1 | f2 )
        skip = 1;
    end
end


if( ~skip )
    % check for non-integer numbers of VNDs
    rem_C1 = rem(C(1)*N, 1);
    rem_C2 = rem(C(2)*N, 1);
    
    f1 = rem_C1 ~= 0;
    f2 = rem_C2 ~= 0;
    
    if rem_C1 < 10^(-4) | 1 - rem_C1 < 10^(-4)
        f1 = 0;
    end
    
    if rem_C2 < 10^(-4) | 1 - rem_C2 < 10^(-4)
        f2 = 0;
    end
    
    if ( f1 | f2 )
        skip = 1;
    end
end
end




%     Function DegreeDist is part of the Iterative Solutions Coded Modulation
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
