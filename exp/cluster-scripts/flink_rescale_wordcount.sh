#!/bin/bash

# params

#OPERATOR_NAME=FlatMap-Splitter
OPERATOR_NAME="FlatMap-Counter -> Appender -> Sink: Sink"

#JAR_PATH=/home/yinhan/flink-exp/target/exp-1.0-SNAPSHOT.jar
JAR_PATH="/home/zhongweichang/meces/Meces-on-Flink/flink-examples/flink-examples-streaming/target/flink-examples-streaming_2.11-1.12.0-RescaleWordCount.jar"

DEFAULT_PARA=1
COUNT_PARA=2

#WORDFILE_PATH=/home/yinhan/flink-exp/data/SingleWord
#WORDFILE_PATH=/home/yinhan/flink-exp/data/InTheEnd
WORDFILE_PATH=/home/zhongweichang/code/exp/data/Sonnet-12-words
INTERVAL=5 # milli sedcons
USEDICTIONARY=true
PARTIALPAUSE=true
# COUNTER_LOOPS=450
COUNTER_LOOPS=0
COUNTER_MAX_PAPA=128
SOURCE_RATE=40
SINK_INTERVAL=1000
KAFKA_HOST=slave011
KAFKA_PORT=9092
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
# KAFKA_SERVERS=slave203:9092
# KAFKA_SERVERS=slave207:9092,slave208:9092,slave209:9092
KAFKA_SERVERS=slave011:9092
TOPIC=tt_par_3
EARLIEST=false
NATIVE_FLINK=false

KAFKA_CLASSPATH=file:///home/zhongweichang/meces/Meces-on-Flink/flink-connectors/flink-connector-kafka/target/flink-connector-kafka_2.11-1.12.0.jar
BYTE_CLASSPATH=file:///home/zhongweichang/.m2/repository/org/apache/kafka/kafka-clients/2.4.1/kafka-clients-2.4.1.jar
# submit job
JOB_PARAMS="
-C ${KAFKA_CLASSPATH} \
-C ${BYTE_CLASSPATH} \
-d \
-p ${DEFAULT_PARA} \
${JAR_PATH} \
-wordFile ${WORDFILE_PATH} \
-interval ${INTERVAL} \
-useDictionary ${USEDICTIONARY} \
-partialPause ${PARTIALPAUSE} \
-counterCostlyOperationLoops ${COUNTER_LOOPS} \
-KafkaHost ${KAFKA_HOST} \
-KafkaPort ${KAFKA_PORT} \
-kafkaServers ${KAFKA_SERVERS} \
-topic ${TOPIC} \
-startFromEarliest ${EARLIEST} \
-counterPar ${COUNT_PARA} \
-counterMaxPara ${COUNTER_MAX_PAPA} \
-sinkInterval ${SINK_INTERVAL} \
-nativeFlink ${NATIVE_FLINK} \
-sourceRate ${SOURCE_RATE} \
-defaultPar ${DEFAULT_PARA}"


SUBMIT_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink run ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}

# read WAIT_CHAR
sleep $1
# sleep 30
# rescale
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 3 -rpl ["${OPERATOR_NAME}":3]  ${JOB_ID}
sleep $2
echo `/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink cancel ${JOB_ID}`
echo "backup information ${JOB_ID}"
exit 0
#read WAIT_CHAR
SAVEPOINT_PATH=hdfs://slave201:9000/user/yinhan/flink_checkpoints/
STOP_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink stop -p ${SAVEPOINT_PATH} ${JOB_ID}`
SAVEPOINT_PATH=${STOP_OUTPUT##*Savepoint completed. Path: }
echo ${SAVEPOINT_PATH}

COUNT_PARA=30
JOB_PARAMS="
-C ${KAFKA_CLASSPATH} \
-C ${BYTE_CLASSPATH} \
-d \
-p ${DEFAULT_PARA} \
${JAR_PATH} \
-wordFile ${WORDFILE_PATH} \
-interval ${INTERVAL} \
-useDictionary ${USEDICTIONARY} \
-partialPause ${PARTIALPAUSE} \
-counterCostlyOperationLoops ${COUNTER_LOOPS} \
-KafkaHost ${KAFKA_HOST} \
-KafkaPort ${KAFKA_PORT} \
-kafkaServers ${KAFKA_SERVERS} \
-topic ${TOPIC} \
-startFromEarliest ${EARLIEST} \
-counterPar ${COUNT_PARA} \
-counterMaxPara ${COUNTER_MAX_PAPA} \
-sinkInterval ${SINK_INTERVAL} \
-nativeFlink ${NATIVE_FLINK} \
-sourceRate ${SOURCE_RATE} \
-defaultPar ${DEFAULT_PARA}"
SUBMIT_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink run -s ${SAVEPOINT_PATH} ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}


#sleep 5
#/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 3 -rp 2 ${JOB_ID}
:<<!
sleep 5
echo rescale -1
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd -1 ${JOB_ID}
sleep 2
echo rescale 0
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 0 -rpl [${OPERATOR_NAME}:1] ${JOB_ID}
sleep 2
echo rescale 1
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 1 ${JOB_ID}
sleep 2
echo rescale 2
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 2 ${JOB_ID}
!
:<<!
sleep 2
echo rescale 0
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 0 -rpl [Map:2] ${JOB_ID}
sleep 2
echo rescale 1
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 1 ${JOB_ID}
sleep 2
echo rescale 2
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 2 ${JOB_ID}

!

