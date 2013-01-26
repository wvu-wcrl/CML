% DegreeDist.m
% Computes valid LDPC degree distributions under the following
%  assumptions:
%
%  Distinct variable node degrees D = 3
%  d_v1 = 2
%
%  Inputs
%    d_v2_r      range of requested d_v2 values
%    d_v3_r      range of requested d_v3 values
%    d_c         check node degree
%    N           LDPC codeword length
%    K           information sequence length
%
%   Outputs
%    d_v1
%    d_v2_v      valid d_v2 values      Mx1
%    d_v3_v      valid d_v3 values      Mx1
%    a_1         fraction of nodes      Mx1
%                having degree d_v1_v   Mx1
%    a_2         fraction of nodes      Mx1
%                having degree d_v2_v
%    a_3         fraction of nodes      Mx1
%                having degree d_v3_v
%
%
%     Example:
%     >> [d_v1 d_v2_v d_v3_v a_1 a_2 a_3] = ...
%          DegreeDist([3:4], [1:25], 11, 64800, 38880);
%
%     Copyright (C) 2012, Terry R. Ferrett and Matthew C. Valenti
%
%     Last updated on August 12/04/2012.
function [d_v1 d_v2_v d_v3_v a_1 a_2 a_3] = ...
    DegreeDist(d_v2_r, d_v3_r, d_c, N, K)



% number of requested variable node degrees
num_d_v2_r = length(d_v2_r);
num_d_v3_r = length(d_v3_r);


% set d_v1 and a_1
d_v1 = 2;
a_1 = (N-K)/N;
c1 = d_v1*N/( (N-K)*d_c );
b = [1-a_1; 1 - a_1*c1];


vc = 1;
for k = 1:num_d_v2_r,
    for m = 1:num_d_v3_r,
        
        %%% compute a_2 and a_3
        c_2 = d_v2_r(k)*N/( (N-K)*d_c );
        c_3 = d_v3_r(m)*N/( (N-K)*d_c );
        
        C = [1 1;
            c_2 c_3];
        
        warning off;   % disable warnings regarding matrix singularity
        A = C\b;    
        warning on;
        
        %%% check for valid a_2 and a_3
        dont_save = check_valid_degree_dist(A, N);
        
        
        %%% record degree distribution if valid
        if(~dont_save)
            a_1(vc) = a_1(1);
            a_2(vc) = A(1);
            a_3(vc) = A(2);
            
            d_v1(vc) = d_v1(1);
            d_v2_v(vc) = d_v2_r(k);
            d_v3_v(vc) = d_v3_r(m);
            vc = vc + 1;
        end
    end
end

no_distributions_found = ~exist('a_2', 'var');

if( no_distributions_found )
    error('No valid degree distributions found.');
end

for k= 1:vc-1,
fprintf('[%5.4f %5.4f %5.4f]\n', a_1(k), a_2(k), a_3(k));
end

fprintf('\n');
for k= 1:vc-1,
fprintf('[ %d  %d  %d ]\n', d_v1(k), d_v2_v(k), d_v3_v(k));
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
