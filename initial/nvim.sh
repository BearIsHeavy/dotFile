#!/bin/env bash

install_nvm() {
  if [[ -s "$HOME/.nvm" || -d "$HOME/.nvm" ]];then
    echo -e "you had have nvm"
  else
    read -r -p "Do you decide to install nvm in this computer(y/n): " dec
    if [[ $dec =~ ^(y|Y) ]];then
      ( 
        tar -xvzf "$HOME"/.dotfile/Download/nvim-linux64.tar.gz \
          && mv nvim-linux64/bin/nvim "$HOME"/bin \
          && rm -rf nvim-linux64
      ) || exit 2
    fi
  fi
}

initial_nvim_config() {
  # create .config/nvim format
  if [[ -d $HOME/.config/nvim || -L $HOME/.config/nvim ]]; then
    echo -e "nvim config file existed, do you want to override it? \n"
    read -p -r "yes/no" ans
    if [[ $ans =~ ^(n|N) ]]; then
      exit 0
    fi

    # make .config direcotry
    ( rm -rf "$HOME"/.config/nvim \
        && make -p "$HOME"/.config/nvim \
        && cp -r "$HOME"/.dotfile/nvim "$HOME"/.config )
  else
    make -p "$HOME"/.config/nvim && ln -s "$HOME"/.dotfile/nvim "$HOME"/.config
  fi
  echo -e "please access nvim/lua/plugins/plugins-setup.lua the type :PackerSync"
}


# Initial NVIM
echo "Whether to create stand-form directory link for Neovim: "
read -r -p "yes/no: " ans
if [[ $ans =~ ^(Y|y) ]];then
   install_nvm && initial_nvim_config || echo "Initial NVIM Fail"; exit 3
elif [[ $ans =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi
