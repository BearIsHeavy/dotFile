#!/bin/bash

echo "Double check running Initial.sh in specifical file(within .dotfile), now in $(pwd)"
if [[ $(basename "$(pwd)") != ".dotfile" ]];then
    echo "switch workspace" && exit 2;
fi

makeLink() {
    fileName="$(basename $1)"
    [ -f "$HOME/$fileName" ] ||  [ -L "$HOME/$fileName" ] \
      && { rm "$HOME/$fileName"; } || echo -e "not exsits $fileName \n"
    ln -s "$HOME/.dotfile/$1" ~/
}

create_link() {
    makeLink ".zsh"

    makeLink "generalConfig/.profile"
    makeLink "generalConfig/.bashrc"
    makeLink "generalConfig/.vimrc"
    makeLink "generalConfig/.tmux.conf"

    makeLink "zshconfig/.zshrc"
    makeLink "zshconfig/.zshenv"
    makeLink "zshconfig/.zlogin"
    if [[ -d $HOME/bin ]];then
        mv "$HOME"/bin "$HOME"/bin_back
        ln -s $HOME/.dotfile/bin ~/
        cp "$HOME"/bin_back/* "$HOME"/bin
        rm -r "$HOME"/bin_back
    else
        ln -s $HOME/.dotfile/bin $HOME/
    fi
}

# The following code is used to interact with the user
echo "Whether to create a file for the following files:"
echo ".profile"
echo ".bashrc"
echo ".vimrc"
echo ".gitconfig"
echo "bin"
echo ".tmux.conf"
echo ".zshenv"
echo ".zshrc"
echo ".zlogin"
echo ".zsh"

read -r -p "yes/no: " n

if [[ $n =~ ^[Y|y] ]];then
    create_link
elif [[ $n =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi



# initial vpn, if running have a error, return 11
echo -e -n "whether install vpn config.(Note: This command recommand you Separate execution ${RED}bash vpn.sh${RESET} command) yes/no: "
read ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/vpn.sh || exit 11
fi

# initial zsh, if running have a error, return 12
read -p "whether install zsh config yes/no: " ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/zsh.sh || exit 12
fi

# initial vim, if running have a error, return 13
read -p "whether install VIM yes/no: " ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/vim.sh || exit 13
fi

# initial nvim, if running have a error, return 14
read -p "whether install NeoVIM yes/no: " ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/nvim.sh || exit 14
fi

# install other command wich used in daily work
read -p "install other command which used in daily work yse/no " ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/otherCommand.sh || exit 15
fi

# install termianl font
read -p "install termianl fonts which used in daily work to display exa icons etc. yse/no " ans
if [[ $ans =~ ^(y|Y) ]];then
  /bin/bash ~/.dotfile/initial/otherCommand.sh || exit 15
fi

