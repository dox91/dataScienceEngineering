#!/usr/bin/env bash

##############################################
## conda activate env
##############################################
sudo ln -s $HOME/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh

echo "export PATH=/home/$USER/anaconda3/bin:$PATH" >> ~/.bashrc 
echo ". $HOME/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
conda activate "$1"