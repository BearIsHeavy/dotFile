#!/bin/bash

echo "Double check running Initial.sh in specifical file(within .dotfile), now in $(pwd)"
if [[ $(basename "$(pwd)") != ".dotfile" ]];then
    echo "switch workspace" && exit 2;
else
	if [[ $(which zsh) == "" ]];then
		echo "runing:sudo apt update && sudo apt install zsh"
		if sudo apt update && sudo apt install zsh; then
			echo "success"
		else
			echo "fail please manuial install"
		fi
	fi
fi



makeLink() {
    fileName="$1"
    [ -f "$HOME/$fileName" ] ||  [ -L "$HOME/$fileName" ] && { rm "$HOME/$fileName"; } || echo "not exsits $fileName"
    ln -s "$HOME/.dotfile/$fileName" ~/
}

create_link() {
    makeLink ".profile"
    makeLink ".zshrc"
    makeLink ".bashrc"
    makeLink ".vimrc"
    makeLink ".gitconfig"
    makeLink ".zsh"
    makeLink ".zshenv"
    makeLink "bin"
    makeLink ".tmux.conf"
    makeLink ".zlogin"
    if [[ -d $HOME/bin ]];then
        mv "$HOME"/bin "$HOME"/bin_back
        ln -s "$(pwd)/bin" ~/
        cp "$HOME"/bin_back/* "$HOME"/bin
        rm -r "$HOME"/bin_back
    fi
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
        mkdir -p "$HOME"/.vim/autoload
        mkdir -p "$HOME"/.vim/backup
        mkdir -p "$HOME"/.vim/colors
        mkdir -p "$HOME"/.vim/plugged
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}


create_autosuggestion() {
    echo -e "Installing autosuggestion model\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    #&& source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
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
echo "bin"
echo ".tmux.conf"
echo ".zlogin"

read -r -p "yes/no: " n

if [[ $n =~ ^[Y|y] ]];then
    create_link
elif [[ $n =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi


# Initial VIM
echo "Whether to create stand-form directory link for vim:"
read -r -p "yes/no: " n
if [[ $n =~ ^[Y|y] ]];then
    initial_vim
elif [[ $n =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi

# Download common command
sudo apt update && sudo apt upgrade \
    && bash "$HOME/.dotfile/request_plugins"

# Download common commands
if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]];then
    which zsh || sudo apt install zsh
    create_autosuggestion
fi



# Options
create_nvm() {
    if [[ -s "$HOME/.nvm" || -d "$HOME/.nvm" ]];then
        echo -e "you had have nvm"
    else
       read -r -p "Do you decide to install nvm in this computer" dec
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


