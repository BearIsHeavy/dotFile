#!/bin/bash
# Ubuntu Setup Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Ubuntu Dotfiles Setup${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Check if running on Ubuntu
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$ID" != "ubuntu" && "$ID_LIKE" != "ubuntu" && "$ID_LIKE" != "debian" ]]; then
        echo -e "${RED}Warning: This script is designed for Ubuntu/Debian.${RESET}"
        echo -e "${RED}Detected OS: $ID${RESET}"
        read -p "Continue anyway? (y/N): " confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
fi

# Step 1: Install system packages
echo -e "\n${YELLOW}Step 1: Installing system packages...${RESET}"
read -p "Install system packages? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    bash "$SCRIPT_DIR/../requirements/ubuntu.sh"
fi

# Step 2: Create symlinks
echo -e "\n${YELLOW}Step 2: Creating symlinks...${RESET}"
read -p "Create symlinks for config files? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    bash "$ROOT_DIR/main.sh"
fi

# Step 3: VPN setup
echo -e "\n${YELLOW}Step 3: VPN Configuration${RESET}"
read -p "Setup VPN config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/vpn.sh" || echo -e "${RED}VPN setup failed${RESET}"
fi

# Step 4: Zsh setup
echo -e "\n${YELLOW}Step 4: Zsh Configuration${RESET}"
read -p "Install Zsh config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/zsh.sh" || echo -e "${RED}Zsh setup failed${RESET}"
fi

# Step 5: Vim setup
echo -e "\n${YELLOW}Step 5: Vim Configuration${RESET}"
read -p "Install Vim config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/vim.sh" || echo -e "${RED}Vim setup failed${RESET}"
fi

# Step 6: Neovim setup
echo -e "\n${YELLOW}Step 6: Neovim Configuration${RESET}"
read -p "Install Neovim config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/nvim.sh" || echo -e "${RED}Neovim setup failed${RESET}"
fi

# Step 7: Other tools
echo -e "\n${YELLOW}Step 7: Additional Tools${RESET}"
read -p "Install additional tools? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/tools.sh" || echo -e "${RED}Tools setup failed${RESET}"
fi

# Step 8: Terminal fonts
echo -e "\n${YELLOW}Step 8: Terminal Fonts${RESET}"
read -p "Install terminal fonts? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$SCRIPT_DIR/../init/fonts.sh" || echo -e "${RED}Font setup failed${RESET}"
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Ubuntu Setup Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Please restart your terminal or run: ${RESET}source ~/.zshrc"
