#!/bin/env bash

source ~/.dotfile/initial/colors.sh

install_nvm() {
  read -r -p "Do you decide to install neovim in this computer(y/n): " dec
  if [[ $dec =~ ^(y|Y) ]];then
    ( cd ~/.dotfile/Download \
        && tar -xvzf "$HOME"/.dotfile/Download/nvim-linux64.tar.gz \
        && sudo mv nvim-linux64/ /opt/nvim-linux64 \
    ) || exit 2
    [[ ! -d /$HOME/bin ]] && mkdir -p $HOME/bin && ln -s /opt/nvim-linux64/bin/nvim $HOME/bin
  fi
}

initial_nvim_config() {
  # create .config/nvim format
  if [[ -d $HOME/.config/nvim || -L $HOME/.config/nvim ]]; then
    echo -e "\n ${RED}nvim config file existed, do you want to override it?${RESET} \n"
    read -r -p "yes/no: " ans
    if [[ $ans =~ ^(y|Y) ]]; then
      # make .config direcotry
      ( rm -rf "$HOME"/.config/nvim \
          && mkdir -p "$HOME"/.config/ \
          && ln -s "$HOME"/.dotfile/nvim "$HOME"/.config 1>/dev/null)
    fi
  else
    echo -e -n "Installing...\n"
    mkdir -p "$HOME"/.config/nvim && ln -s "$HOME"/.dotfile/nvim "$HOME"/.config
  fi
  echo -e "${GREEN}please access '$HOME'/.config/nvim/lua/plugins/plugins-setup.lua and then type :PackerSync \n${RESET}"
}

manual_plugin_installation() {
  cp -r $HOME/.dotfile/Download/nvim/ $HOME/.local/share/nvim
}


# Initial NVIM
echo "Whether to create stand-form directory link for Neovim: "
read -r -p "yes/no: " ans
if [[ $ans =~ ^(Y|y) ]];then
   install_nvm && \
   initial_nvim_config || exit 4
   manual_plugin_installation
elif [[ $ans =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi


