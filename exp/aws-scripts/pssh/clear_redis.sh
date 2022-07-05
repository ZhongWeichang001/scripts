#!/bin/bash
pssh -t 0 -i -h /home/yinhan/scripts/pssh/slaves "/home/yinhan/redis-3.2.0/src/redis-cli flushall"
