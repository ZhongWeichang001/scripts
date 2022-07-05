#!/bin/bash

for((i=0;i<512;i++));  
do

# echo $(~/kafka_2.13-2.7.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic postFetchRequestTopic-$i); 
# echo $(~/kafka_2.13-2.7.0/bin/kafka-topics.sh  --delete --bootstrap-server 127.0.0.1:9092  --topic postFetchRequestTopic-$i);
echo $(~/kafka_2.13-2.7.0/bin/kafka-topics.sh --create --zookeeper slave201:2181,slave202:2181,slave206:2181,slave207:2181 --replication-factor 1 --partitions 1 --config message.timestamp.type=LogAppendTime --topic postFetchRequestTopic-$i);
done