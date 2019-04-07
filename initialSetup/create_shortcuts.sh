#!/usr/bin/env bash
##############################################
### I. Script
##############################################
# https://linuxconfig.org/how-to-create-desktop-shortcut-launcher-on-ubuntu-18-04-bionic-beaver-linux

cd ~/Desktop/
##############################################
### google-drive
##############################################
# 1. define variables
NAME="google-drive"
SCFILE="$NAME.desktop"
LINK="https://drive.google.com/drive/my-drive"
ICONLINK="https://cdn1.iconfinder.com/data/icons/logotypes/32/google-drive-512.png"
# 2. download icon picture
wget $ICONLINK -O ~/Pictures/${NAME}-icon.png 
# 3. create shortcut
touch $SCFILE
tee -a $SCFILE <<< "#!/usr/bin/env xdg-open"
tee -a $SCFILE <<< "[Desktop Entry]"
tee -a $SCFILE <<< "Version=1.0"
tee -a $SCFILE <<< "Type=Application"
tee -a $SCFILE <<< "Terminal=false"
tee -a $SCFILE <<< "Exec=google-chrome $LINK"
tee -a $SCFILE <<< "Name=$NAME"
tee -a $SCFILE <<< "Comment=$NAME"
tee -a $SCFILE <<< "Icon=${HOME}/Pictures/${NAME}-icon.png "



##############################################
### II. Manually - using gnome-panel
##############################################
# https://askubuntu.com/questions/359492/create-a-shortcut-for-url?noredirect=1&lq=1

# a)
#sudo apt-get install gnome-panel
#gnome-desktop-item-edit --create-new ~/Desktop

# b) manually add
# command: google-chrome link

# download icon and change icon
# cd ~/Pictures
# wget link
# go to properties and change icon