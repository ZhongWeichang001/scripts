BIN=$1
BATCH=$2
NAME=$3

sed -i "s/state.numBins=[0-9]*/state.numBins=${BIN}/g" ~/flink-conf-slave201/pasa.conf.prop
sed -i "s/state.batchSize=[0-9]*/state.batchSize=${BATCH}/g" ~/flink-conf-slave201/pasa.conf.prop

./pssh/clear_redis.sh

./pssh/sync_conf.sh

JOB_OUTPUT=`./rescale.sh`

JOB_ID=${JOB_OUTPUT##*backup information }
echo ${JOB_ID}

cd ~/exp-data
conda init bash
./scripts/sync_data.sh 
conda activate
python latency.py
conda deactivate
~/exp-data/scripts/backup.sh ${NAME} ${JOB_ID} 5g 800k/

cd ~/scripts

