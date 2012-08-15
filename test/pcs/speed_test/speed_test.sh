#!/bin/bash


# inputs
SCENARIO=$1
RECORD=$2
CML_ROOT=$3
OUTPUT=$CML_ROOT/output/$SCENARIO

ROOT=`pwd`
TIMING=$ROOT/timing
RUNSIM=$ROOT/runsim

TD_1=timedata1.mat
TD_2=timedata2.mat
TD_1P=$TIMING/$TD_1
TD_2P=$TIMING/$TD_2


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


clear_scenario_output
clear_timing

start_local_sim $SCENARIO $RECORD

start_cluster_sim $SCENARIO $RECORD

wait_for_file $TD_1P
wait_for_file $TD_2P


compute_timing_statistics