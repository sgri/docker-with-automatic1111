#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [IMAGE_NAME]

Runs the automatik1111 Docker container.
Arguments:
  IMAGE_NAME   (optional) Docker image name to use. Defaults to 'automatik1111'.
Any additional arguments are passed to 'docker run'.
EOF
  exit 1
}

if [[ $# -gt 1 ]]; then
  usage
  exit 1
fi

image_name="${1:-automatik1111}"
shift || true

dataDir="${HOME}"/.local/share/automatik1111

echo "Using persistent data folder  $dataDir."
for f in workspace cache; do
    folder="$dataDir/$f"
    mkdir -p "$folder"
    echo "Persistent folder $folder will be mounted to the container."
    chmod 777 "$folder"
done

function handle_sigint {
    echo "Ctrl+C detected, stopping the container."
    docker stop automatik1111
    exit 1
}
trap handle_sigint SIGINT


set -x
docker run \
  --rm \
  --name automatik1111 \
  -p 7860:7860 \
  --gpus all \
  -v "$dataDir/workspace":/home/artist/workspace \
  -v "$dataDir/cache":/home/artist/.cache \
  $image_name "$@"