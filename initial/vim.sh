#!/bin/env bash

source ~/.dotfile/initial/colors.sh
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

        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
        || echo -e -n "${RED}not connect github${RESET} \n"; exit 2 
    fi
}


# Initial VIM
echo "Whether to create stand-form directory link for vim: "
read -r -p "yes/no: " ans
if [[ $ans =~ ^(Y|y) ]];then
    initial_vim
  elif [[ $ans =~ ^(N|n) ]];then
    echo -e "No Link be created\n"
fi
