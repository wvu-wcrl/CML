function y = RateMatch( x, X_i, e_ini, e_plus, e_minus )
% RateMatch performs the basic UMTS/HSDPA Rate Matching algorithm
%
% The calling syntax is:
%     y = RateMatch( x, X_i, e_ini, e_plus, e_minus )
%
%     y = output of rate matching algorithm
%
%     x = input to rate matching algorithm (length X_i)
%     X_i = length of the input
%     e_ini = parameter used by algorithm
%     e_plus = parameter used by algorithm
%     e_minus = parameter used by algorithm
%
% Copyright (C) 2005, Matthew C. Valenti
%
% Last updated on Nov. 28, 2005
%
% Function RateMatch is part of the Iterative Solutions Coded Modulation
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

y = [];

e = e_ini;

y_index = 1;

for m=1:X_i
    e = e - e_minus;
    if (e<=0)        
        e = e + e_plus;
    else
        y(y_index) = x(m);
        y_index = y_index + 1;
    end
end