#!/bin/bash

makeLink()
{
    fileName="$1"
    [ -f $HOME/$fileName -o -L $HOME/$fileName ] && { rm $HOME/$fileName; } || echo "not exsits $fileName"
    ln -s $HOME/.dotfile/$fileName ~
}

makeLink ".profile"
makeLink ".zshrc"
makeLink ".bashrc"
makeLink ".vimrc"
makeLink ".gitconfig"

ln -s $(pwd)/bin ~/
