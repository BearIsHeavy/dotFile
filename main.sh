#!/bin/bash
# main.sh - Unified entry point for dotfiles setup
# Supports: Ubuntu/Debian

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

# Create a single symlink for a config file
makeLink() {
    local target="$1"
    local fileName
    fileName="$(basename "$target")"

    if [[ -L "$HOME/$fileName" ]]; then
        # Existing symlink — remove it
        rm "$HOME/$fileName"
    elif [[ -f "$HOME/$fileName" ]]; then
        # Existing regular file — back it up
        echo -e "${YELLOW}Backing up existing $HOME/$fileName -> $HOME/$fileName.bak${RESET}"
        mv "$HOME/$fileName" "$HOME/$fileName.bak"
    fi

    ln -s "$SCRIPT_DIR/$target" "$HOME/$fileName"
    echo -e "${GREEN}Created symlink: $HOME/$fileName -> $SCRIPT_DIR/$target${RESET}"
}

create_link() {
    echo -e "\n${BLUE}Creating symlinks...${RESET}"

    makeLink ".zsh"
    makeLink "generalConfig/.profile"
    makeLink "generalConfig/.bashrc"
    makeLink "generalConfig/.vimrc"
    makeLink "generalConfig/.tmux.conf"
    makeLink "zshconfig/.zshrc"
    makeLink "zshconfig/.zshenv"
    makeLink "zshconfig/.zlogin"
    makeLink "zshconfig/.zprofile"

    # Handle bin/ directory symlink
    if [[ -d "$HOME/bin" && ! -L "$HOME/bin" ]]; then
        echo -e "${YELLOW}Backing up existing $HOME/bin -> $HOME/bin.bak${RESET}"
        mv "$HOME/bin" "$HOME/bin.bak"
    elif [[ -L "$HOME/bin" ]]; then
        rm "$HOME/bin"
    fi
    ln -s "$SCRIPT_DIR/bin" "$HOME/bin"

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
    echo "  8) Neovide"
    echo "  9) UV (Python package manager)"
    echo "  10) Docker"
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
        8) bash "$SCRIPT_DIR/scripts/init/neovide.sh" ;;
        9) bash "$SCRIPT_DIR/scripts/init/uv.sh" ;;
        10) bash "$SCRIPT_DIR/scripts/init/docker.sh" ;;
        0) return ;;
        *) echo -e "${RED}Invalid choice${RESET}" ;;
    esac
}

full_setup() {
    echo -e "\n${YELLOW}Starting full setup...${RESET}"

    # Install packages
    echo -e "\n${BLUE}Step 1: Installing packages...${RESET}"
    install_packages || { echo -e "${RED}Package installation failed${RESET}"; return 1; }

    # Create symlinks
    echo -e "\n${BLUE}Step 2: Creating symlinks...${RESET}"
    create_link

    # Setup modules
    echo -e "\n${BLUE}Step 3: Setup modules...${RESET}"
    for module in zsh vim nvim tools fonts; do
        echo -e "\n${YELLOW}Setting up $module...${RESET}"
        bash "$SCRIPT_DIR/scripts/init/${module}.sh" || echo -e "${RED}Failed: $module (continuing)${RESET}"
    done

    # VPN — optional, prompt user
    echo -e "\n${YELLOW}VPN/Clash is optional. Install now? (y/N): ${RESET}"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        bash "$SCRIPT_DIR/scripts/init/vpn.sh" || echo -e "${RED}Failed: vpn (continuing)${RESET}"
    fi

    # Conda — optional, prompt user
    echo -e "\n${YELLOW}Conda (Anaconda) — install now? (y/N): ${RESET}"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        bash "$SCRIPT_DIR/scripts/init/conda.sh" || echo -e "${RED}Failed: conda (continuing)${RESET}"
    fi

    # Docker — optional, prompt user
    echo -e "\n${YELLOW}Docker CE — install now? (y/N): ${RESET}"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        bash "$SCRIPT_DIR/scripts/init/docker.sh" || echo -e "${RED}Failed: docker (continuing)${RESET}"
    fi

    # UV — optional, prompt user
    echo -e "\n${YELLOW}UV (Python package manager) — install now? (y/N): ${RESET}"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        bash "$SCRIPT_DIR/scripts/init/uv.sh" || echo -e "${RED}Failed: uv (continuing)${RESET}"
    fi

    echo -e "\n${GREEN}========================================${RESET}"
    echo -e "${GREEN}  Full Setup Complete!${RESET}"
    echo -e "${GREEN}========================================${RESET}"
    echo -e "${BLUE}Please restart your terminal or run: ${RESET}source ~/.zshrc"
}

# Configure proxy (optional)
configure_proxy() {
    echo -e "\n${YELLOW}Do you need to configure a network proxy? (y/N):${RESET}"
    read -r ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        read -r -p "Enter proxy address (e.g. 127.0.0.1:7890): " proxy_addr
        if [[ -n "$proxy_addr" ]]; then
            export http_proxy="http://$proxy_addr"
            export https_proxy="http://$proxy_addr"
            export all_proxy="socks5://$proxy_addr"
            export HTTP_PROXY="$http_proxy"
            export HTTPS_PROXY="$https_proxy"
            export ALL_PROXY="$all_proxy"
            echo -e "${GREEN}Proxy configured: ${YELLOW}$proxy_addr${RESET}"
            echo -e "${GREEN}  http_proxy  = $http_proxy${RESET}"
            echo -e "${GREEN}  https_proxy = $https_proxy${RESET}"
            echo -e "${GREEN}  all_proxy   = $all_proxy${RESET}"
        else
            echo -e "${YELLOW}No proxy address provided, skipping.${RESET}"
        fi
    fi
}

# Main loop
print_banner
configure_proxy

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
    echo ""
done
