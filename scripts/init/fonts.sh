#!/bin/bash

source "$HOME/.dotfile/scripts/init/colors.sh"

# Ensure unzip is available (required for Nerd Fonts)
if ! command -v unzip &> /dev/null; then
    echo -e "${YELLOW}unzip not found, installing...${RESET}"
    sudo apt install -y unzip || { echo -e "${RED}Failed to install unzip${RESET}" 1>&2; exit 1; }
fi

declare -a fonts=(
    0xProto
)

version='3.3.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo_download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${RED}v${version}${RESET}/${RED}${zip_file}${RESET}"
    echo -e -n "Downloading $echo_download_url \n"
    read -p "please make sure this url is correct(y/n): " ans
    if [[ $ans =~ ^[Y|y] ]];then
      wget "$download_url" || echo -en "\n${RED}please update version in curl${RESET}\n"
      unzip "$zip_file" -d "$fonts_dir" && rm "$zip_file"
    fi
done

fc-cache -fv
