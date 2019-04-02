#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="spark"
URL="http://mirror.checkdomain.de/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"
INSTFILE=${URL##*/}
APPDIR="${INSTFILE%.tgz}"

##############################################
### Links
##############################################
# https://medium.com/@josemarcialportilla/installing-scala-and-spark-on-ubuntu-5665ee4b62b1
##############################################

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
bin/spark-shell