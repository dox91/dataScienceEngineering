#!/usr/bin/env bash
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
##############################################
## conda deactivate env
##############################################
CONDAFILE="/etc/profile.d/conda.sh"
# if file not exist
if [ ! -f "$CONDAFILE" ]; 
	then
		sudo ln -s $HOME/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
		#echo "export PATH=/home/$USER/anaconda3/bin:$PATH" >> ~/.bashrc 
		echo ". $HOME/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc
	else 
		echo
fi

. ~/.bashrc
conda deactivate
echo -e "${YELLOW}*********************************************************************"
echo "* Deactivated current conda environment $1"
echo -e "*********************************************************************${NC}"