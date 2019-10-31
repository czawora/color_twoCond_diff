#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# print exit statement if sim directory doesnt exist
[ ! -d sim ] && echo "no sim directory for this model" && exit

# count the sim_dirs
sim_dir_count=0
sim_complete_count=0
sim_incomplete_count=0

for iDir in $(ls sim)
do

  ((sim_dir_count=sim_dir_count+1))
  
  [ -f sim/$iDir/model_fit.rds ] && ((sim_complete_count=sim_complete_count+1))
  [ ! -f sim/$iDir/model_fit.rds ] && ((sim_incomplete_count=sim_incomplete_count+1)) && echo "$iDir incomplete"
  
done

echo "total sim: $sim_dir_count"
echo "complete count: $sim_complete_count"
echo "incomplete count: $sim_incomplete_count"
