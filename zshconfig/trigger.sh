#!/bin/env bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

if [[ -z "$CONDA_DEFAULT_ENV" ]];then
  unset conda_activate_env
else
  if [[ ${CONDA_DEFAULT_ENV} == "base" ]];then
    unset conda_activate_env
  else
    conda_activate_env="(🐍 ${CONDA_DEFAULT_ENV})"
  fi
fi

# optional open
node_version="$(node -v)"
node_version="(🚀: $node_version)"
_currentPwd="$(/usr/bin/ls $(pwd) | grep 'package.json')"
if [[ -z ${_currentPwd} ]];then
  _parentPwd="$(/usr/bin/ls $(pwd)/.. | grep 'package.json')"
  [ -z ${_parentPwd} ] && unset node_version
fi
