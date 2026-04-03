#!/bin/env bash

source "$HOME/.dotfile/scripts/init/colors.sh"
initial_vim() {
    # delete .vim fold
    [[ -d "$HOME/.vim" || -f "$HOME/.vim" || -L "$HOME/.vim" ]] && rm -r "$HOME/.vim"

    # make a direct vim    
    mkdir -p "$HOME/.vim"

    # make vim fold struct
    if [[ -d "$HOME/.vim" ]];then
        mkdir -p "$HOME"/.vim/autoload
        mkdir -p "$HOME"/.vim/backup
        mkdir -p "$HOME"/.vim/colors
        mkdir -p "$HOME"/.vim/plugged

        if curl -fsSL --max-time 5 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null; then
          curl -fsSL -o ~/.vim/autoload/plug.vim \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
          echo -e -n "${RED}Don't connect github${RESET} \n"
          exit 2
        fi

    fi
}

# Initial VIM
echo "Whether to create standard directory structure for Vim: "
read -r -p "yes/no: " ans
if [[ $ans =~ ^([Yy]|[Yy][eE][sS])$ ]]; then
    initial_vim
elif [[ $ans =~ ^([Nn]|[Nn][oO])$ ]]; then
    echo -e "No directory will be created\n"
fi
