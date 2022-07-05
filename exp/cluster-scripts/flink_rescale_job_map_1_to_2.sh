#!/bin/bash


SUBMIT_OUTPUT=`/home/yinhan/flink-1.12.0/build-target/bin/flink run -d -p 2 /home/yinhan/flink-exp/target/exp-1.0-SNAPSHOT.jar`
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



