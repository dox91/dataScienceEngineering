#!/usr/bin/env bash
##############################################
### Variables
##############################################
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

APP="hbase"
URL="https://www-eu.apache.org/dist/hbase/stable/hbase-1.4.9-bin.tar.gz"
INSTFILE=${URL##*/}
APPDIR="${INSTFILE%-bin.tar.gz}"
DIRECTORY=`dirname $0`

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

cp $HOME/$APP/$APPDIR/conf/hbase-site.xml $HOME/$APP/$APPDIR/conf/backup__hbase-site.xml
cp -R $DIRECTORY/templates/tmpl__hbase-site.xml $HOME/$APP/$APPDIR/conf/hbase-site.xml


# replace some values in hbase-site.xml
cd $HOME/$APP/$APPDIR/conf/
#HBASEFILE_OLD="file:///home/testuser/hbase"
#HBASEFILE_NEW="file:///$HOME/$APP/$APPDIR"
sed -i "s!file:///home/testuser/hbase!file:///${HOME}/${APP}/${APPDIR}!g" hbase-site.xml
#sed -e "s=$HBASEFILE_OLD=$HBASEFILE_NEW=" hbase-site.xml 
#ZOOKEE_OLD="/home/testuser/zookeeper"
#ZOOKEE_NEW="$HOME/$USER/$APP/$APPDIR/zookeeper"
sed -i "s!/home/testuser/zookeeper!${HOME}/${APP}/${APPDIR}/zookeeper!g" hbase-site.xml
#sed -e "s=$HBASEFILE_OLD=$HBASEFILE_NEW=" hbase-site.xml 

cd $HOME/$APP/$APPDIR
bin/start-hbase.sh
if [ $? -eq 0 ]; then
  echo -e "${GREEN}hbase successfully started! Please navigate to  http://localhost:16010/${NC}"
else
  echo -e "${RED}error while starting hbase. PLease read error message ... ${NC}"
fi
# bin/stop-hbase.sh