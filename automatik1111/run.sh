#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [-h] [-i IMAGE_NAME] [-- additional docker args]

Runs the automatik1111 Docker container.

Options:
  -h              Show this help message and exit.
  -d              Persistent data folder. Defaults to ~/.local/share/automatik1111.
  -i IMAGE_NAME   Docker image name to use. Defaults to 'automatik1111'.

Any additional arguments after '--' are passed to 'docker run'.
EOF
  exit 0
}

image_name="automatik1111"
data_folder="$HOME/.local/share/automatik1111"

while getopts ":hi:d:" opt; do
  case $opt in
    h)
      usage
      ;;
    d):
      data_folder="$OPTARG"
      ;;
    i)
      image_name="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

mkdir -p "$data_folder"
echo -e "Persistent folder \033[0;32m${data_folder}\033[0m will be mounted to the container."

function handle_sigint {
    echo "Ctrl+C detected, stopping the container."
    docker stop automatik1111
    exit 1
}
trap handle_sigint SIGINT

set -x
docker run \
  --rm \
  -e USER_ID="$(id -u)" \
  -e GROUP_ID="$(id -g)" \
  --name automatik1111 \
  -p 7860:7860 \
  --gpus all \
  -v "$data_folder":/home/automatik1111 \
  $image_name "$@"