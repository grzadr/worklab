#!/bin/bash

set -eux
set -o pipefail

SOURCE_IMAGE_NAME=${1:-jupyter/minimal-notebook}

docker pull -q jupyter/minimal-notebook:latest > /dev/null
docker images --format "{{.Repository}}|{{.Digest}}|{{.CreatedAt}}" | \
  grep "^${SOURCE_IMAGE_NAME}|" | \
  sort -t '|' -k 3 -r | \
  head -n 1 | \
  cut -d'|' -f 2
