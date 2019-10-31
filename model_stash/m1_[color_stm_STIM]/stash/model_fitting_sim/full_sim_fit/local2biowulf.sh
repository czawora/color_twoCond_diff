#!/bin/bash

model_dir_local="/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/m1_\[color_stm_STIM\]/model_fitting_sim/full_sim_fit"
model_common_dir="/Users/zaworaca/Desktop/Desktop/zane/color_twoCond_diff/common"

model_sim_dir_biowulf="/data/FRNU/CZ/brms/color_twoCond_diff/m1_\[color_stm_STIM\]"

scp $model_dir_local/* zaworaca@biowulf.nih.gov:$model_sim_dir_biowulf
scp $model_common_dir/* zaworaca@biowulf.nih.gov:$model_sim_dir_biowulf