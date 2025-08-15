#!/usr/bin/env bash
set -euo pipefail

IMAGE="${automatik1111:-us-central1-docker.pkg.dev/andromeda-456013/amber/automatik1111:nvidia535-cuda12.2-python3.10.14}"
WORKSPACE="$HOME/.local/share/automatik1111"

mkdir -p "$WORKSPACE"
echo -e "Persistent folder \033[1;32m${WORKSPACE}\033[0m will be mounted to the container."

function handle_sigint {
    echo "Ctrl+C detected, stopping the container."
    set -x
    docker stop automatik1111 > /dev/null
    set +x
    exit 1
}
trap handle_sigint SIGINT

if docker ps -a --format '{{.Names}}' | grep -qx automatik1111; then
    set -x
    docker start automatik1111 > /dev/null
    docker attach automatik1111
    set +x
else
  user_id=$(id -u)
  group_id=$(id -g)
  set -x
  docker run \
   -e USER_ID=$user_id \
   -e GROUP_ID=$group_id \
   --name automatik1111 \
   -p 7860:7860 \
   --gpus all \
   -v "$WORKSPACE":/home/automatik1111 \
   $IMAGE "$@"
fi   