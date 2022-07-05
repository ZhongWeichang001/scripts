#!/bin/bash
pssh -h ~/scripts/pssh/slaves '/home/yinhan/redis-3.2.0/src/redis-server /home/yinhan/redis-3.2.0/redis.conf --daemonize yes'
