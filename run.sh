#!/usr/bin/env bash
set -e
dataDir="${HOME}/.local/share/Stable Diffusion"
mkdir -p "$dataDir/workspace"
mkdir -p "$dataDir/cache"
echo "Using persistent data folder $dataDir."

# Function to run when Ctrl+C is pressed
function handle_sigint {
    echo "Ctrl+C detected, stopping the container."
    docker stop stable-diffusion-webui
    exit 1
}
trap handle_sigint SIGINT

set -x
docker run -e PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:32 \
  --rm \
  --name stable-diffusion-webui \
  -p 7860:7860 \
  --gpus all \
  -u $(id -u) \
  -v "$dataDir/workspace":/home/stable-diffusion/workspace \
  -v "$dataDir/cache":/home/stable-diffusion/.cache \
  stable-diffusion-webui "$@"
