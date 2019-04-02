#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="zeppelin"
URL="https://www-us.apache.org/dist/zeppelin/zeppelin-0.8.1/zeppelin-0.8.1-bin-all.tgz"
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
bin/zeppelin-daemon.sh start
# bin/zeppelin-daemon.sh stop