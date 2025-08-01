#!/usr/bin/env bash
set -euo pipefail
script=$(basename "$0")

if ! nvidia-smi > /dev/null; then
  echo "NVIDIA GPU is not available. Exiting."
  exit 1
fi

. .activate-pyenv
if [ ! -d workspace ]; then
  echo "The workspace folder is not mounted"
fi
lock_file=workspace/${script}.lock
if ! {
  exec 9> $lock_file
  flock -n 9;
}; then
  echo "The $script is already running, lock file exists: $lock_file"
  exit 1
fi
cd workspace
wget -qN https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
chmod +x webui.sh
umask 000 # Let the host user access to the workspace folder
exec ./webui.sh "$@"