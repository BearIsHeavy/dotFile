#!/bin/env bash

. $HOME/.dotfile/initial/colors.sh # import color file

test_connection() {
  if ! curl --max-time 5 www.google.com -i; then
    echo -e -n "${RED}Not connection github etc${RESET} \n" 1>&2; exit 2
  else
    echo -e -n "${GREEN}Sucessfully to connecte github etc.${RESET}"
  fi
}


config_clash() {
  echo -e -n "${GREEN}use vim/nvim to open Download/Clash/.env${RESET}";
  echo -e -n "${GREEN}sudo bash start.sh${RESET}";
}

install_clash() {
  if [[ ! -d ~/Download/Clash ]];then
    ( mkdir -p ~/Download \
      && cd ~/Download  \
      && git clone https://github.com/Elegycloud/clash-for-linux-backup.git \
      && mv clash-for-linux-backup  Clash ) \
    && config_clash; exit 0
    || echo -e -n "${RED}install Failed...${RESET}\n"; exit 3
  else
    (test_connection) || config_clash
  fi
}

install_clash
