#!/bin/bash
COMMAND=$1

# pssh -h ~/scripts/pssh/slaves_2_6_7 -t 1000000 -i $COMMAND
pssh -h ~/scripts/pssh/slaves -t 1000000 -i $COMMAND


