#!/usr/bin/env bash

SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTDIR
source set_all_home_variables.sh #> /dev/null 2>&1

###########################################
# Variables
###########################################
KTOPICS="test-stream-csv-topic"
SC_START_KAFKA=$HOME_REPO/initialSetup/setup_start_kafka.sh
SC_CONSOLE_CONSUMER=$HOME_REPO/conceptsPrototypes/kafka/helper/helper_console_consumer.sh

###########################################
# II. Prepare server and topics
###########################################
# start zookeper and kafka
source $SC_START_KAFKA
cd $KAFKA_HOME
# create topics
for i in $KTOPICS ; do
    bin/kafka-topics.sh --describe --bootstrap-server localhost:9092 | grep $i
    greprc=$?
    if [[ ! $greprc -eq 0 ]] ;
        then
            echo "not found $i -> will create it"
            bin/kafka-topics.sh --create \
            --zookeeper localhost:2181 \
            --replication-factor 1 \
            --partitions 1 \
            --topic $i
    fi
    # open console consumer in another tab
    bash -c "gnome-terminal -t $i -x bash $SC_CONSOLE_CONSUMER $i"
done

##############################################
### submit spark-job: KafkaProducerApp
##############################################
$SPARK_HOME/bin/spark-submit \
  --class "com.dox91.spark.KafkaProducerApp" \
  --master local[4] \
  --packages org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 \
$SCRIPTDIR/../../target/SparkApp-1.0-SNAPSHOT-jar-with-dependencies.jar