#!/bin/bash
#
# Modified from convert_cityscapes.sh, by: Gina O'Neil
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

# Exit immediately if a command exits with a non-zero status.
#set -e

# Update PYTHONPATH.
#export PATH=$PATH:`pwd`:`pwd`/slim

CURRENT_DIR=$(pwd)
WORK_DIR="${CURRENT_DIR}/wetlands"

# Root path for Wetlands dataset.
WETLANDS_ROOT="${WORK_DIR}/dataset"

SEG_FOLDER="${WETLANDS_ROOT}/SegmentationClass"
SEMANTIC_SEG_FOLDER="${WETLANDS_ROOT}/SegmentationClass" #same because we did not remove colormap 

# Build TFRecords of the dataset.
# First, create output directory for storing TFRecords.
OUTPUT_DIR="${WORK_DIR}/tfrecord"
mkdir -p "${OUTPUT_DIR}"
 
IMAGE_FOLDER="${WETLANDS_ROOT}/JPEGImages"
LIST_FOLDER="${WETLANDS_ROOT}/ImageSets"

echo "Converting Wetlands dataset..."

#pycharm (py35) env has tensorflow installed

"C:/Anaconda2/envs/pycharm/python" "${CURRENT_DIR}/build_wetlands_data.py" \
  --image_folder="${IMAGE_FOLDER}" \
  --semantic_segmentation_folder="${SEG_FOLDER}" \
  --list_folder="${LIST_FOLDER}" \
  --image_format="jpg" \
  --label_format="png" \
  --output_dir="${OUTPUT_DIR}"
