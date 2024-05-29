#!/bin/env bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

# trigger for conda_env
last_command="$(tail -n 1 <(history) | cut -d " " -f 4-)"
# inherit activate_env from .zprofile
# fetch conda_checkout command
conda_checkout="$(echo $last_command | awk '{print substr($0, 0, 32)}')"

if [[ "$conda_checkout" =~ "^(conda) (activate)" ]];then
  conda_activate_env="(🐍 $(echo $conda_checkout | awk '{print $3}'))"
elif [[ "$conda_checkout" =~ "^(conda) (deactivate)" ]];then
  unset conda_activate_env
fi

node_version="$(node -v)"
if [[ -n $node_version ]];then
  node_version="(${RED}node${RESET}: $node_version)"
else
  unset node_version
fi
