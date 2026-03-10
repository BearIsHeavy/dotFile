#!/bin/env bash

source ~/.dotfile/initial/colors.sh

( sudo apt install -y curl \
    gnupg ca-certificates git \
    gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
    libxcursor-dev
) && echo -en "\n\n${RED}All necessary depenedcies is installed${RESET} \n" || exit 10

# (curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh) && echo "\n${READ}Rush installed successfully${RESET} \n" || exit 11
#
# (cd && cargo install --git https://github.com/neovide/neovide)
# if [[ -d ~/.cargo/bin ]];then
#   echo -en "\n\n\n${READ}neovide installed successfully${RESET}😊"
# fi
