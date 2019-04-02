#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APPS="nifi spark kafka zeppelin hbase hdp hdf confluent zeppelin"
source /etc/environment

##############################################
### Script start
##############################################
if [ "$EUID" -ne 0 ]
  then echo -e "${RED}Please run as root using sudo!${NC}"
  exit
fi

echo -e "${GREEN}*********************************************************************"
echo "* Script to stop all services"
echo -e "*********************************************************************${NC}"

for i in $APPS; do
    case $i in
     'kafka')      
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          cd $APPDIR
          bin/zookeeper-server-stop.sh
          bin/kafka-server-stop.sh
          ;;
     'spark')      
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          cd $APPDIR
          ;;
     'hdp'|'hdfs'|'confluent')
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          docker stop $(docker ps -aq) 
          docker rm $(docker ps -aq) # will remove all containers, not images 
          ;;
	   'nifi')
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
	        cd $APPDIR
	        bin/nifi.sh stop
	      ;;
    'hbase')
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          cd $APPDIR
          bin/stop-hbase.sh stop
        ;;
    'zeppelin')
          echo -e "${YELLOW}Stop $i services ${NC}" 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          cd $APPDIR
          bin/zeppelin-daemon.sh stop
        ;;
	esac
done