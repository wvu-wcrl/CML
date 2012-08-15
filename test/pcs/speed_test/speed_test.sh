#!/bin/bash
# speed_test.sh
# Inputs
#  1. CML Scenario
#  2. Record
#  3. Path to CML Root
#
#  Calling Example
#   > ./speed_test.sh t_BerSim 1 /home/tferrett/cml
#                                                               
#     Copyright (C) 2012, Terry Ferrett and Matthew C. Valenti   
#     For full copyright information see the bottom of this file.

# inputs
SCENARIO=$1
RECORD=$2
CML_ROOT=$3


# paths to cml root and output directory
ROOT=`pwd`
OUTPUT=$CML_ROOT/output/$SCENARIO


# paths under speed test root
TIMING=$ROOT/timing
RUNSIM=$ROOT/runsim


# paths to timing data
TD_1=timedata1.mat
TD_2=timedata2.mat
TD_1P=$TIMING/$TD_1
TD_2P=$TIMING/$TD_2


# screen session names
LOCAL_SIM=$SCENARIO\_$RECORD"L"
CLUSTER_SIM=$SCENARIO\_$RECORD"C"


#### functions         
clear_scenario_output(){
rm $OUTPUT/*
}

clear_timing(){
rm $TIMING/*.mat
}
                                                 
start_local_sim(){
screen -S $LOCAL_SIM -m -d matlab -r "cd $RUNSIM; singlecore('$SCENARIO',$RECORD,'$CML_ROOT','$TD_1P')"
}

start_cluster_sim(){
screen -S $CLUSTER_SIM -m -d matlab -r "cd $RUNSIM; cluster('$SCENARIO',$RECORD,'$CML_ROOT','$TD_2P')"
}

wait_for_file(){
    echo Waiting for $1...
    while [ ! -f $1 ]
    do
        sleep 2
	echo .
    done
}

compute_timing_statistics(){
 matlab -r "cd $TIMING; compute_timing_stats"
}



# main execution flow (continuous)

clear_scenario_output
clear_timing

start_local_sim $SCENARIO $RECORD
start_cluster_sim $SCENARIO $RECORD

wait_for_file $TD_1P
wait_for_file $TD_2P

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


