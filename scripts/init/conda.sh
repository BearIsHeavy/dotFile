#!/bin/bash
# This file is used to install conda,
# but it is not recommended to use this method.
# Please download and install the latest version from the official website.

source "$HOME/.dotfile/scripts/init/colors.sh"

(nvcc --version || sudo apt install nvidia-cuda-toolkit -y) && nvcc --version

# Install prerequisites
sudo apt install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# Installation
conda_installer="Anaconda3-2024.02-1-Linux-x86_64.sh"
conda_url="https://repo.anaconda.com/archive/$conda_installer"
expected_sha="c536ddb7b4ba738bddbd4e581b29308cb332fa12ae3fa2cd66814bd735dff231"

if curl --max-time 30 -o "$HOME/Download/$conda_installer" -OL "$conda_url"; then
  check_sha=$(sha256sum "$HOME/Download/$conda_installer" | awk '{print $1}')
  if [[ $check_sha == "$expected_sha" ]]; then
    bash "$HOME/Download/$conda_installer"
  else
    echo -e "${RED}SHA256 mismatch! Expected: $expected_sha, Got: $check_sha${RESET}" 1>&2
    exit 2
  fi
else
  # No network connection, try local file
  echo -e "${RED}Network connection error, trying to use local file...${RESET}"
  if [[ -s "$HOME/Download/$conda_installer" ]]; then
    check_sha=$(sha256sum "$HOME/Download/$conda_installer" | awk '{print $1}')
    echo -e "\n${GREEN}$check_sha${RESET}\n"
    if [[ $check_sha == "$expected_sha" ]]; then
      bash "$HOME/Download/$conda_installer"
    else
      echo -e "${RED}SHA256 mismatch for local file${RESET}" 1>&2
      exit 2
    fi
  else
    echo -e "${RED}No local conda installer found${RESET}" 1>&2
    exit 2
  fi
fi

exit 0
