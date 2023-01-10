#!/bin/bash

set -eu
set -o pipefail

IMAGE_NAME='grzadr/worklab'
IMAGE_TAG="$(date '+%F')"
JUPYTER_IMAGE_NAME='jupyter/minimal-notebook'
JUPYTER_IMAGE_TAG="@$(./scripts/latest_checksum.sh)"

echo "IMAGE_NAME: ${IMAGE_NAME}"
echo "IMAGE_TAG: ${IMAGE_TAG}"
echo "JUPYTER_IMAGE_NAME: ${JUPYTER_IMAGE_NAME}"
echo "JUPYTER_IMAGE_TAG: ${JUPYTER_IMAGE_TAG}"

./scripts/update_packages.sh \
  ${IMAGE_NAME}

./scripts/build.sh \
  ${IMAGE_NAME} \
  ${IMAGE_TAG} \
  ${JUPYTER_IMAGE_NAME} \
  ${JUPYTER_IMAGE_TAG}

./scripts/push_images.sh \
  ${IMAGE_NAME} \
  ${IMAGE_TAG}
