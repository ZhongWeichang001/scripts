#!/bin/bash

for((i=0;i<=128;i++));  
do
echo $(~/kafka_2.13-2.7.0/bin/kafka-consumer-groups.sh --bootstrap-server 127.0.0.1:9092 --delete-offsets --group postFetchRequestTopic-group-$i --topic postFetchRequestTopic);  
done