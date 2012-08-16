#!/bin/bash
# compute_timing_results.sh
#
# Compute timing results of cluster speed test.
#
#                                                               
#     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti   
#     For full copyright information see the bottom of this file.


# paths to cml root and output directory
ROOT=`pwd`

# paths under speed test root
TIMING=$ROOT/timing

compute_timing_statistics(){
 matlab -r "cd $TIMING; compute_timing_stats"
}

# main execution flow (continuous)
 
compute_timing_statistics



#     This library is free software;                                            
#     you can redistribute it and/or modify it under the terms of               
#     the GNU Lesser General Public License as published by the                 
#     Free Software Foundation; either version 2.1 of the License,              
#     or (at your option) any later version.                                    
#                                                                               
#     This library is distributed in the hope that it will be useful,           
#     but WITHOUT ANY WARRANTY; without even the implied warranty of            
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU         
#     Lesser General Public License for more details.                           
#                                                                               
#     You should have received a copy of the GNU Lesser General Public          
#     License along with this library; if not, write to the Free Software       
#     Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  US


