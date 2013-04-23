function [S, mapping] = CreateConstellation( mod_type, varargin )
% CreateConstellation creates a K-dimensional signal constellation with M points.
%
% The calling syntax is:
%     S = CreateConstellation( mod_type, M, label_type, h )
%
%     S = the K by M complex signal constellation.
%         K is dimensionality, and M is number of symbols
%
%     mod_type = the modulation type, as a string
%         must be 'BPSK', 'QPSK', 'PSK', 'QAM', 'APSK', 'HEX', 'HSDPA', or 'FSK'
%	  [M] = the number of points in the constellation
%         must be a power of 2
%         not needed for 'BPSK' (M=2), 'QPSK' (M=4), or 'HEX' (M=16).  Default for 'FSK' is M=2.
%     [label_type] = the labelling type, may be a string or a vector.
%         strings must be 'gray', 'Antigray', 'SP', 'SSP', 'MSEW',
%        'huangITNr1', 'huangITNr2', 'huangLetterNr1', or 'huangLetterNr2'
%         not needed for BPSK, QPSK, HSDPA, HEX, APSK, or orthogonal FSK (h=1).
%     [h] = modulation index.  Used only for FSK modulation.  Default h=1.
%
% Copyright (C) 2005-2007, Matthew C. Valenti and Shi Cheng
%
% Last updated on Dec. 27, 2007
%
% Function CreateConstellation is part of the Iterative Solutions Coded Modulation
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

% Optional argument: M
if (length(varargin)>=1)
    M = varargin{1};
    % make sure that M is a power of 2.
    if ( nargin > 1 )
        m = log(M)/log(2);
        if ( rem(m,1) )
            error( 'M must be a power of 2' );
        end
    end
else
    % default value
    M = 2;
end

% Optional argument: Label Type
if (length(varargin)>=2)
    label_type = varargin{2};
    if ~ischar( label_type )
        if (length( label_type ) ~= M )
            error( 'Length of label_type must be M' );
        elseif (sum( sort( label_type ) ~= [0:M-1] ) > 0)
            % revised 2-22-07
            error( 'Label_type must contain integers 0 through M-1' );        
        else
            mapping = label_type;
        end
    end
else
    % default value
    mapping = 0:M-1;
    label_type = mapping;
end

% Optional argument: h
if (length(varargin)>=3)
    h = varargin{3};
else
    % default value
    h = 1;
end

% HSDPA modulation
if ( strcmpi( mod_type, 'HSDPA' ) )
    if (M==4) % QPSK
        temp = [1 1
            1 -1
            -1 1
            -1 -1]';
        S = (temp(1,:) + sqrt(-1)*temp(2,:))/sqrt(2);
        mapping = (0:3);
    elseif (M==16) % 16-QAM
        for point=0:15
            temp = point;
            for i=4:-1:1
                bit_vector(4-i+1) = fix( temp/(2^(i-1)) );
                temp = temp - bit_vector(4-i+1)*2^(i-1);
            end
            iq = (-1).^bit_vector;
            % S(1,point+1) = (iq(1)*(2-iq(3)) + sqrt(-1)*iq(2)*(2-iq(4)) )/sqrt(5);
            S(1,point+1) = (iq(1)*(2-iq(3)) + sqrt(-1)*iq(2)*(2-iq(4)) )/sqrt(10);
        end
    else
        error( 'Modulation order must be 4 or 16 for HSDPA' );
    end
elseif ( strcmpi( mod_type, 'BPSK' ) )
    S = [1 -1]; % BPSK
    mapping = 0:1;
elseif ( strcmpi( mod_type, 'QPSK' ) )
    S = [1 +1i -1i -1];  % QPSK
    mapping = 0:3;
elseif  ( strcmpi( mod_type, 'PSK' ) )
    % PSK modulation
    temps = exp( 1i*2*pi * [0:M-1]/M);

    if ischar( label_type )
        switch label_type
            case 'gray'
                mapping = [0,1];
                for m = 2:log2(M)
                    mapping = [mapping, 2^(m-1) + fliplr( mapping )];
                end
            case 'SP'
                if (M == 8)
                    mapping = [ 0,1,2,3,4,5,6,7];
                elseif (M == 4)
                    mapping = [0,1,2,3];
                else
                    error( 'SP coded PSK only supported for M=4 or 8' );
                end
            case 'SSP'
                if M == 8
                    mapping = [ 0, 5, 2, 7 , 4, 1, 6, 3];
                else
                    error( 'SSP coded PSK only supported for M=8' );
                end
            case 'MSEW'
                if M == 8
                    mapping = [ 0,3,5,6,1,2,4,7];
                else
                    error( 'MSEW coded PSK only supported for M=8' );
                end
            otherwise
                error('labeling or symbol set size not supported for PSK');
        end
    end

    S( mapping + 1) = temps; % corrected on 7-25-06
   
elseif ( strcmpi( mod_type, 'HEX' ) ) % HEX modulation
    % only 16-HEX is supported
    if ( nargin > 1 )
        if (M ~= 16)
            error( 'Only 16-HEX supported' )
        end
    end

    % fixed mapping
    S = transpose( [0
        -2
        2
        4
        (-1 +1i*sqrt(3) )
        (-3 +1i*sqrt(3) )
        ( 1 +1i*sqrt(3) )
        ( 3 +1i*sqrt(3) )
        ( 1 -1i*sqrt(3) )
        (-1 -1i*sqrt(3) )
        ( 3 -1i*sqrt(3) )
        (-3 -1i*sqrt(3) )
        (-2 +1i*2*sqrt(3) )
        (   -1i*2*sqrt(3) )
        (   +1i*2*sqrt(3) )
        (-2 -1i*2*sqrt(3) ) ] );

    % normalize
    temps = S/sqrt( mean( abs(S).^2 ) );
    
    % fix mapping
    S(mapping+1) = temps;   
  
elseif ( strcmpi(mod_type, 'APSK' )  )% APSK modulation 
    % inner ring is QPSK with first_angle pi/4
    temps = exp( 1i*( 2*pi*(0:3)/4 + pi/4 ) );
    % mapping is fixed
    if (M==16)
        rho = h(1); % this could be varied
        % outer ring is 12-PSK w/ radius rho
        temps(5:16) = rho*exp( 1i*( 2*pi*(0:11)/12 + pi/12 ));
    elseif (M==32)
        rho1 = h(1);  % these could be varied
        rho2 = h(2);
        % middle and outer rings
        temps(5:16) = rho1*exp( 1i*( 2*pi*(0:11)/12 + pi/12 ));
        temps(17:32) = rho2*exp( 1i*( 2*pi*(0:15)/16 + pi/8 ) );  
    else
        error( 'APSK requires M=16 or 32' );
    end
    
    if ischar( label_type )
        switch label_type
            case 'DVB'
                if (M == 16)
                    % the first two bits are flipped
                    mapping = [0,2,3,1,8,12,4,6,14,10,11,15,7,5,13,9];
                elseif (M == 32)
                    mapping=[17,21,23,19,16,0,1,5,4,20,22,6,7,3,2,18,...
                        8, 25,9,13,29,12,28,30,14,31,15,11,27,10,26,24];
                else
                    error( 'DVB-S2 coded APSK only supported for M=16 or 32' );
                end
            otherwise
                error('Currently only DVB labeling is supported for APSK');
        end
    end
    % mapping is fixed
    S(mapping+1) = temps;

    % normalize
    S = S/sqrt( mean( abs(S).^2 ) );
    
elseif ( strcmpi( mod_type, 'QAM') )% QAM modulation
    if ( M == 32)
        % the mapping is not right here (just CM capacity)
        S(1:4) =  ((-3:2:3)'+1i*5) ;
        S(5:10) =  ((-5:2:5)'+1i*3) ;
        S(11:16) =  ((-5:2:5)'+1i*1) ;
        S(17:32) = conj(S(1:16));
        % normalize
        temps = S/sqrt( mean( abs(S).^2 ) );
         
        % mapping is fixed (added on 12-27-07)    
        S(mapping+1) = temps;   
        return;
    end

    t = (- sqrt(M) +1) :2: (sqrt(M) - 1);
    temps = ones( sqrt(M), 1) * t;
    temps = temps - 1i*temps';
    temps = reshape( temps.', 1, M);
    % fprintf( 'Energy = %f\n', mean( abs(temps/2).^2 ) );
    
    if (ischar( label_type )&&(nargin>=3) )
        switch label_type
            case 'gray'
                if M == 16
                    mapping = [ 15, 11, 3, 7, 14, 10, 2, 6, 12, 8, 0, 4, 13, 9, 1, 5 ];
                    S( mapping + 1) = temps;
                elseif M == 64
                    submapping = [0, 1, 3, 2, 6, 7, 5, 4];
                    tempmapping =  ones(sqrt(M), 1) *submapping;
                    tempmapping = sqrt(M)*tempmapping + flipud( tempmapping.');

                    mapping = reshape( tempmapping.', 1, M);

                    S( mapping + 1) = temps;
                elseif M == 256
                    submapping = [ [0, 1, 3, 2, 6, 7, 5, 4] , 8+[0, 1, 3, 2, 6, 7, 5, 4]];
                    tempmapping =  ones(sqrt(M), 1) *submapping;
                    tempmapping = sqrt(M)*tempmapping + flipud( tempmapping.');

                    mapping = reshape( tempmapping.', 1, M);

                    S( mapping + 1) = temps;
                else
                    error( 'Gray mapping for QAM only supported for M=16,64, or 256' );
                end
            case 'SP'
                if M == 16
                    mapping = [ 8, 13, 12, 9, 15, 10, 11, 14, 4, 1, 0, 5, 3, 6, 7, 2];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case 'MSP'
                if M == 16
                    mapping = [ 8, 11, 12, 15, 1, 2, 5, 6, 4, 7, 0, 3, 13, 14, 9, 10];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case 'MSEW'
                if M == 16
                    mapping = [ 2, 1, 7, 4, 8, 11, 13, 14, 5, 6, 0, 3, 15, 12, 10, 9];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case 'Antigray'
                if M == 16
                    mapping = [ 2, 14, 6, 10, 1, 13, 5, 9, 3, 15, 7, 11, 0, 12, 4, 8];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case  'huangITNr1'
                if M == 16
                    mapping = [ 7, 14, 1, 11, 13, 4, 8, 2, 10, 3, 15, 5, 0, 9, 6, 12];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case 'huangITNr2'
                if M == 16
                    mapping = [ 12, 10, 5, 6, 15, 9, 3, 0, 2, 4, 14, 13, 1, 7, 8, 11];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case  'huangLetterNr1'
                if M == 16
                    mapping = [ 13, 7, 1, 11, 14, 4, 2, 8, 3, 9, 15, 5, 0, 10, 12, 6];
                    S( mapping + 1) = temps;
                else
                    error( 'Modulation not supported' );
                end
            case 'huangLetterNr2'
                if M == 16
                    mapping = [ 12, 15, 10, 9, 5, 6, 3, 0, 11, 8, 13, 14, 2, 1, 4, 7];

                else
                    error( 'Modulation not supported' );
                end
            otherwise
                error('labeling or symbol set size not supported for QAM');
        end
    end
    S( mapping + 1) = temps;

    % normalize
    S = S/sqrt( mean( abs(S).^2 ) );
elseif ( strcmpi( mod_type, 'FSK' ) )
    if (h==1)
        % orthogonal FSK
        temps = eye( M );
    else
        % nonorthogonal FSK
        for m = 1:M
            for n = 1:M
                temps(n,m) = sinc((m-n)*h)* exp(-1i*pi*(m-n)*h);
            end
        end
    end

    if ischar( label_type )
        if ( strcmpi( label_type, 'gray'  ) )
            mapping = [0,1];
            for m = 2:log2(M)
                mapping = [mapping, 2^(m-1) + fliplr( mapping )];
            end
        elseif ( strcmpi( label_type, 'mv' ) )
            if ( M == 8 )
                mapping = [6 1 0 3 2 5 4 7];
            elseif ( M == 16 )
                mapping = [0 2 14 12 11 9 5 7 6 4 8 10 13 15 3 1];
            else
                error( 'dt mapping only supported for M=8 and M=16' );
            end
        elseif ( strcmpi( label_type, 'dt' ) )
            if ( M == 8 )
                % mapping = [6 1 0 3 2 5 4 7];
                mapping = [2 1 4 3 6 5 0 7];
            elseif ( M == 16 )
                % mapping = [0 2 14 12 11 9 5 7 6 4 8 10 13 15 3 1];
                mapping = [0 15 1 14 9 6 8 7 10 5 11 4 3 12 2 13];
            else
                error( 'dt mapping only supported for M=8 and M=16' );
            end
        elseif ( strcmpi( label_type, 'gray2' ) )
            if ( M ~= 8 )
                error( 'gray2 mapping only supported for M=8' );
            else
                mapping = [0 1 5 7 3 2 6 4];
            end
        elseif ( strcmpi( label_type, 'gray3' ) )
            if ( M ~= 8 )
                error( 'gray3 mapping only supported for M=8' );
            else
                mapping = [0 1 5 4 6 7 3 2];
            end
        elseif ( strcmpi( label_type, 'gray4' ) )
            if ( M ~= 8 )
                error( 'gray4 mapping only supported for M=8' );
            else
                mapping = [0 1 5 4 6 2 3 7];
            end
        elseif ( strcmpi( label_type, 'gray5' ) )
            if ( M ~= 8 )
                error( 'gray5 mapping only supported for M=8' );
            else
                mapping = [0 1 3 7 5 4 6 2];
            end
        elseif ( strcmpi( label_type, 'gray6' ) )
            if ( M ~= 8 )
                error( 'gray6 mapping only supported for M=8' );
            else
                mapping = [0 1 3 2 6 4 5 7];
            end
        elseif (strcmpi( label_type, 'reversegray' ) )
            if (M==8)
                mapping = [0 1 3 2 7 6 4 5];
            elseif (M==16)
                mapping = [0 1 3 2 7 6 4 5 15 14 12 13 8 9 11 10];
            else
                error( 'reversegray mapping only supported for M=8 or 16' );
            end

        else
            % natural mapping
            mapping = 0:M-1;
        end
    end

    % mapping: rearrange rows
    S( :, mapping + 1 ) = temps;

else
    error('Modulation and/or labeling not supported');
end



