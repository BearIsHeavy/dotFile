#!/bin/bash
# main.sh - Unified entry point for dotfiles setup
# Supports: Ubuntu/Debian

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

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

print_banner() {
    echo -e "${BLUE}========================================${RESET}"
    echo -e "${BLUE}  Dotfiles Setup${RESET}"
    echo -e "${BLUE}  OS: ${GREEN}$DISTRO_NAME${RESET}"
    echo -e "${BLUE}========================================${RESET}"
}

show_menu() {
    echo -e "\n${YELLOW}Please select an option:${RESET}"
    echo "  1) Full setup (recommended)"
    echo "  2) Install packages only"
    echo "  3) Create symlinks only"
    echo "  4) Setup individual modules"
    echo "  5) Exit"
    echo ""
}

create_link() {
    makeLink() {
        fileName="$(basename $1)"
        [ -f "$HOME/$fileName" ] || [ -L "$HOME/$fileName" ] \
          && { rm "$HOME/$fileName"; } || echo -e "not exists $fileName \n"
        ln -s "$SCRIPT_DIR/$1" ~/
    }

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
        ln -s "$SCRIPT_DIR/bin" ~/
        cp "$HOME"/bin_back/* "$HOME"/bin
        rm -r "$HOME"/bin_back
    else
        ln -s "$SCRIPT_DIR/bin" ~/
    fi
    
    echo -e "${GREEN}Symlinks created successfully!${RESET}"
}

install_packages() {
    if [[ "$DISTRO" == "ubuntu" ]]; then
        bash "$SCRIPT_DIR/scripts/requirements/ubuntu.sh"
    else
        echo -e "${RED}Unsupported distribution: $DISTRO${RESET}"
        return 1
    fi
}

setup_module() {
    echo -e "\n${YELLOW}Select module to setup:${RESET}"
    echo "  1) VPN"
    echo "  2) Zsh"
    echo "  3) Vim"
    echo "  4) Neovim"
    echo "  5) Tools"
    echo "  6) Fonts"
    echo "  7) Conda"
    echo "  8) Colors"
    echo "  9) Neovide"
    echo "  10) Build DVWA"
    echo "  0) Back to main menu"
    echo ""
    read -p "Choice: " choice
    
    case $choice in
        1) bash "$SCRIPT_DIR/scripts/init/vpn.sh" ;;
        2) bash "$SCRIPT_DIR/scripts/init/zsh.sh" ;;
        3) bash "$SCRIPT_DIR/scripts/init/vim.sh" ;;
        4) bash "$SCRIPT_DIR/scripts/init/nvim.sh" ;;
        5) bash "$SCRIPT_DIR/scripts/init/tools.sh" ;;
        6) bash "$SCRIPT_DIR/scripts/init/fonts.sh" ;;
        7) bash "$SCRIPT_DIR/scripts/init/conda.sh" ;;
        8) bash "$SCRIPT_DIR/scripts/init/colors.sh" ;;
        9) bash "$SCRIPT_DIR/scripts/init/neovide.sh" ;;
        10) bash "$SCRIPT_DIR/scripts/init/build_dvwa.sh" ;;
        0) return ;;
        *) echo -e "${RED}Invalid choice${RESET}" ;;
    esac
}

full_setup() {
    echo -e "\n${YELLOW}Starting full setup...${RESET}"
    
    # Install packages
    echo -e "\n${BLUE}Step 1: Installing packages...${RESET}"
    install_packages
    
    # Create symlinks
    echo -e "\n${BLUE}Step 2: Creating symlinks...${RESET}"
    create_link
    
    # Setup modules
    echo -e "\n${BLUE}Step 3: Setup modules...${RESET}"
    for module in vpn zsh vim nvim tools fonts; do
        echo -e "\n${YELLOW}Setting up $module...${RESET}"
        bash "$SCRIPT_DIR/scripts/init/${module}.sh" || echo -e "${RED}Failed: $module${RESET}"
    done
    
    echo -e "\n${GREEN}========================================${RESET}"
    echo -e "${GREEN}  Full Setup Complete!${RESET}"
    echo -e "${GREEN}========================================${RESET}"
    echo -e "${BLUE}Please restart your terminal or run: ${RESET}source ~/.zshrc"
}

# Main loop
print_banner

while true; do
    show_menu
    read -p "Enter your choice: " choice
    
    case $choice in
        1) full_setup ;;
        2) install_packages ;;
        3) create_link ;;
        4) setup_module ;;
        5) echo -e "${GREEN}Goodbye!${RESET}"; exit 0 ;;
        *) echo -e "${RED}Invalid choice${RESET}" ;;
    esac
done
