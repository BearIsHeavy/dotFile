#!/bin/env bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

PREVIOUS_PATH="$(pwd)"

# check whether the vpn is opened
vpn_proxy="$(env | grep -Ei '.*_proxy=')"
if [[ -n $vpn_proxy ]];then
  vpn_proxy=" (📡)"
else
  unset vpn_proxy
fi

# python virtual environment, not conda environment
[[ -n $VIRTUAL_ENV ]] && python_venv="(🐍 $(basename "$VIRTUAL_ENV"))" || python_venv=''

# conda environment
if [[ -z "$CONDA_DEFAULT_ENV" ]];then
    unset conda_activate_env
else
    conda_activate_env="(🐍 ${CONDA_DEFAULT_ENV})"
fi

if [[ ${PREVIOUS_PATH} == "$(pwd)" ]];then
  return 0
fi

# if judgment logic is related to
# Please place the relevant code snippet below
# ---------------------------------------relevant code snippet-------------------------------------------------------

# branch 
branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
[[ -n $branch ]] && git_branch="( $branch)" || git_branch=""

# node_version optional open
if type node > /dev/null;then
  node_version="$(node -v)"
  node_version="(🚀: $node_version)"
  _currentPwd="$(/usr/bin/ls $(pwd) | grep 'package.json')"
  if [[ -z ${_currentPwd} ]];then
    _parentPwd="$(/usr/bin/ls $(pwd)/.. | grep 'package.json')"
    [ -z ${_parentPwd} ] && unset node_version
  fi
fi

# docker environment
docker_environment="(🐳)"
_currentPwd="$(/usr/bin/ls $(pwd) | grep -Ei '((d|D)ockerfile)|(docker-compose\.ya?ml)')"
if [[ -z ${_currentPwd} ]];then
  _parentPwd="$(/usr/bin/ls $(pwd)/.. | grep 'package.json')"
  [ -z ${_parentPwd} ] && unset docker_environment
fi
