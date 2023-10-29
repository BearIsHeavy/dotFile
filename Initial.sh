#!/bin/bash

makeLink()
{
    fileName="$1"
    [ -f $HOME/$fileName || -L $HOME/$fileName ] && { rm $HOME/$fileName; } || echo "not exsits $fileName"
    ln -s $HOME/.dotfile/$fileName ~
}

makeLink ".profile"
makeLink ".zshrc"
makeLink ".bashrc"
makeLink ".vimrc"