#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="kafka"
URL="http://ftp.fau.de/apache/kafka/2.2.0/kafka_2.12-2.2.0.tgz"
INSTFILE=${URL##*/}
APPDIR="${INSTFILE%.tgz}"

# in order to export JAVA_HOME
source /etc/environment

##############################################
### Script start
##############################################
echo -e "${GREEN}*********************************************************************"
echo "* Setup and start $APP"
echo -e "*********************************************************************${NC}"
# Check if folder exists
if [ ! -d "$HOME/$APP" ]; 
	then
		echo -e "${YELLOW}Directory $HOME/$APP does not exist! Will create folder, download and unpack $APP ${NC}"
		mkdir $HOME/$APP && cd $HOME/$APP
		wget "${URL}"
		tar zxvf $INSTFILE
		echo -e "${GREEN} successfully downloaded and unpacked $APP ${NC}"
	else
		echo -e "${GREEN}Directory $HOME/$APP already exists ${NC}"
fi

cd $HOME/$APP/$APPDIR
(nohup bin/zookeeper-server-start.sh config/zookeeper.properties > /dev/null 2>&1) &
sleep 2
(nohup bin/kafka-server-start.sh config/server.properties > /dev/null 2>&1) &
echo -e "${GREEN}Zookeeper and kafka service started. Will create HelloWorld topic and send describe command ... ${NC}"
bin/kafka-topics.sh --describe --bootstrap-server localhost:9092 | grep HelloWorld
greprc=$?
if [[ $greprc -eq 0 ]] ; 
	then
    	echo "not found Hello World topic will create it"
	else
		echo "not found Hello World topic will create it"
		bin/kafka-topics.sh --create \
	    --zookeeper localhost:2181 \
	    --replication-factor 1 \
	    --partitions 1 \
	    --topic HelloWorld
fi
bin/kafka-topics.sh --describe --bootstrap-server localhost:9092
#bin/zookeeper-server-stop.sh
#bin/kafka-server-stop.sh