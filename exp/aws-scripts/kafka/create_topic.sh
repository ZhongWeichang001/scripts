#!/bin/bash

KAFKA_HOME=/home/yinhan/kafka_2.13-2.7.0

ZOOKEEPER=slave201:2181
# KAFKA_SERVERS=slave201:9092,slave202:9092,slave206:9092,slave208:9092,slave209:9092
#ZOOKEEPER=slave201:2181,slave202:2181,slave206:2181,slave208:2181,slave209:2181

# TOPIC_NAME=bid_nexmark_par_25
# TOPIC_NAME=person_nexmark_par_25
# TOPIC_NAME=auction_nexmark_par_25
TOPIC_NAME=test_201

${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper ${ZOOKEEPER} --replication-factor 1 --partitions 1 --topic ${TOPIC_NAME}
