#!/usr/bin/env bash
set -euo pipefail

if ! nvidia-smi > /dev/null; then
  echo "NVIDIA GPU is not available. Exiting."
  exit 1
fi

if [[ -z "$USER_ID" ]]; then
  echo "USER_ID environment variable is not set. Please set it to your user ID."
fi
if [[ -z "$GROUP_ID" ]]; then
  echo "GROUP_ID environment variable is not set. Please set it to your user ID."
fi

if ! getent group $GROUP_ID > /dev/null; then
  groupadd -g $GROUP_ID automatik1111
fi
if id automatik1111 &>/dev/null; then
  usermod -u $USER_ID -g $GROUP_ID automatik1111
else
  useradd -M -s /bin/bash -u $USER_ID -g $GROUP_ID automatik1111
fi
   
unset USER_ID
unset GROUP_ID
exec sudo -u automatik1111 /usr/local/bin/start.sh "$@"