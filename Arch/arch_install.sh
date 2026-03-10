#!/bin/bash
# Arch Linux Initial Installation Script
# Run this script right after installing Arch Linux

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Arch Linux Initial Setup${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Step 1: Update system
echo -e "\n${YELLOW}Step 1: Updating system...${RESET}"
sudo pacman -Syu --noconfirm

# Step 2: Set up mirrors (optional, using reflector for best mirrors)
echo -e "\n${YELLOW}Step 2: Setting up optimal mirrors...${RESET}"
read -p "Install and configure reflector for optimal mirrors? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    sudo pacman -S --noconfirm reflector
    sudo reflector --country 'China' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    echo -e "${GREEN}Mirrors updated!${RESET}"
fi

# Step 3: Install essential development tools
echo -e "\n${YELLOW}Step 3: Installing essential development tools...${RESET}"
sudo pacman -S --noconfirm \
    base-devel \
    git \
    vim \
    neovim \
    tmux \
    zsh \
    curl \
    wget

# Step 4: Install AUR helper
echo -e "\n${YELLOW}Step 4: Setting up AUR helper...${RESET}"
if command -v yay &> /dev/null; then
    echo -e "${GREEN}yay is already installed${RESET}"
elif command -v paru &> /dev/null; then
    echo -e "${GREEN}paru is already installed${RESET}"
else
    read -p "Install yay as AUR helper? (Y/n): " ans
    if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
        echo -e "${GREEN}yay installed successfully!${RESET}"
    fi
fi

# Step 5: Configure sudo
echo -e "\n${YELLOW}Step 5: Configuring sudo...${RESET}"
if ! grep -q "wheel ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo -e "${BLUE}Enabling wheel group for sudo...${RESET}"
    sudo sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^#//' /etc/sudoers 2>/dev/null || \
    echo "%wheel ALL=(ALL:ALL) ALL" | sudo tee -a /etc/sudoers
fi

# Step 6: Set up multilib (for gaming and some proprietary software)
echo -e "\n${YELLOW}Step 6: Setting up multilib repository...${RESET}"
read -p "Enable multilib repository? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    if ! grep -q "\[multilib\]" /etc/pacman.conf; then
        echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
        sudo pacman -Sy
        echo -e "${GREEN}Multilib enabled!${RESET}"
    else
        echo -e "${GREEN}Multilib is already enabled${RESET}"
    fi
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Arch Linux Initial Setup Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Next step: Run ${GREEN}bash ~/path/to/.dotfile/setup_arch.sh${BLUE} to configure dotfiles${RESET}"
