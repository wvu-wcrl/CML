function I = J2(sigma)
% J2 computes the mutual information approximation J() found in
%
%   S. ten Brink, G. Kramer, and A. Ashikhmin, “Design of low-density
%   parity-check codes for modulation and detection,” IEEE Trans. Com-
 %  mun., vol. 52, pp. 670–678, Apr. 2004.
%
%
% The calling syntax is:
%    I = J2(sigma)
%
%     Inputs
%     sigma       = X;L_ch(Y)
%
%     Outputs
%     I               = mutual information
%
%     Copyright (C) 2012, Xingyu Xiang, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 9/4/2012

    % Any input argument > 10 should return 1.
    % Arguments >> 10 fail by causing J2() to return infinity.
    % The following statement prevents this behavior by clipping
    %  arguments larger than 10, consistent with Brink's definition.
    %  Terry 3/2013
    sigma(sigma>=10) = 10;   
    
    sigma_threshold = 1.6363;
    sigma = reshape(sigma,length(sigma),1);
    s = [sigma.^3 sigma.^2 sigma ones(size(sigma))];
    a = [-0.0421061 0.209252 -0.00640081 0];
    b = [0.00181491 -0.142675 -0.0822054 0.0549608];
    I = s*a'.*(sigma>=0 & sigma<=sigma_threshold)...
        +(1-exp(s*b')).*(sigma>sigma_threshold & sigma<=10)...
        +1.0*(sigma>10);
end





%     Function J2 is part of the Iterative Solutions Coded Modulation
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
