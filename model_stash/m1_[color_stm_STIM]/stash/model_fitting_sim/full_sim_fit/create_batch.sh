#!/bin/bash

nsim=$(($1 - 1))
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# make directory containing sim runs
all_sim_dir=$DIR/sim
[ ! -d $all_sim_dir ] && mkdir $all_sim_dir

echo -n "" > $DIR/big_bash.sh

for isim in $( seq -f "%03g" 0 $nsim )
do

    current_sim_dir="$all_sim_dir/sim$isim"
    
    [ -d $current_sim_dir ] && rm -rf $current_sim_dir      # empty current sim dir if exists
    [ ! -d $current_sim_dir ] && mkdir $current_sim_dir       # make current sim dir
    
    # copy batch script into current sim dir
    cp $DIR/sim_batch.R $current_sim_dir
    
    # copy other needed scripts into current sim dir
    cp $DIR/brms_model.R $current_sim_dir
    cp $DIR/simulation.R $current_sim_dir    
    
    echo "#!/bin/bash" > $current_sim_dir/run.sh
    echo "bash /data/FRNU/mod_sets/Rstan.sh" >> $current_sim_dir/run.sh
    echo "module load boost/1.56_gcc-4.9.4" >> $current_sim_dir/run.sh
    echo "/data/FRNU/installs/R/R_install/bin/Rscript $current_sim_dir/sim_batch.R $current_sim_dir $isim &> $current_sim_dir/log.txt" >> $current_sim_dir/run.sh
    
    echo "bash $current_sim_dir/run.sh;" >> $DIR/big_bash.sh
    
done

echo "swarm -g 30 -b 2 -t 6 --time 24:00:00 --merge-output --logdir $DIR/log_dump -f $DIR/big_bash.sh" > $DIR/swarm.sh
