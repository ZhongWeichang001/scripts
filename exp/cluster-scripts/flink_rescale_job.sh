#!/bin/bash

#JAR_PATH=/home/yinhan/flink-exp/target/exp-1.0-SNAPSHOT.jar
JAR_PATH=/home/yinhan/flink-1.12.0/flink-examples/flink-examples-streaming/target/flink-examples-streaming_2.11-1.12.0-RescaleWordCount.jar
DEFAULT_PARA=1

SUBMIT_OUTPUT=`/home/yinhan/flink-1.12.0/build-target/bin/flink run -d -p ${DEFAULT_PARA} ${JAR_PATH}`
:<<!
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}
sleep 5
echo rescale 0
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 0 -rpl [Map,1] ${JOB_ID}
sleep 2
echo rescale 1
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 1 ${JOB_ID}
sleep 2
echo rescale 2
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 2 ${JOB_ID}

sleep 2
echo rescale 0
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 0 -rpl [Map,2] ${JOB_ID}
sleep 2
echo rescale 1
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 1 ${JOB_ID}
sleep 2
echo rescale 2
/home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 2 ${JOB_ID}


!
