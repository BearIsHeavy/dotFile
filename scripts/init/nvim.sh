#!/bin/env bash

source "$HOME/.dotfile/scripts/init/colors.sh"

install_neovim() {
  read -r -p "Do you decide to install neovim on this computer (y/n): " dec
  if [[ $dec =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo -e "${YELLOW}Downloading neovim from GitHub releases...${RESET}"
    local nvim_url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    local download_dir="$HOME/Downloads"
    mkdir -p "$download_dir"
    curl -L --max-time 180 "$nvim_url" -o "$download_dir/nvim-linux-x86_64.tar.gz" || {
      echo -e "${RED}Failed to download neovim${RESET}" 1>&2
      return 2
    }
    tar -xzf "$download_dir/nvim-linux-x86_64.tar.gz" -C "$download_dir" \
      && sudo mv "$download_dir"/nvim-linux-x86_64 /opt/nvim-linux-x86_64 \
      || { echo -e "${RED}Failed to extract neovim${RESET}" 1>&2; return 2; }
    [[ ! -d "$HOME/bin" ]] && mkdir -p "$HOME/bin"
    ln -sf /opt/nvim-linux-x86_64/bin/nvim "$HOME/bin/nvim"
    echo -e "${GREEN}Neovim installed to /opt/nvim-linux-x86_64${RESET}"
  fi
}

initial_nvim_config() {
  # create .config/nvim symlink
  if [[ -d "$HOME/.config/nvim" || -L "$HOME/.config/nvim" ]]; then
    echo -e "\n${RED}nvim config already exists, do you want to override it?${RESET}\n"
    read -r -p "yes/no: " ans
    if [[ $ans =~ ^([yY]|[yY][eE][sS])$ ]]; then
      rm -rf "$HOME/.config/nvim"
      mkdir -p "$HOME/.config"
      ln -s "$HOME/.dotfile/nvim" "$HOME/.config/nvim"
    fi
  else
    echo -e "Installing...\n"
    mkdir -p "$HOME/.config"
    ln -s "$HOME/.dotfile/nvim" "$HOME/.config/nvim"
  fi
  echo -e "${GREEN}Please open '$HOME/.config/nvim/lua/plugins/plugins-setup.lua' and then type :PackerSync\n${RESET}"
}


# Initial NVIM
echo "Whether to create standard directory link for Neovim: "
read -r -p "yes/no: " ans
if [[ $ans =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
   install_neovim && \
   initial_nvim_config || exit 4
elif [[ $ans =~ ^([Nn]|[Nn][Oo])$ ]]; then
    echo -e "No link will be created\n"
fi


