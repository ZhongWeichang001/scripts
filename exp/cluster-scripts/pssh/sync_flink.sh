#!/bin/bash
pssh -h ~/scripts/pssh/slaves_2_6_7 -t 1000000 'rsync -avzr yinhan@slave201:/home/yinhan/flink-1.12.0 /home/yinhan/'
pssh -h ~/scripts/pssh/slaves_2_6_7 -t 1000000 'rsync -avzr yinhan@slave201:/home/yinhan/.m2 /home/yinhan/'
