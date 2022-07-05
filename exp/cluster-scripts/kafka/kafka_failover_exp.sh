#!/bin/bash

JAR_HOME=/home/yinhan/kafka-exp/target
JAR_PATH=${JAR_HOME}/kafka-exp-1.0-SNAPSHOT.jar

# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave208:9092,slave209:9092
KAFKA_SERVERS=slave201:9092
KAFKA_TOPIC=test_201
CLASSPATH=/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-csv-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-json-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-shaded-zookeeper-3.4.14.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table_2.11-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table-blink_2.11-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-1.2-api-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-api-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-core-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-slf4j-impl-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-dist_2.11-1.12.0.jar:${JAR_PATH}


/home/yinhan/jdk1.8.0_181/bin/java -classpath ${CLASSPATH} exp.KafkaFailoverExp \
-mode $1 \
-kafkaServers ${KAFKA_SERVERS} \
-KafkaTopic ${KAFKA_TOPIC}
