#!/bin/bash

echo "you should running Initial.sh in specifical file, now in $(pwd)"
if [[ $(basename "$(pwd)") != ".dotfile" ]];then
    echo "switch workspace" && exit;
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
       read -r "Do you decided install nvm in this computer" dec
       echo "$dec"
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

