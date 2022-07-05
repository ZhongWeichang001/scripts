#!/bin/bash
~/scripts/flink_conf.sh

pssh -h ~/scripts/pssh/slaves_2_6_7 -t 1000000 'rsync -avzr yinhan@slave201:/home/yinhan/flink-1.12.0 /home/yinhan/'


pssh -h ~/scripts/pssh/slaves -t 1000000 'echo "metrics.reporter.promgateway.jobName: flink-metrics"-${HOSTNAME} >> /home/yinhan/flink-1.12.0/build-target/conf/flink-conf.yaml'

