#!/bin/sh

# pre-requisite: source set_all_home_variables.sh before
# to define KAFKA_HOME

cd $KAFKA_HOME
echo -e "${GREEN}*********************************************************************"
echo "* Start Console-Consumer - Topic: $1"
echo -e "*********************************************************************${NC}"
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic "$1" \
--from-beginning \
--formatter kafka.tools.DefaultMessageFormatter \
--property print.key=true \
--property print.value=true \
--property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
--property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
