function sigma = invJ1(I)
% invJ1 computes the inverse mutual information function found in
%
%   S. ten Brink, G. Kramer, and A. Ashikhmin, “Design of low-density
%   parity-check codes for modulation and detection,” IEEE Trans. Com-
 %  mun., vol. 52, pp. 670–678, Apr. 2004.
%
%
% The calling syntax is:
%    sigma = invJ1(I)
%
%     Inputs
%     I               = mutual information
%
%     Outputs
%     sigma       = inverse mutual information
%
%     Copyright (C) 2012, Xingyu Xiang, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 9/4/2012

    sigma = (-1.0/0.3037*log2(1.0-I.^(1.0/1.1064))).^(1.0/(2.0*0.8935));
end



%     Function invJ1 is part of the Iterative Solutions Coded Modulation
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
