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

node_version="$(node -v)"
if [[ -n $node_version ]];then
  node_version="(${RED}node${RESET}: $node_version)"
else
  unset node_version
fi
