#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

##############################################
### Script start
##############################################
if [ "$EUID" -eq 0 ]
  then echo -e "${RED}Please do not run as root! ${NC}"
  exit
fi

echo -e "${GREEN}*********************************************************************"
echo "* Script to stop all runnng VMs"
echo -e "*********************************************************************${NC}"

VB=$(VBoxManage list runningvms | sed 's/^"\([^"]*\).*/\1/')
echo -e "${YELLOW}Stop VMs (virtualbox) ${NC}"
if [ -z "$VB" ]
  then echo -e "${YELLOW}No VMs running! Nothing to stop.${NC}"
  exit
else
  for i in $VB; do
    echo -e "${YELLOW}Stop currently running VM $i in savestate mode ${NC}" 
    vboxmanage controlvm $i savestate
    echo -e "${GREEN}done ${NC}"
  done
fi