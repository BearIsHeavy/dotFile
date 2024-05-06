#!/bin/env bash

. $HOME/.dotfile/initial/colors.sh # import colors

# install tmux command
sudo apt install tmux -y || exit 2

# install tldr command
sudo apt install tldr || exit 3
if tldr test > /dev/null 2>&1;then
  echo -e -n "${RED}tldr --update fail${RESET}" 1>&2
  exit 4 
fi

# install shellcheck
if sudo apt install shellcheck;then
  echo -e -n "${RED}shellcheck faile${RESET}" 1>&2
  exit 5
fi

# install exa comamnd
version_ubuntu=$(lsb_release -a 2>/dev/null | grep -Ei 'description' | awk '{print $3}' | awk -F '.' '{print $1}')
if [[ $version_ubuntu -ge 24 ]]; then
  sudo apt install exa || exit 1
else
  ( mkdir -p "$HOME"/Download \
    cd "$HOME"/Download/ \
    && wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip \
    && sudo apt install unzip  \
    && unzip exa-linux-x86_64-0.9.0.zip \
    && mv exa-linux-x86_64 ~/bin \
    && rm -rf "$HOME"/Download ) || exit 2
fi
