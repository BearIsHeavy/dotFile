#!/bin/env bash

# Used to check whether the script is loaded
TRIGGER_SOURCED=True

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

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

# branch 
if which git > /dev/null;then
    branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
    [[ -n $branch ]] && git_branch="( $branch)" || git_branch=""
fi

# If the judgment logic is related to the following code snippet, you can modify it
# Put the code that detects the logic associated with the path under the horizontal line
# ---------------------------------------relevant code snippet-------------------------------------------------------

# node_version optional open
if type node > /dev/null;then
  node_version="$(node -v)"
  node_version="(🚀: $node_version)"
  _currentPwd="$(/usr/bin/ls $(pwd) | grep 'package.json')"
  if [[ -z ${_currentPwd} ]];then
    _parentPwd="$(/usr/bin/ls $(pwd)/.. | grep 'package.json')"
    if [[ -z ${_parentPwd} ]];then
        _double_parentPwd="$(/usr/bin/ls $(pwd)/../.. | grep 'package.json')"
        [ -z ${_double_parentPwd} ] && unset node_version
    fi
  fi
fi

# The execution of the following code is related to whether the path has changed 
# and consumes large resources 
# and can be optimized by detecting whether the path has changed
# ---------------------------------------relevant code snippet-------------------------------------------------------
PREVIOUS_PATH="$(tail -n 1 "${HOME}/.zsh_history")"
if [[ ${PREVIOUS_PATH} =~ 'cd' ]];then
    # docker environment
    docker_environment="(🐳)"
    _currentPwd="$(/usr/bin/ls $(pwd) | grep -Ei '((d|D)ockerfile)|(docker-compose\.ya?ml)')"
    if [[ -z ${_currentPwd} ]];then
      _parentPwd="$(/usr/bin/ls $(pwd)/.. | grep 'package.json')"
      [ -z ${_parentPwd} ] && unset docker_environment
    fi
fi
