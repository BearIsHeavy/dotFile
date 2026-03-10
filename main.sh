#!/bin/bash
# main.sh - Cross-distribution dotfiles linker
# Supports: Ubuntu/Debian and Arch Linux

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Detect distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian|linuxmint)
                DISTRO="ubuntu"
                DISTRO_NAME="$PRETTY_NAME"
                ;;
            arch|manjaro|endeavouros)
                DISTRO="arch"
                DISTRO_NAME="$PRETTY_NAME"
                ;;
            *)
                DISTRO="unknown"
                DISTRO_NAME="$PRETTY_NAME"
                ;;
        esac
    else
        DISTRO="unknown"
        DISTRO_NAME="Unknown"
    fi
}

detect_distro

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Dotfiles Linker${RESET}"
echo -e "${BLUE}  Detected OS: ${GREEN}$DISTRO_NAME${RESET}"
echo -e "${BLUE}========================================${RESET}"

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
        ln -s "$HOME/.dotfile/bin" ~/
        cp "$HOME"/bin_back/* "$HOME"/bin
        rm -r "$HOME"/bin_back
    else
        ln -s "$HOME/.dotfile/bin" ~/
    fi
}

# The following code is used to interact with the user
echo -e "\n${YELLOW}Whether to create symlinks for the following files:${RESET}"
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
    echo -e "${GREEN}Symlinks created successfully!${RESET}"
elif [[ $n =~ ^[N|n] ]];then
    echo -e "No Link be created\n"
fi

echo -e "\n${BLUE}Note: For full setup, please use the distro-specific setup script:${RESET}"
echo -e "  Ubuntu: ${GREEN}bash setup_ubuntu.sh${RESET}"
echo -e "  Arch:   ${GREEN}bash setup_arch.sh${RESET}"

