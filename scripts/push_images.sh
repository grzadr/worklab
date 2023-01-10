#!/bin/bash

set -eux
set -o pipefail

DATE_TAG=$(date '+%F')

IMAGE_NAME=${1:-grzadr/worklab}
IMAGE_TAG=${2:-${DATE_TAG}}

docker push "${IMAGE_NAME}:${IMAGE_TAG}"
docker push "${IMAGE_NAME}:latest"
