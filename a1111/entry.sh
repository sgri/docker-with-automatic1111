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
  groupadd -g $GROUP_ID a1111
fi
user_opts=()
id_group_users=$(getent group users | cut -d: -f3)
if [[ $id_group_users -ne $GROUP_ID ]]; then
  user_opts+=(-G users)
fi 

if id a1111 &>/dev/null; then
  if [[ $(id -g a1111) -ne $GROUP_ID ]]; then
    usermod -u $USER_ID -g $GROUP_ID "${user_opts[@]}" a1111
  fi  
else
  useradd -M -s /bin/bash -u $USER_ID -g $GROUP_ID "${user_opts[@]}" a1111
fi  
unset USER_ID
unset GROUP_ID
exec gosu a1111 /usr/local/bin/start.sh "$@"