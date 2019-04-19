#!/usr/bin/env bash

function cdRepoRoot()
{
  while [[ $PWD != '/' && ${PWD##*/} != 'dataScienceEngineering' ]]; do cd ..; done
}
cdRepoRoot
export HOME_REPO=$PWD
echo HOME_REPO=$PWD
source $HOME_REPO/initialSetup/helper/set_home_variables.sh