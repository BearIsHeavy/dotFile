#!/bin/env bash

. "$HOME/.dotfile/scripts/init/colors.sh"

test_connection() {
  if ! curl --max-time 5 --head https://github.com > /dev/null 2>&1; then
    echo -e "${RED}Failed to connect to GitHub${RESET}" 1>&2
    return 2
  else
    echo -e "${GREEN}Successfully connected to GitHub${RESET}"
  fi
}


config_clash() {
  echo -e "${GREEN}Use vim/nvim to edit Download/Clash/.env${RESET}"
  echo -e "${GREEN}sudo bash start.sh${RESET}"
}

install_clash() {
  if [[ ! -d ~/Download/Clash ]]; then
    mkdir -p ~/Download \
      && cd ~/Download \
      && git clone https://github.com/Elegycloud/clash-for-linux-backup.git \
      && mv clash-for-linux-backup Clash \
      && config_clash \
      || { echo -e "${RED}Installation failed${RESET}" 1>&2; return 3; }
  else
    test_connection || config_clash
  fi
}

install_clash
