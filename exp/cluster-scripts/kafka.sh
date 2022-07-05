#!/bin/bash
# 生产者
RATE=$1
WORD_LENGTH=$2

KAFKA_SERVERS=slave011:9092
# KAFKA_SERVERS=slave207:9092,slave208:9092,slave209:9092

java -classpath /home/zhongweichang/build-target/lib/flink-csv-1.12.0.jar:/home/zhongweichang/build-target/lib/flink-json-1.12.0.jar:/home/zhongweichang/build-target/lib/flink-shaded-zookeeper-3.4.14.jar:/home/zhongweichang/build-target/lib/flink-table_2.11-1.12.0.jar:/home/zhongweichang/build-target/lib/flink-table-blink_2.11-1.12.0.jar:/home/zhongweichang/build-target/lib/log4j-1.2-api-2.12.1.jar:/home/zhongweichang/build-target/lib/log4j-api-2.12.1.jar:/home/zhongweichang/build-target/lib/log4j-core-2.12.1.jar:/home/zhongweichang/build-target/lib/log4j-slf4j-impl-2.12.1.jar:/home/zhongweichang/build-target/lib/flink-dist_2.11-1.12.0.jar:/home/zhongweichang/code/exp/target/exp-1.0-SNAPSHOT.jar exp.KafkaProducerWordCount \
-DictionaryFilePath /home/zhongweichang/code/exp/data/Sonnet-12-words \
-kafkaServers ${KAFKA_SERVERS} \
-KafkaTopic tt_par_3 -rate ${RATE} \
-wordLength ${WORD_LENGTH}
