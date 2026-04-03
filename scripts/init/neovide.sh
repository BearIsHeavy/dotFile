#!/bin/env bash

source "$HOME/.dotfile/scripts/init/colors.sh"

( sudo apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev
) && echo -e "\n\n${GREEN}All necessary dependencies are installed${RESET} \n" || exit 10

# To build neovide from source, uncomment the following lines:
# (curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh) && echo -e "\n${GREEN}Rust installed successfully${RESET} \n" || exit 11
#
# (cd && cargo install --git https://github.com/neovide/neovide)
# if [[ -d ~/.cargo/bin ]];then
#   echo -e "\n\n\n${GREEN}Neovide installed successfully${RESET} 😊"
# fi
