#!/usr/bin/env bash
set -euo pipefail
script=$(basename "$0")

if [[ $(id -u) -eq 0 ]]; then
  echo "The container should not run as root. Please run it as a regular user."
  exit 1
fi

cd
lock_file=${script}.lock
if ! {
  exec 9> $lock_file
  flock -n 9;
}; then
  echo "The program is already running, lock file exists: $lock_file"
  exit 1
fi
export PATH="/opt/python-3.10.14/bin:$PATH"
wget -qN https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
chmod +x webui.sh
exec ./webui.sh "$@"