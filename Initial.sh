#!/bin/bash

makeLink()
{
    fileName="$1"
    [ -f $HOME/$fileName -o -L $HOME/$fileName ] && { rm $HOME/$fileName; } || echo "not exsits $fileName"
    ln -s "$HOME/.dotfile/$fileName" ~
}

makeLink ".profile"
makeLink ".zshrc"
makeLink ".bashrc"
makeLink ".vimrc"
makeLink ".gitconfig"

ln -s "$(pwd)/bin" ~/

if [[ -d "$HOME/.vim" || -f "$HOME/.vim" || -L "$HOME/.vim" ]];then
    rm -r "$HOME/.vim"
fi

mkdir -p "$HOME/.vim"

if [[ -d "$HOME/.vim" ]];then
    mkdir autoload
    mkdir backup
    mkdir colors
    mkdir plugged
fi
