#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Set HOME Variables
APPS="nifi spark kafka zeppelin hbase hdp hdf confluent zeppelin"
source /etc/environment
##############################################
### Script start
##############################################
echo -e "${GREEN}*********************************************************************"
echo "* Script to set all home variables"
echo -e "*********************************************************************${NC}"

for i in $APPS; do
    case $i in
     'kafka')      
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export KAFKA_HOME=$APPDIR
          ;;
     'spark')      
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export SPARK_HOME=$APPDIR
          ;;
     'hdp')
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export HDP_HOME==$APPDIR
          ;;
     'hdf')
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export HDF_HOME==$APPDIR
          ;;
     'confluent')
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export CONFLUENT_HOME==$APPDIR
          ;;
	 'nifi')
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export NIFI_HOME==$APPDIR
	      ;;
    'hbase') 
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export HBASE_HOME==$APPDIR
        ;;
    'zeppelin')
          APPDIR=$(find ~/$i/ -maxdepth 1 -mindepth 1 -type d -name "*$i*") 
          export ZEPPELIN_HOME==$APPDIR
        ;;
	esac
done