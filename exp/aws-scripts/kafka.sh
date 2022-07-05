#!/bin/bash

RATE=$1
WORD_LENGTH=$2
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
KAFKA_SERVERS=slave203:9092
# KAFKA_SERVERS=slave207:9092,slave208:9092,slave209:9092

/home/yinhan/jdk1.8.0_181/bin/java -classpath /home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-csv-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-json-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-shaded-zookeeper-3.4.14.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table_2.11-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table-blink_2.11-1.12.0.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-1.2-api-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-api-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-core-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-slf4j-impl-2.12.1.jar:/home/yinhan/flink-1.12.0/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-dist_2.11-1.12.0.jar:/home/yinhan/flink-exp/target/exp-1.0-SNAPSHOT.jar exp.KafkaProducerWordCount \
-DictionaryFilePath /home/yinhan/flink-exp/data/Sonnet-12-words \
-kafkaServers ${KAFKA_SERVERS} \
-KafkaTopic tt_par_25 -rate ${RATE} \
-wordLength ${WORD_LENGTH}
