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
INIT_FOLDER="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/init_models"
TRAIN_LOGDIR="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/${EXP_FOLDER}/train"
DATASET="${WORK_DIR}/${DATASET_DIR}/${WETLANDS_FOLDER}/tfrecord"

mkdir -p "${INIT_FOLDER}"
mkdir -p "${TRAIN_LOGDIR}"


NUM_ITERATIONS=$1

#tensorflow (py35) env has tensorflow installed
"C:/Anaconda2/envs/tensorflow/python" "${WORK_DIR}/train.py" \
  --logtostderr \
  --train_split="train" \
  --model_variant="xception_65" \
  --atrous_rates=6 \
  --atrous_rates=12 \
  --atrous_rates=18 \
  --output_stride=16 \
  --train_crop_size=$2 \
  --train_crop_size=$2 \
  --train_batch_size=4 \
  --training_number_of_steps="${NUM_ITERATIONS}" \
  --base_learning_rate=0.0001 \
  --dataset="wetlands" \
  --fine_tune_batch_norm=false \
  --train_logdir="${TRAIN_LOGDIR}" \
  --initialize_last_layer=false \
  --dataset_dir="${DATASET}" \
  --num_clones=2 \
  --save_summaries_secs=300 \
  --save_interval_secs=600 \
  --save_summaries_images=true

echo "Done training, do you want to exit?"
select yn in "Y" "N"; do
  case $yn in
    Y ) exit;;
  esac
done

#--tf_initial_checkpoint="" \ uncomment flag's requirement to use
