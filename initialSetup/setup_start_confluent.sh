#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="confluent"
URL="https://github.com/confluentinc/cp-docker-images"
INSTFILE=${URL##*/}

# in order to export JAVA_HOME
source /etc/environment

##############################################
### Script start
##############################################
if [ "$EUID" -ne 0 ]
  then echo -e "${RED}Please run as root using sudo!${NC}"
  exit
fi

echo -e "${GREEN}*********************************************************************"
echo "* Setup and start $APP"
echo -e "*********************************************************************${NC}"
# Check if folder exists
if [ ! -d "$HOME/$APP" ]; 
	then
		echo -e "${YELLOW}Directory $HOME/$APP does not exist! Will create folder, download and unpack $APP ${NC}"
		mkdir $HOME/$APP && cd $HOME/$APP
		git clone "${URL}"
		echo -e "${GREEN} successfully downloaded and unpacked $APP ${NC}"
	else
		echo -e "${GREEN}Directory $HOME/$APP already exists ${NC}"
fi

cd $HOME/$APP/cp-docker-images
git checkout 5.2.0-post
cd examples/cp-all-in-one/

sudo docker-compose up -d --build

if [ $? -eq 0 ]; then
  echo -e "${GREEN}$APP docker-compose successfully started! Navigate to the Control Center web interface at http://localhost:9021/${NC}"
else
  echo -e "${RED}error while starting $APP docker-compose. PLease read error message ... ${NC}"
fi

#docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes