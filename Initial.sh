#!/bin/bash

echo "Double check running Initial.sh in specifical file(within .dotfile), now in $(pwd)"
if [[ $(basename "$(pwd)") != ".dotfile" ]];then
    echo "switch workspace" && exit 2;
fi

makeLink() {
    fileName="$1"
    [ -f "$HOME/$fileName" ] ||  [ -L "$HOME/$fileName" ] \
      && { rm "$HOME/$fileName"; } || echo -e "not exsits $fileName \n"
    ln -s "$HOME/.dotfile/$fileName" ~/
}

create_link() {
    makeLink ".profile"
    makeLink ".bashrc"
    makeLink ".vimrc"
    makeLink ".gitconfig"
    makeLink ".zsh"
    makeLink ".zshrc"
    makeLink ".zshenv"
    makeLink ".zlogin"
    makeLink "bin"
    makeLink ".tmux.conf"
    if [[ -d $HOME/bin ]];then
        mv "$HOME"/bin "$HOME"/bin_back
        ln -s "$(pwd)/bin" ~/
        cp "$HOME"/bin_back/* "$HOME"/bin
        rm -r "$HOME"/bin_back
    fi
}

# The following code is used to interact with the user
echo "If to create a file for the following files:"
echo ".profile"
echo ".bashrc"
echo ".vimrc"
echo ".gitconfig"
echo ".zsh"
echo ".zshenv"
echo ".zshrc"
ehoc ".zlogin"
echo "bin"
echo ".tmux.conf"
echo ".zlogin"

read -r -p "yes/no: " n

if [[ $n =~ ^[Y|y] ]];then
    create_link
elif [[ $n =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi


# initial vpn, if running have a error, return 11
/bin/bash $HOME/.dotfile/initial/vim || exit 11

# initial zsh, if running have a error, return 12
/bin/bash $HOME/.dotfile/initial/zsh.sh || exit 12

# initial vim, if running have a error, return 13
/bin/bash $HOME/.dotfile/initial/vim || exit 13

# initial nvim, if running have a error, return 14
/bin/bash $HOME/.dotfile/initial/nvim || exit 14






