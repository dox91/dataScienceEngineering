#!/usr/bin/env bash

##############################################
## conda env: bigdata-env
##############################################
echo "export PATH=/home/$USER/anaconda3/bin:$PATH" >> ~/.bashrc 
SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTDIR

conda env list | grep -q bigData-env
greprc=$?
if [[ ! $greprc -eq 0 ]] ; 
	then
		echo "create new env"
		conda env create -f condaEnvYaml/bigData-env.yaml
fi
conda env list 

#conda remove --name bigData-env --all