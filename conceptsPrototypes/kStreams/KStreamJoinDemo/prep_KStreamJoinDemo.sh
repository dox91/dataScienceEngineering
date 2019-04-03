#!/bin/sh

###########################################
# I. Write Job & Compile
###########################################
# compile code
###########################################
SCRIPTDIR="${0%/*}"
cd $SCRIPTDIR
source ../../../initialSetup/set_home_variables.sh
javac -cp "$KAFKA_HOME/libs/*:.:" KStreamJoinDemo.java
###########################################

############################################ II. Prepare server and topics
###########################################
# start zookeper and kafka
source ../../../initialSetup/setup_start_kafka.sh
cd $KAFKA_HOME
# create the input and topic
#bin/kafka-topics.sh --zookeeper localhost:2181 --describe
#bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic input-topic-Left
#bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic input-topic-Right
#bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic join-topic-output

bin/kafka-topics.sh --create \
    --zookeeper localhost:2181 \
    --replication-factor 1 \
    --partitions 1 \
    --topic input-topic-Left

bin/kafka-topics.sh --create \
    --zookeeper localhost:2181 \
    --replication-factor 1 \
    --partitions 1 \
    --topic input-topic-Right

bin/kafka-topics.sh --create \
    --zookeeper localhost:2181 \
    --replication-factor 1 \
    --partitions 1 \
    --topic join-topic-output \
    --config cleanup.policy=compact

bin/kafka-topics.sh --zookeeper localhost:2181 \
    --describe

###########################################
# III. Test application
###########################################
# start application (will read input, perform and write result to output)
cd $SCRIPTDIR
java -cp "$KAFKA_HOME/libs/*:.:" KStreamJoinDemo.java

# start console producer to write messages to input topic
    #bin/kafka-console-producer.sh --broker-list localhost:9092 --topic dfs-input-topic-BP --property "parse.key=true" \
    #  --property "key.separator=:"

#bin/kafka-console-producer.sh --broker-list localhost:9092 --topic dfs-input-topic-FT --property "parse.key=true" \
    #  --property "key.separator=:"

# consume output
    # bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    # --topic dfs-join-topic-output \
    # --from-beginning \
    # --formatter kafka.tools.DefaultMessageFormatter \
    # --property print.key=true \
    # --property print.value=true \
    # --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    # --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
