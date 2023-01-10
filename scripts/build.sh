#!/bin/bash

set -eux
set -o pipefail

DATE_TAG=$(date '+%F')
IMAGE_NAME=${1:-grzadr/worklab}
IMAGE_TAG=${2:-${DATE_TAG}}
JUPYTER_IMAGE_NAME=${3:-jupyter/minimal-notebook}
JUPYTER_IMAGE_TAG=${4:-:latest}

docker build --pull \
  -t "${IMAGE_NAME}:${IMAGE_TAG}" \
  --build-arg JUPYTER_IMAGE_NAME=${JUPYTER_IMAGE_NAME} \
  --build-arg JUPYTER_IMAGE_TAG=${JUPYTER_IMAGE_TAG} \
  ./docker

docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "${IMAGE_NAME}:latest"
