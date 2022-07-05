#!/bin/bash

/home/yinhan/flink-1.12.0/build-target/bin/stop-cluster.sh
/home/yinhan/scripts/pssh/clear_redis.sh
/home/yinhan/flink-1.12.0/build-target/bin/start-cluster.sh


