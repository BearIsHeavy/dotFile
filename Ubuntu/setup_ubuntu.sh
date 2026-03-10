#!/bin/bash
# Ubuntu Setup Script - Entry point for Ubuntu dotfiles installation

set -e

# Get the directory where this script is located (Ubuntu/)
UBUNTU_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Root directory is the parent of Ubuntu/
ROOT_DIR="$(dirname "$UBUNTU_DIR")"

cd "$ROOT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Ubuntu Dotfiles Setup Script${RESET}"
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
    bash "$UBUNTU_DIR/requirements_ubuntu.sh"
fi

# Step 2: Create symlinks
echo -e "\n${YELLOW}Step 2: Creating symlinks...${RESET}"
read -p "Create symlinks for config files? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    bash "$ROOT_DIR/main.sh"
fi

# Step 3: VPN setup (recommended first)
echo -e "\n${YELLOW}Step 3: VPN Configuration${RESET}"
read -p "Setup VPN config? (Recommended before nvim install) (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/vpn.sh" || { echo -e "${RED}VPN setup failed (exit code: $?)${RESET}"; }
fi

# Step 4: Zsh setup
echo -e "\n${YELLOW}Step 4: Zsh Configuration${RESET}"
read -p "Install Zsh config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/zsh.sh" || { echo -e "${RED}Zsh setup failed (exit code: $?)${RESET}"; }
fi

# Step 5: Vim setup
echo -e "\n${YELLOW}Step 5: Vim Configuration${RESET}"
read -p "Install Vim config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/vim.sh" || { echo -e "${RED}Vim setup failed (exit code: $?)${RESET}"; }
fi

# Step 6: Neovim setup
echo -e "\n${YELLOW}Step 6: Neovim Configuration${RESET}"
read -p "Install Neovim config? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/nvim.sh" || { echo -e "${RED}Neovim setup failed (exit code: $?)${RESET}"; }
fi

# Step 7: Other commands
echo -e "\n${YELLOW}Step 7: Additional Tools${RESET}"
read -p "Install additional tools for daily work? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/otherCommand.sh" || { echo -e "${RED}Additional tools setup failed (exit code: $?)${RESET}"; }
fi

# Step 8: Terminal fonts
echo -e "\n${YELLOW}Step 8: Terminal Fonts${RESET}"
read -p "Install terminal fonts for icons? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    bash "$ROOT_DIR/initial/terminal_fonts.sh" || { echo -e "${RED}Font setup failed (exit code: $?)${RESET}"; }
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Ubuntu Setup Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Please restart your terminal or run: ${RESET}source ~/.zshrc"
