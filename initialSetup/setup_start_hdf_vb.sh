#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="hdfVB"
# virtualbox
URL="https://archive.cloudera.com/hwx-sandbox/hdf/hdf-3.1.1/HDF_3.1.1_virtualbox_180626.ova"

OVA_FILE=${URL##*/}
VM_NAME="hdf_3_1_1"

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
		echo -e "${GREEN}Successfully downloaded and imprted $APP to virtualbox ${NC}"
	else
		echo -e "${GREEN}Directory $HOME/$APP already exists ${NC}"
fi

cd $HOME/$APP
VBoxManage import $OVA_FILE --dry-run
VBoxManage import $OVA_FILE --vsys 0 --vmname $VM_NAME --eula accept
VBoxManage startvm $VM_NAME --type=gui

echo -e "${YELLOW}INFO [1]: Welcome page: http://localhost:1080"
echo -e "${YELLOW}INFO [2]: SSH: ssh root@sandbox-hdf.hortonworks.com -p 2222 and start password hadoop (you may have changed that after first login)"