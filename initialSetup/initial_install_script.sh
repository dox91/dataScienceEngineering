#!/usr/bin/env bash

# this is a collection of commands
# for setting up a new Ubuntu laptop

##############################################
## Note on right click:
##############################################
# If your laptop’s touchpad 
# doesn’t have ‘physical buttons’ for left and right click, 
# the right click is achieved with two fingers tap

##############################################
## keyboard settings
##############################################
# https://www.cnx-software.com/2017/02/08/how-to-assign-brightness-keys-in-ubuntu-16-04-and-greater/
#sudo apt install xdotool

##############################################
## fingerprint sensor
##############################################
#sudo apt install -y fprintd libpam-fprintd
#sudo apt install fprintd
#sudo pam-auth-update
##  press the spacebar to select/deselect options
##  go to activities and search 'Users'

##############################################
## shutdown error with ubuntu
##############################################
#sudo nano /etc/default/grub
## change the following:
#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=force"
#GRUB_CMDLINE_LINUX="nouveau.modeset=0"

##############################################
## change wallpaper
##############################################
gsettings set org.gnome.desktop.background picture-uri "http://wallpaperswide.com/download/nature_301-wallpaper-2880x1800.jpg"

##############################################
## install sublime text 3
##############################################
# https://linuxize.com/post/how-to-install-sublime-text-3-on-ubuntu-18-04/
sudo apt update
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo apt update
sudo apt -y install sublime-text

##############################################
## install flash player
##############################################
# https://itsfoss.com/install-adobe-flash-player-in-ubuntu-13-04/
sudo apt -y install ubuntu-restricted-extras

##############################################
## install pdfsam
##############################################
#https://github.com/torakiki/pdfsam/issues/295
sudo apt -y install openjdk-8-jdk openjfx
sudo apt-get -y install pdfsam 

##############################################
## install java (JRE) 11 (current)
##############################################
# https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
#sudo apt update
#sudo apt -y install default-jre default-jdk
#java -version

##############################################
## Java Environment
##############################################
# https://linuxize.com/post/install-java-on-ubuntu-18-04/
#sudo update-alternatives --config java
#sudo update-alternatives --config javac
## then select the java version you want 

## a) set JAVA_HOME manually 
#sudo nano /etc/environment
# JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java'

## b) set JAVA_HOME via command linea append
sudo tee -a /etc/environment <<< "JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64/jre/'"
source /etc/environment
echo $JAVA_HOME

java -version
javac -version

##############################################
## install scala
##############################################
# https://medium.com/@josemarcialportilla/installing-scala-and-spark-on-ubuntu-5665ee4b62b1
#sudo apt-get -y install scala

# scala shell issue - instead of installing with apt use deb
# https://stackoverflow.com/questions/49788781/ubuntu-scala-repl-commands-not-typed-on-console
sudo apt-get remove scala-library scala
sudo wget www.scala-lang.org/files/archive/scala-2.11.12.deb
sudo dpkg -i scala-2.11.12.deb
scala -version

##############################################
## install sbt (scala build tool - dependency management)
##############################################
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt
sbt sbtVersion

##############################################
## install maven
##############################################
# https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-18-04/
sudo apt update
sudo apt -y install maven
mvn -version

# sudo nano /etc/profile.d/maven.sh
# export JAVA_HOME=/usr/lib/jvm/default-java
# export M2_HOME=/opt/maven
# export MAVEN_HOME=/opt/maven
# export PATH=${M2_HOME}/bin:${PATH}
# sudo chmod +x /etc/profile.d/maven.sh # make script executable
# source /etc/profile.d/maven.sh # load environment variables

##############################################
## install docker
##############################################
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get update

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
# sudo docker run hello-world

##############################################
## install docker compose
##############################################
# https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

##############################################
## install gitkraken
##############################################
# https://support.gitkraken.com/how-to-install/?query=
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i gitkraken-amd64.deb
sudo apt update
sudo apt -y install gconf2
sudo apt --fix-broken install
dpkg -i gitkraken-amd64.deb
rm gitkraken-amd64.deb

##############################################
## install google chrome webbrowser
##############################################
# https://itsfoss.com/install-chrome-ubuntu/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

##############################################
## install intellij
##############################################
# https://itsfoss.com/install-intellij-ubuntu-linux/
#sudo snap install intellij-idea-ultimate --classic
#sudo snap remove intellij-idea-ultimate
sudo snap install intellij-idea-community --classic
snap list --all

##############################################
## install slack
##############################################
# https://websiteforstudents.com/installing-slack-for-linux-on-ubuntu-16-04-17-10-18-04/
sudo apt install snapd
sudo snap install slack --classic

##############################################
## install visual studio code
##############################################
# https://linuxize.com/post/how-to-install-visual-studio-code-on-ubuntu-18-04/
sudo apt update
sudo apt install software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt -y install code

##############################################
## pdf reader okular
##############################################
sudo apt-get -y install okular 
sudo apt-get -y install okular-extra-backends 

##############################################
## install spotify
##############################################
snap install spotify

##############################################
## install keepass
##############################################
sudo apt -y install keepassx

##############################################
## install virtualbox
##############################################
# https://vitux.com/how-to-install-virtualbox-on-ubuntu/
sudo add-apt-repository multiverse && sudo apt-get update
sudo apt -y install virtualbox

##############################################
## install htop
##############################################
sudo apt-get -y install htop 

##############################################
## install mailspring
##############################################
sudo snap install mailspring

##############################################
## install libreoffice
##############################################
sudo snap install libreoffice

##############################################
## markdown editor
##############################################
#http://elinuxbook.com/install-remarkable-editor-in-ubuntu-16-04-a-best-markdown-editor-linux-application/

##############################################
## citrix client (Secure Appl. GateWay - SAGW)
##############################################
## https://www.citrix.de/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
#CITRIXAPP=icaclient_19.3.0.5_amd64.deb
#wget "https://downloads.citrix.com/15918/${CITRIXAPP}?__gda__=1555161114_ff045d5dc3646d8c64f8df9860752ccb"
#mv ${CITRIXAPP}* ${CITRIXAPP}
#sudo dpkg -i ${CITRIXAPP}
#rm ${CITRIXAPP}

## citrix client fix for Linux (ssl-cacert link)
## https://ubuntuforums.org/showthread.php?t=2391515
#cd /opt/Citrix/ICAClient/keystore/
#rm -rf cacerts
#ln -s /etc/ssl/certs cacerts

##############################################
# else
##############################################
## install vlc media player
## note app / note client for evernote

##############################################
# uninstall apt
##############################################
# https://vitux.com/how-to-uninstall-programs-from-your-ubuntu-system/

dpkg --list
#sudo apt-get purge “package-name”
#sudo apt-get autoremove