#!/usr/bin/env bash

##############################################
### some data science stuff
##############################################

##############################################
## install conda 
##############################################
# latest version from https://repo.anaconda.com/archive
#https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html
wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
bash Anaconda3-2018.12-Linux-x86_64.sh
rm Anaconda3-2018.12-Linux-x86_64.sh

#https://support.anaconda.com/customer/en/portal/articles/2621189-conda-%22command-not-found%22-error
#https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7
echo "export PATH=/home/$USER/anaconda3/bin:$PATH" >> ~/.bashrc 

##############################################
## spark
##############################################
# https://medium.com/@josemarcialportilla/installing-scala-and-spark-on-ubuntu-5665ee4b62b1

##############################################
## docker driverless ai
##############################################
# http://docs.h2o.ai/driverless-ai/latest-stable/docs/userguide/install/ubuntu.html
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2

# Verify that nvidia is up and running
nvidia-smi

# Set up directory with the version name
mkdir dai_rel_VERSION