#!/usr/bin/env bash

# Used to check whether the script is loaded
TRIGGER_SOURCED=True

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Reset variables that may persist from previous sourcing
unset vpn_proxy python_venv conda_activate_env git_branch node_version docker_environment

# check whether the vpn is opened
if env | grep -qEi '.*_proxy='; then
  vpn_proxy=" (📡)"
fi

# python virtual environment, not conda environment
if [[ -n $VIRTUAL_ENV ]]; then
  python_venv="(🐍 $(basename "$VIRTUAL_ENV"))"
fi

# conda environment
if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
  conda_activate_env="(🐍 ${CONDA_DEFAULT_ENV})"
fi

# branch
if command -v git > /dev/null 2>&1; then
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  if [[ -n "$branch" && "$branch" != "HEAD" ]]; then
    git_branch="( $branch)"
  fi
fi

# node_version optional open
if command -v node > /dev/null 2>&1; then
  if [[ -f "package.json" || -f "../package.json" || -f "../../package.json" ]]; then
    node_version="(🚀: $(node -v))"
  fi
fi

# docker environment detection
if command -v docker > /dev/null 2>&1 && [[ -f "${HOME}/.zsh_history" ]]; then
  last_cmd=$(tail -n 1 "${HOME}/.zsh_history")
  if [[ "$last_cmd" == *"cd"* ]]; then
    if [[ -f "Dockerfile" || -f "docker-compose.yml" || -f "docker-compose.yaml" ]]; then
      docker_environment="(🐳)"
    fi
  fi
fi
