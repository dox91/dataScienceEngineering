#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="hdpVB"
# docker-image
#URL="https://downloads-hortonworks.akamaized.net/sandbox-hdp-3.0.1/HDP_3.0.1_docker-deploy-scripts_18120587fc7fb.zip"
# virtualbox
URL="https://archive.cloudera.com/hwx-sandbox/hdp/hdp-3.0.1/HDP_3.0.1_virtualbox_181205.ova"

OVA_FILE=${URL##*/}
VM_NAME="hdp_3_0_1"

##############################################
### Link
##############################################
#https://www.cloudera.com/tutorials/sandbox-deployment-and-install-guide/1.html

##############################################
### Script start
##############################################
if [ "$EUID" -eq 0 ]
  then echo -e "${RED}Please do not run as root! ${NC}"
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
		wget "${URL}"
		#unzip $INSTFILE
		#vboxmanage import $INSTFILE
		echo -e "${GREEN}Successfully downloaded and imprted $APP to virtualbox ${NC}"
	else
		echo -e "${GREEN}Directory $HOME/$APP already exists ${NC}"
fi

cd $HOME/$APP
VBoxManage import $OVA_FILE --dry-run
VBoxManage import $OVA_FILE --vsys 0 --vmname $VM_NAME --eula accept
VBoxManage startvm $VM_NAME --type=gui
####

# cd $HOME/$APP
# SETUPFILE=$(find . -maxdepth 1 -mindepth 1  -name "*.sh")
# bash $SETUPFILE
# if [ $? -eq 0 ]; then
#   echo -e "${GREEN}hdp docker successfully started! Please navigate to Sandbox Welcome Page  http://sandbox-hdp.hortonworks.com:1080/${NC}"
# else
#   echo -e "${RED}error while starting hdp docker. PLease read error message ... ${NC}"
# fi