#!/bin/sh
source ../../../initialSetup/helper/set_home_variables.sh > /dev/null 2>&1
cd $KAFKA_HOME
echo -e "${GREEN}*********************************************************************"
echo "* Start Console-Producer - Topic: $1"
echo -e "*********************************************************************${NC}"
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic "$1" --property "parse.key=true" \
      --property "key.separator=:"