#!/bin/bash
# 
# Author: Gina O'Neil
# 
# The folder structure is assumed to be:
#  + ./tensorflow/models/research/deeplab/datasets
#    - build_wetlands_data.py
#    - build_data.py
#    - segmentation_dataset.py
#    - convert_wetlands.sh
#    - train_wetlands.sh
#    - vis_wetlands.sh
#    + wetlands
#

cd ../../
# Set up the working environment.
CURRENT_DIR=$(pwd)

WORK_DIR="${CURRENT_DIR}/deeplab"
DATASET_DIR="datasets"

# Set up the working directories.
WETLANDS_FOLDER="wetlands"
EXP_FOLDER="exp/train_on_trainval_set"
TRAIN_FOLDER="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/${EXP_FOLDER}/train"
EVAL_FOLDER="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/${EXP_FOLDER}/eval"
DATASET="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/tfrecord"

mkdir -p "${EVAL_FOLDER}"

#tensorflow (py35) env has tensorflow installed
"C:/Anaconda2/envs/tensorflow/python" "${WORK_DIR}/eval.py" \
    --logtostderr \
    --eval_split="val" \
    --model_variant="xception_65" \
    --atrous_rates=6 \
    --atrous_rates=12 \
    --atrous_rates=18 \
    --output_stride=16 \
    --eval_crop_size=$1 \
    --eval_crop_size=$1 \
    --dataset="wetlands" \
	--fine_tune_batch_norm=false \
    --checkpoint_dir="${TRAIN_FOLDER}" \
    --eval_logdir="${EVAL_FOLDER}" \
    --dataset_dir="${DATASET}" \
	--max_number_of_evaluations=1

	echo "Done training, do you want to exit?"
select yn in "Y" "N"; do
  case $yn in
    Y ) exit;;
  esac
done