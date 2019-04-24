#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="splash"
URL="https://splash.readthedocs.io/en/stable/install.html"
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
		echo -e "${YELLOW}Directory $HOME/$APP does not exist! Will create folder${NC}"
		mkdir $HOME/$APP && cd $HOME/$APP
		sudo docker pull scrapinghub/splash
		echo -e "${GREEN} successfully: sudo docker pull scrapinghub/splash"
	else
		echo -e "${GREEN}Directory $HOME/$APP already exists ${NC}"
fi

cd $HOME/$APP/

bash -c 'gnome-terminal -t "$APP" -x docker run -it -p 8050:8050 scrapinghub/splash --disable-private-mode'
if [ $? -eq 0 ]; 
	then
  		echo -e "${GREEN}$APP docker run in interactive mode successfully started! Splash is available at 0.0.0.0 address at port 8050 (http)."
	else
 		echo -e "${RED}error while starting $APP. PLease read error message ... ${NC}"
fi

#docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes