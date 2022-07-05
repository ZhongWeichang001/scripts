#!/bin/bash

# params

QUERY_NUMBER=7

OPERATOR_NAME="window"
AUCTION_TOPIC=auction_nexmark_par_25
PERSON_TOPIC=person_nexmark_par_25
BID_TOPIC=bid_nexmark_par_25
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
KAFKA_SERVERS=slave203:9092

JAR_PATH=/home/yinhan/flink-1.12.0/flink-examples/flink-examples-streaming/target/flink-examples-streaming_2.11-1.12.0-NexmarkQ${QUERY_NUMBER}.jar

DEFAULT_PARA=25

INTERVAL=50 # milli seconds
WINDOW_STEP=10000 # milli seconds
WINDOW_SIZE=10 # seconds

DEFAULT_PARA=25
OP_PARA=25
SINK_INTERVAL=1000
NATIVE_FLINK=true

KAFKA_CLASSPATH=file:///home/yinhan/flink-1.12.0/flink-connectors/flink-connector-kafka/target/flink-connector-kafka_2.11-1.12.0.jar
BYTE_CLASSPATH=file:///home/yinhan/.m2/repository/org/apache/kafka/kafka-clients/2.4.1/kafka-clients-2.4.1.jar
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
-opPar ${OP_PARA} \
-sinkInterval ${SINK_INTERVAL} \
-nativeFlink ${NATIVE_FLINK} \
-windowStep ${WINDOW_STEP} \
-windowSize ${WINDOW_SIZE}"

SUBMIT_OUTPUT=`/home/yinhan/flink-1.12.0/build-target/bin/flink run ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}

sleep 30
# exit 0
# rescale
# /home/yinhan/flink-1.12.0/build-target/bin/flink rescale -rmd 3 -rpl ["${OPERATOR_NAME}":30]  ${JOB_ID}

# exit 0

SAVEPOINT_PATH=hdfs://slave201:9000/user/yinhan/flink_checkpoints/
STOP_OUTPUT=`/home/yinhan/flink-1.12.0/build-target/bin/flink stop -p ${SAVEPOINT_PATH} ${JOB_ID}`
SAVEPOINT_PATH=${STOP_OUTPUT##*Savepoint completed. Path: }
echo ${SAVEPOINT_PATH}
WINDOW_PARA=30
OP_PARA=30
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
-opPar ${OP_PARA} \
-sinkInterval ${SINK_INTERVAL} \
-nativeFlink ${NATIVE_FLINK} \
-windowStep ${WINDOW_STEP} \
-windowSize ${WINDOW_SIZE}"

sleep 3
SUBMIT_OUTPUT=`/home/yinhan/flink-1.12.0/build-target/bin/flink run -s ${SAVEPOINT_PATH} ${JOB_PARAMS}`
JOB_ID=${SUBMIT_OUTPUT##*submitted with JobID }
echo ${JOB_ID}
