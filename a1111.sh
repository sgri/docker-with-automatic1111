#!/usr/bin/env bash
set -euo pipefail
readonly APP=a1111

usage() {
  cat <<EOF
Usage: $(basename "$0") COMMAND WEBUI_OPTIONS

Runs Automatik1111 in a Docker container. Creates a configuration file at $HOME/.config/$APP/config.rc if it does not exist.

Automatik1111 is a free and open-source web-based interface for Stable Diffusion.
Automatik1111 project page: https://github.com/AUTOMATIC1111/stable-diffusion-webui

COMMAND is one if the following:
  help           Show this help message.
  run            Start the container if it doesn't already exist, else attach to the existing container.
  pull           Pull the latest image from the registry.

WEBUI_OPTIONS
  A list of options will be passed to the webui.sh script inside the container.

Examples:
  $(basename "$0") run --help
      Prints the available options for webui.sh script.
  $(basename "$0") run --api --listen --xformers --enable-insecure-extension-access --update-check --medvram-sdxl
      Starts the container with the specified options.
  $(basename "$0") pull
      Pulls the latest Docker image from the registry.
EOF
}

if [[ $# -eq 0 ]]; then
    usage
    exit 1
fi
cmd=$1
shift
config_file="${HOME}/.config/$APP/config.rc"
if [ ! -f "$config_file" ]; then
  mkdir -p "$(dirname "$config_file")"
  cat <<EOF > "$config_file"
IMAGE=ghcr.io/sgri/amber/a1111:nvidia535-cuda12.2-python3.10.14
WORKSPACE=$HOME/.local/share/$APP
PORT=7860
DOCKER_OPTS="--gpus all -e STABLE_DIFFUSION_REPO=https://github.com/w-e-w/stablediffusion.git"
EOF
  echo "Configuration file created at $config_file"
fi

. "$config_file"
echo "Using configuration from $config_file"

if [[ "$cmd" == "help" ]]; then
    usage
    exit
elif [[ "$cmd" == "pull" ]]; then
    set -x
    docker pull $IMAGE
    exit
elif [[ "$cmd" == "run" ]]; then
   : # This is a no-op, the actual run command is handled later
else
    echo "Unknown command: $cmd"
    usage
    exit 1
fi

mkdir -p "$WORKSPACE"
echo -e "Workspace folder \e[1m${WORKSPACE}\e[0m will be mounted to the container."
if touch "$WORKSPACE/.writetest" 2>/dev/null; then
    rm "$WORKSPACE/.writetest"
else
    echo "$WORKSPACE is not writable."
    exit 1
fi

trap 'docker stop a1111 >/dev/null 2>&1 || true' INT TERM EXIT

user_id=$(id -u)
group_id=$(id -g)
set -x
docker run --rm $DOCKER_OPTS \
    -e USER_ID=$user_id \
    -e GROUP_ID=$group_id \
    --name $APP \
    -p $PORT:$PORT \
    -v "$WORKSPACE":/home/$APP \
    $IMAGE \
    "$@"