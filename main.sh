#!/usr/bin/env bash
set -e
script=$(basename "$0")
. .activate-pyenv
if [ ! -d workspace ]; then
  echo "The workspace folder is not mounted"
fi
if ! {
  exec 9>workspace/"${script}".lock
  flock -n 9;
}; then
  echo "The $script is already running."
  exit 1
fi
cd workspace
wget -qN https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
chmod +x webui.sh
exec ./webui.sh "$@"