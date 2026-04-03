#!/bin/env bash

# $? 0 is OK
# $? 2 is not connected to github
# $? 3 is zsh not installed

. "$HOME/.dotfile/scripts/init/colors.sh"

create_autosuggestion() {
    echo -e "Installing autosuggestion model. \n"

    # .zsh including import file that is necessary for zsh
    if [[ -d ${HOME}/.dotfile/.zsh ]]; then
      [[ ! -d $HOME/.zsh ]] && ln -s "$HOME/.dotfile/.zsh/" "$HOME"/
      echo -e -n "${GREEN}please execute command: source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh${RESET} \n"
    else
      git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions \
      || { echo -e "${RED}Check your proxy, unable to connect to GitHub${RESET}" 1>&2; exit 2; }
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

# Offer to set zsh as default shell
if which zsh &> /dev/null && [[ "$SHELL" != *"zsh"* ]]; then
    echo -e "${YELLOW}zsh is installed but not set as your default shell.${RESET}"
    read -r -p "Set zsh as default shell? (y/N): " chsh_ans
    if [[ "$chsh_ans" =~ ^[Yy]$ ]]; then
        chsh -s "$(which zsh)" && echo -e "${GREEN}Default shell changed to zsh. Please re-login to apply.${RESET}" \
            || echo -e "${RED}Failed to change default shell${RESET}" 1>&2
    fi
fi

# Download commands zsh-autosuggestions
if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]];then
    create_autosuggestion
fi

# Download command-not-found (optional on Ubuntu 24.04)
if ! dpkg -l command-not-found > /dev/null 2>&1; then
    sudo apt install -y command-not-found || \
    echo -e "${YELLOW}command-not-found not available (optional)${RESET}"
fi
