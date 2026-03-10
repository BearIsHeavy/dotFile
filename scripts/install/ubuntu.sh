#!/bin/bash
# Ubuntu Initial Installation Script
# Run this script right after installing Ubuntu

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
echo -e "${BLUE}  Ubuntu Initial Setup${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Detect Ubuntu version
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    UBUNTU_VERSION="$VERSION_ID"
    CODENAME="$VERSION_CODENAME"
    echo -e "${BLUE}Detected: ${GREEN}$PRETTY_NAME${RESET}"
fi

# Step 1: Update system
echo -e "\n${YELLOW}Step 1: Updating system...${RESET}"
sudo apt update
sudo apt upgrade -y

# Step 2: Set up domestic mirrors (optional, for China users)
echo -e "\n${YELLOW}Step 2: Configure apt mirrors (Optional)${RESET}"
read -p "Use Chinese mirrors (Aliyun/Tsinghua)? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    apt_sources="/etc/apt/sources.list.d/ubuntu.sources"
    if [[ -e $apt_sources ]]; then
        sudo cp "$apt_sources" "/etc/apt/sources.list.d/ubuntu.sources.bak"
        echo -e "${BLUE}Backed up original sources list${RESET}"
    fi
    
    echo -e "${BLUE}Setting up Aliyun mirrors...${RESET}"
    sudo tee "$apt_sources" > /dev/null << EOF
# Aliyun Mirror
Types: deb
URIs: http://mirrors.aliyun.com/ubuntu/
Suites: $CODENAME $CODENAME-updates $CODENAME-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
    sudo apt update
    echo -e "${GREEN}Mirrors configured!${RESET}"
fi

# Step 3: Install essential packages
echo -e "\n${YELLOW}Step 3: Installing essential packages...${RESET}"
sudo apt install -y \
    git \
    curl \
    wget \
    vim \
    tmux \
    zsh \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg

# Step 4: Set up root account (optional)
echo -e "\n${YELLOW}Step 4: Root Account Configuration${RESET}"
read -p "Set root password? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo passwd root
fi

# Step 5: Configure firewall (UFW)
echo -e "\n${YELLOW}Step 5: Firewall Configuration${RESET}"
if ! command -v ufw &> /dev/null; then
    sudo apt install -y ufw
fi
read -p "Enable UFW firewall? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo ufw enable
    echo -e "${GREEN}Firewall enabled!${RESET}"
fi

# Step 6: Install NVIDIA drivers (optional)
echo -e "\n${YELLOW}Step 6: GPU Driver Setup${RESET}"
if lspci | grep -i 'nvidia' &> /dev/null; then
    echo -e "${BLUE}NVIDIA GPU detected${RESET}"
    read -p "Install NVIDIA drivers? (y/N): " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        sudo ubuntu-drivers autoinstall
        echo -e "${GREEN}NVIDIA drivers installed! Please reboot.${RESET}"
    fi
else
    echo -e "${BLUE}No NVIDIA GPU detected${RESET}"
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Ubuntu Initial Setup Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Next step: Run ${GREEN}bash ~/path/to/.dotfile/setup_ubuntu.sh${BLUE} to configure dotfiles${RESET}"
