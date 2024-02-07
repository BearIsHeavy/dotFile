#!/bin/bash

echo "Double check running Initial.sh in specifical file(within .dotfile), now in $(pwd)"
if [[ $(basename "$(pwd)") != ".dotfile" ]];then
    echo "switch workspace" && exit 2;
fi

makeLink()
{
    fileName="$1"
    [ -f "$HOME/$fileName" ] ||  [ -L "$HOME/$fileName" ] && { rm "$HOME/$fileName"; } || echo "not exsits $fileName"
    ln -s "$HOME/.dotfile/$fileName" ~/
}

create_link()
{
    makeLink ".profile"
    makeLink ".zshrc"
    makeLink ".bashrc"
    makeLink ".vimrc"
    makeLink ".gitconfig"
    makeLink ".zsh"
    ln -s "$(pwd)/bin" ~/
}



initial_vim() {
    # delete .vim fold
    if [[ -d "$HOME/.vim" || -f "$HOME/.vim" || -L "$HOME/.vim" ]];then
        rm -r "$HOME/.vim"
    fi
    # make a direct vim    
    mkdir -p "$HOME/.vim"
    # make vim fold struct
    if [[ -d "$HOME/.vim" ]];then
        mkdir autoload
        mkdir backup
        mkdir colors
        mkdir plugged
    fi
}


create_nvm() {
    if [[ -s "$HOME/.nvm" || -d "$HOME/.nvm" ]];then
        echo -e "you had have nvm"
    else
       read -r "Do you decide to install nvm in this computer" dec
       if [[ $dec != "no" && $dec != "N" && $dec != "n" ]];then
           code="curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash"
          if [[ $code == 0 ]];then
              echo "success"
          else
              echo "fail"
          fi
      fi
    fi
}

####The following code is used to interact with the user####
echo "Whether to create a file for the following files:"
echo ".profile"
echo ".zshrc"
echo ".bashrc"
echo ".vimrc"
echo ".gitconfig"
echo ".zsh"
read -p -r "yes/no" n

if [[ $n =~ ^[Y|y] ]];then
    create_link
elif [[ $n =~ ^[N|n] ]];then
    echo "No Link be created"
fi

echo "Whether to create dirtion link for vim:"
read -p -r "yes/no" n
if [[ $n =~ ^[Y|y] ]];then
    initial_vim
elif [[ $n =~ ^[N|n] ]];then
    echo "No Link be created"
fi
