#!/bin/bash

KAFKA_HOME=/home/yinhan/kafka_2.13-2.7.0

SERVER=slave203:9092
# SERVER=slave201:9092,slave202:9092,slave206:9092,slave207:9092

# TOPIC_NAME=bid_nexmark_par_25
# TOPIC_NAME=person_nexmark_par_25
TOPIC_NAME=auction_nexmark_par_25

${KAFKA_HOME}/bin/kafka-console-consumer.sh  --bootstrap-server ${SERVER} --topic ${TOPIC_NAME}