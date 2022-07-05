#!/bin/bash

# params

QUERY_NUMBER=$1

# NAME=("" "FlatMap-CurrencyConversion" "Filter" "window" "avg" "window" "window" "window" "window")

OPERATOR_NAME="rescale"

AUCTION_TOPIC=auction_nexmark_par_3
PERSON_TOPIC=person_nexmark_par_3
BID_TOPIC=bid_nexmark_par_3
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
KAFKA_SERVERS=slave011:9092

JAR_PATH=/home/zhongweichang/meces/Meces-on-Flink/flink-examples/flink-examples-streaming/target/flink-examples-streaming_2.11-1.12.0-NexmarkQ${QUERY_NUMBER}.jar

DEFAULT_PARA=1

INTERVAL=50 # milli seconds
WINDOW_STEP=100 # milli seconds
WINDOW_SIZE=2 # seconds
NATIVE_FLINK=false

DEFAULT_PARA=1
COUNT_PARA=1
SINK_INTERVAL=1000

KAFKA_CLASSPATH=file:///home/zhongweichang/meces/Meces-on-Flink/flink-connectors/flink-connector-kafka/target/flink-connector-kafka_2.11-1.12.0.jar
BYTE_CLASSPATH=file:///home/zhongweichang/.m2/repository/org/apache/kafka/kafka-clients/2.4.1/kafka-clients-2.4.1.jar
# submit job
JOB_PARAMS="
-C ${KAFKA_CLASSPATH} \
-C ${BYTE_CLASSPATH} \
-d \
-p ${DEFAULT_PARA} \
${JAR_PATH} \
-kafkaServers ${KAFKA_SERVERS} \
-wordfile ${WORDFILE_PATH} \
-interval ${INTERVAL} \
-auctionTopic ${AUCTION_TOPIC} \
-personTopic ${PERSON_TOPIC} \
-bidTopic ${BID_TOPIC} \
-counterPar ${COUNT_PARA} \
-sinkInterval ${SINK_INTERVAL} \
-windowStep ${WINDOW_STEP} \
-nativeFlink ${NATIVE_FLINK} \
-windowSize ${WINDOW_SIZE}"

echo "${JOB_PARAMS}"

SUBMIT_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink run ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}

sleep 20

# rescale
/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink rescale -rmd 3 -rpl ["${OPERATOR_NAME}":2]  ${JOB_ID}

sleep 1000
exit 0

SAVEPOINT_PATH=hdfs://slave201:9000/user/yinhan/flink_checkpoints/
STOP_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink stop -p ${SAVEPOINT_PATH} ${JOB_ID}`
SAVEPOINT_PATH=${STOP_OUTPUT##*Savepoint completed. Path: }
echo ${SAVEPOINT_PATH}
WINDOW_PARA=30
COUNT_PARA=30
JOB_PARAMS="
-C ${KAFKA_CLASSPATH} \
-C ${BYTE_CLASSPATH} \
-d \
-p ${DEFAULT_PARA} \
${JAR_PATH} \
-kafkaServers ${KAFKA_SERVERS} \
-wordfile ${WORDFILE_PATH} \
-interval ${INTERVAL} \
-auctionTopic ${AUCTION_TOPIC} \
-personTopic ${PERSON_TOPIC} \
-bidTopic ${BID_TOPIC} \
-counterPar ${COUNT_PARA} \
-sinkInterval ${SINK_INTERVAL} \
-windowStep ${WINDOW_STEP} \
-windowSize ${WINDOW_SIZE}"

SUBMIT_OUTPUT=`/home/zhongweichang/meces/Meces-on-Flink/build-target/bin/flink run -s ${SAVEPOINT_PATH} ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}
