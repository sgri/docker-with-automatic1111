#!/usr/bin/env bash
set -euo pipefail

dataDir="${HOME}"/.local/share/automatik1111

echo "Using persistent data folder  $dataDir."
for f in workspace cache; do
    folder="$dataDir/$f"
    mkdir -p "$folder"
    echo "Persistent folder $folder will be mounted to the container."
    chmod 777 "$folder"
done

# Function to run when Ctrl+C is pressed
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
  us-central1-docker.pkg.dev/andromeda-456013/amber/automatik1111 "$@"
