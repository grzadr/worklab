#!/bin/bash

set -eux
set -o pipefail

echo "INPUT ARGS: $@"

while getopts 'v:l:p:n:db' OPTION; do
  case "$OPTION" in
    l)
      ARG_LABEL="$OPTARG"
            echo "LABEL: '$OPTARG'"
      ;;
    v)
      ARG_VOLUME="$OPTARG"
      echo "VOLUME: '$ARG_VOLUME'"
      ;;
    p)
      ARG_PORT="$OPTARG"
      echo "PORT: '$ARG_PORT'"
      ;;
    n)
      ARG_NAME="$OPTARG"
      echo "NAME: $ARG_NAME"
      ;;
    d)
      ARG_BACKGROUND=true
      echo "BACKGROUND: '$ARG_COMMAND'"
      ;;
    b)
      ARG_BASH=true
      echo "BASH: '$ARG_BASH'"
      ;;
    ?)
      echo "script usage: $(basename $0) [-l label] [-v volume] [-p port] [-d] [-b] [...]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

DOCKER_COMMAND='docker run -it --rm'
DOCKER_COMMAND+=" --name ${ARG_NAME:-Jupyter}"
DOCKER_COMMAND+=" -p ${ARG_PORT:-8888}:8888"
DOCKER_COMMAND+=" -v ${ARG_VOLUME:-$(pwd)}:/home/jovyan/work"
DOCKER_COMMAND+=" --workdir /home/jovyan/work"

if [[ "${ARGS_BACKGROUND:-false}" = true ]]; then
  DOCKER_COMMAND+=" -d"
fi

DOCKER_COMMAND+=" grzadr/worklab:${ARG_LABEL:-latest}"

if [[ "${ARG_BASH:-false}" = true ]]; then
  DOCKER_COMMAND+=' /bin/bash'
elif (( $# > 0 )); then
  DOCKER_COMMAND+=" /bin/bash -c \"$*\" --"
fi

eval $DOCKER_COMMAND
