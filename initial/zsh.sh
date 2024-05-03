#!/bin/env bash

# $? o is OK
# $? 2 is not connect github
# $? 3 is not install zsh

if ! which zsh 1>/dev/null; then
	echo "read to running: sudo apt update && sudo apt install zsh"
	if sudo apt update && sudo apt install zsh; then
		echo -e "success \n"
	else
		echo -e "fail please manuial install zsh \n" 1>&2 && exit 3
	fi
fi

create_autosuggestion() {
    echo -e "Installing autosuggestion model. \n"

    # .zsh including import file that is necessary for zsh
    if [[ -d $HOME/.dotfile/.zsh ]]; then
      [[ ! -d $HOME/.dotfile/.zsh ]] && ln -s "$HOME/.dotfile/.zsh/" $HOME/
      echo -e "please execute command: source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh \n"
    else
      git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions \
        || {echo -e "please checkout your proxy, which dont't connect github \n" && exit 2}
    fi
}


# Download commands zsh-autosuggestions
if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]];then
    which zsh || sudo apt install zsh
    create_autosuggestion
fi
