#!/bin/bash
pssh -h ~/scripts/pssh/slaves "/home/yinhan/redis-3.2.0/src/redis-cli info | grep -A 5 Keyspace"
