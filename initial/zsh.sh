#!/bin/env bash

# $? o is OK
# $? 2 is not connect github
# $? 3 is not install zsh

. $HOME/.dotfile/initial/colors.sh # import color fime

create_autosuggestion() {
    echo -e "Installing autosuggestion model. \n"

    # .zsh including import file that is necessary for zsh
    if [[ -d ${HOME}/.dotfile/.zsh ]]; then
      [[ ! -d $HOME/.zsh ]] && ln -s "$HOME/.dotfile/.zsh/" "$HOME"/
      echo -e -n "${GREEN}please execute command: source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh${RESET} \n"
    else
      git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions \
        || echo -e -n "${RED}please checkout your proxy, which dont't connect github${RESET} \n"; exit 2
    fi
}

# Download install zsh
if ! which zsh 1>/dev/null; then
	echo -e -n "${GREEN}Prepare to running: sudo apt update && sudo apt install zsh${RESET} \n"

	if sudo apt update && sudo apt install zsh; then
		echo -e "Install zsh Successfully \n"
	else
		echo -e "Download Fail please manuial install zsh \n" 1>&2 && exit 2
	fi
fi

# Download commands zsh-autosuggestions
if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]];then
    create_autosuggestion
fi

# Download command-not-found
if ! sudo apt install command-not-found; then
  echo -e -n "${RED}not install command-not-found${RESET}"
  exit 3
fi
