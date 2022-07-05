#!/bin/bash

RATE=$1
TARGET=$2
PERID=$3
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave207:9092
KAFKA_SERVERS=slave011:9092

java -classpath /home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-csv-1.12.0.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-json-1.12.0.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-shaded-zookeeper-3.4.14.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table_2.11-1.12.0.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-table-blink_2.11-1.12.0.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-1.2-api-2.12.1.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-api-2.12.1.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-core-2.12.1.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/log4j-slf4j-impl-2.12.1.jar:/home/zhongweichang/meces/Meces-on-Flink/flink-dist/target/flink-1.12.0-bin/flink-1.12.0/lib/flink-dist_2.11-1.12.0.jar:/home/zhongweichang/code/exp/target/original-exp-1.0-SNAPSHOT.jar exp.KafkaProducerNexmark \
-AuctionTopic auction_nexmark_par_3 \
-PersonTopic person_nexmark_par_3 \
-BidTopic bid_nexmark_par_3 \
-kafkaServers ${KAFKA_SERVERS} \
-rate ${RATE} \
-target ${TARGET} \
-period ${PERID}

# bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic person_nexmark_par_3