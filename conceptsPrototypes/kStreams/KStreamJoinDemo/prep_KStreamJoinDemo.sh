#!/bin/sh

###########################################
# I. Write Job & Compile
###########################################
# compile code
###########################################
cd /home/anh/codingProjects/myProjects/kafkastreamtest/KStreamJoinDemoDFS/
javac -cp "/home/anh/kafka_2.11-2.0.0/libs/*:.:" KStreamJoinDemoDFS.java
###########################################

###########################################
# II. Prepare server and topics
###########################################
# start zookeper
bin/zookeeper-server-start.sh config/zookeeper.properties
# start kafka server
bin/kafka-server-start.sh config/server.properties
# create the input and topic
bin/kafka-topics.sh --zookeeper localhost:2181 --describe

bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic input-topic-Left
bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic input-topic-Right
bin/kafka-topics.sh --delete --zookeeper localhost:2181 --topic join-topic-output

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
###########################################


###########################################
# III. Test application
###########################################
# start application (will read input, perform and write result to output)
cd /home/anh/codingProjects/myProjects/kafkastreamtest/KStreamJoinDemoDFS/
java -cp "/home/anh/kafka_2.11-2.0.0/libs/*:.:" KStreamJoinDemoDFS

# start console producer to write messages to input topic
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic dfs-input-topic-BP --property "parse.key=true" \
  --property "key.separator=:"

bin/kafka-console-producer.sh --broker-list localhost:9092 --topic dfs-input-topic-FT --property "parse.key=true" \
  --property "key.separator=:"

# consume output
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic dfs-join-topic-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
