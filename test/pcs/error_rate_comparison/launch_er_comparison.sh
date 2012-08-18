#!/bin/bash
# launch_er_comparison.sh
#
# Execute CML simulation records using cluster and single-core operation.
#
# Inputs
#  1. CML Scenario
#  2. Record 1
#  3. Record 2
#  4. Path to CML Root
#
#  Calling Example
#   > ./launch_er_comparison.sh t_BerSim 1 2 /home/tferrett/cml
#                                                               
#     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti   
#     For full copyright information see the bottom of this file.

# inputs
SCENARIO=$1
RECORD_S=$2
RECORD_C=$3
CML_ROOT=$4


# paths to cml root and output directory
ROOT=`pwd`


# paths under speed test root
TIMING=$ROOT/er_results
RUNSIM=$ROOT/runsim


# screen session names
SINGLE_SIM=$SCENARIO\_$RECORD_S"S"
CLUSTER_SIM=$SCENARIO\_$RECORD_C"C"


#### functions         
start_local_sim(){
screen -S $SINGLE_SIM -m -d matlab -r "cd $RUNSIM; singlecore_er('$SCENARIO',$RECORD_S,'$CML_ROOT')"
}


start_cluster_sim(){
screen -S $CLUSTER_SIM -m -d matlab -r "cd $RUNSIM; cluster_er('$SCENARIO',$RECORD_C,'$CML_ROOT')"
}


# main execution flow (continuous)
clear_timing

start_local_sim $SCENARIO $RECORD_S
start_cluster_sim $SCENARIO $RECORD_C



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


