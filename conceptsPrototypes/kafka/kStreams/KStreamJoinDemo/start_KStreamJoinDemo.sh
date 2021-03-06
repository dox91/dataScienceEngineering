#!/bin/sh

LISTTOPICS="input-topic-left input-topic-right join-topic-output"
###########################################
# I. Compile kStreams application
###########################################
SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTDIR
source ../../../initialSetup/helper/set_home_variables.sh > /dev/null 2>&1
javac -cp "$KAFKA_HOME/libs/*:.:" KStreamJoinDemo.java

###########################################
# II. Prepare server and topics
###########################################
# start zookeper and kafka
source ../../../initialSetup/setup_start_kafka.sh
cd $KAFKA_HOME

# create topics
for i in $LISTTOPICS; do
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
done

###########################################
# III. Start application
###########################################
cd $SCRIPTDIR
# open console-producer for input topic left and right
#bash -c 'gnome-terminal -t "left" -x bash helper_console_producer.sh input-topic-left'
bash -c 'gnome-terminal -t "left" -x bash helper_console_consumer.sh input-topic-left'
#gnome-terminal -x "bash helper_console_producer.sh input-topic-left"
#bash -c 'gnome-terminal -t "right" -x bash helper_console_producer.sh input-topic-right'
bash -c 'gnome-terminal -t "right" -x bash helper_console_consumer.sh input-topic-right'
# open console-consumer for topic
bash -c 'gnome-terminal -t "joined" -x bash helper_console_consumer.sh join-topic-output'

echo -e "${GREEN}*********************************************************************"
echo "* Start KStream Application: KStreamJoinDemo"
echo -e "*********************************************************************${NC}"
java -cp "$KAFKA_HOME/libs/*:.:" KStreamJoinDemo