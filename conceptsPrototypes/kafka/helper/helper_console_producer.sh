#!/bin/sh

# pre-requisite: source set_all_home_variables.sh before
# to define KAFKA_HOME

cd $KAFKA_HOME
echo -e "${GREEN}*********************************************************************"
echo "* Start Console-Producer - Topic: $1"
echo -e "*********************************************************************${NC}"
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic "$1" --property "parse.key=true" \
      --property "key.separator=:"
