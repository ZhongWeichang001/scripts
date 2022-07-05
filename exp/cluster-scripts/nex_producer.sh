#!/usr/bin/env bash
nohup /home/zhongweichang/ms/exp/cluster-scripts/kafka_nexmark.sh 1000 person 1000 &
nohup /home/zhongweichang/ms/exp/cluster-scripts/kafka_nexmark.sh 1000 bid 1000 &
nohup /home/zhongweichang/ms/exp/cluster-scripts/kafka_nexmark.sh 1000 auction 1000 &