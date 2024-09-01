#!/usr/bin/env bash
set -e
user_id=$(id -u)
docker build --progress=plain . --build-arg USER_ID=$user_id -t stable-diffusion-webui