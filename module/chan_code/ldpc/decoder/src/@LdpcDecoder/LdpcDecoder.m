% Class LdpcDecoder defines an LDPC decoder which operates
%  under both BICM and BICM-ID decoding frameworks.
%
%
% Public Interface
%
%   Create object.
%     [obj] = LdpcDecoder()
%
%   Create Tanner Graph.
%     [obj] = CreateTannerGraph(obj, row_one, col_one, CodeLength)
%       where
%         row_one          
%         col_one
%         CodeLength       Bits per codeword
%         
%   Initialize Tanner Graph state.
%     [obj] = InitState(obj, input_decoder_c)
%       where
%          input_decoder_c  Extrinsic information from SOMAP
%   
%   Perform decoding iteration.
%     [obj output_decoder_c detected_data] =
%       Iterate(obj, input_decoder_c iter)
%        where
%          output_decoder_c  Decoded extrinsic information
%          detected_data     Data detected for current iteration 
%          
%          input_decoder_c   Extrinsic information from SOMAP
%          iter              Current iteration
%
%
%   Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti
%
%     Last updated on 11/14/2012


classdef LdpcDecoder < handle
    
    properties
        v_nodes            % tanner graph
        c_nodes
        
        row_one            % H-matrix information
        col_one
        
        CodeLength         % codeword length
        NumberParityBits   % parity bits per codeword
    end
        
    
    methods (Access = public)    
        
        % create ldpc decoder object
        function obj = LdpcDecoder()
        end
        
    
        % create tanner graph data structures
        function [obj] = CreateTannerGraph( obj, row_one, col_one, CodeLength)
            
            obj.CodeLength = CodeLength;
            obj.row_one = row_one;
            obj.col_one = col_one;
            [obj.NumberParityBits max_row_weight] = size( row_one );
            [NumberCodeBits max_col_weight] = size( col_one );
            
            [obj c_nodes] = CreateCNodes( obj, max_row_weight);
            [obj v_nodes] = CreateVNodes( obj, max_col_weight, NumberCodeBits);
            
            obj.c_nodes = c_nodes;
            obj.v_nodes = v_nodes;
            
        end
        
        % initialize tanner graph state
        % called for each received codeword on first decoding iteration
        function obj = InitState( obj, input_decoder_c )
            InitState_mx( input_decoder_c, obj.row_one, ...
                obj.col_one, obj.v_nodes, ...
                obj.c_nodes, obj.NumberParityBits);
        end
        
        
        % perform a single iteration of ldpc decoding
        % return decoded extrinsic information
        %        detected data
        function [obj output_decoder_c detected_data] =...
                Iterate(obj, input_decoder_c,...
                iter)
            
            if iter == 1,
                InitState( obj, -input_decoder_c );
            end
            
            [output_decoder_c detected_data] = ...
                Iterate_mx( input_decoder_c, obj.v_nodes, obj.c_nodes,...
                obj.NumberParityBits );
        end
          
    
    end
    
    
    methods (Access = private)
        
        % create c-node data structure
        function [obj c_nodes] = CreateCNodes(obj, max_row_weight)
            c_nodes(obj.NumberParityBits).degree = 0;   % preallocate structure
          
            base = (0:max_row_weight-1)*obj.NumberParityBits;
            for k = 1:obj.NumberParityBits,
                
                ind  = base + k;
                count = sum( obj.row_one( ind ) > -1 );
                
                degree = int32(count);
                c_nodes(k).degree = degree;
                c_nodes(k).index = int32(  zeros(1,degree) );
                c_nodes(k).message = single( zeros(1,degree) );
                c_nodes(k).socket = int32(  zeros(1,degree) );
                
            end
        end    
        
        % create v-node data structure
        function [obj v_nodes] = CreateVNodes( obj, max_col_weight, NumberCodeBits)
            v_nodes(obj.CodeLength).degree = 0;      % preallocate structure
            
            base = (0:max_col_weight - 1)*NumberCodeBits;
            for k = 1:obj.CodeLength,
                
                ind = base + k;
                count = sum( obj.col_one( ind ) > -1 );
                
                degree = int32(count);
                v_nodes(k).degree        = degree;
                v_nodes(k).initial_value = single( 1 );
                v_nodes(k).index         = int32( zeros(1, degree) );
                v_nodes(k).socket        = int32( zeros(1, degree) );
                v_nodes(k).message       = single( zeros(1, degree) );
                v_nodes(k).sign          = int32( zeros(1, degree) );
                
            end
        end
          
    end
    
end



%     Class LdpcDecoder is part of the Iterative Solutions Coded Modulati
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