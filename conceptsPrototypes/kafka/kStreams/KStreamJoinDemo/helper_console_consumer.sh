#!/bin/sh
source ../../../initialSetup/helper/set_home_variables.sh > /dev/null 2>&1
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