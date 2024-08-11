#!/usr/bin/env bash
set -e
dataDir="${HOME}/.stable-diffusion"
mkdir -p "$dataDir/workspace"
mkdir -p "$dataDir/cache"
echo "Using persistent data folder $dataDir."
set -x
docker run -d --name stable-diffusion-webui \
  --network host \
  --restart always \
  --gpus all \
  -v "$dataDir/workspace":/home/stable-diffusion/workspace \
  -v "$dataDir/cache":/home/stable-diffusion/.cache \
  stable-diffusion-webui "$@"