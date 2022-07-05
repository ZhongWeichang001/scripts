#!/bin/bash

KAFKA_HOME=/home/yinhan/kafka_2.13-2.7.0

ZOOKEEPER=slave201:2181
#ZOOKEEPER=slave201:2181,slave202:2181,slave206:2181,slave208:2181,slave209:2181
# ZOOKEEPER=slave207:2181,slave208:2181,slave209:2181
# ZOOKEEPER=slave203:2181

TOPIC_NAME=test_201
# TOPIC_NAME=person_nexmark_par_25
# TOPIC_NAME=auction_nexmark_par_25
#TOPIC_NAME=tt_par_25
#TOPIC_NAME=fail_over_topic_4

${KAFKA_HOME}/bin/kafka-topics.sh --describe --zookeeper ${ZOOKEEPER} --topic ${TOPIC_NAME}
