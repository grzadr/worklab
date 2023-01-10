#!/bin/bash

set -eu
set -o pipefail

IMAGE_NAME=${1:-grzadr/worklab}
IMAGE_TAG=${2:-:latest}
CONDA_LIST=${3:-docker/packages/conda.list}
CONTAINER_NAME=${4:-worklab_update_packages_$(date '+%s')_$RANDOM}

docker run \
  --rm \
  -it \
  --name ${CONTAINER_NAME} \
  "${IMAGE_NAME}${IMAGE_TAG}" \
  scripts/conda_update_list.sh > $CONDA_LIST
