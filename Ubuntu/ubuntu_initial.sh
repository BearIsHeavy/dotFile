#!/bin/bash
# Ubuntu Post-Installation Configuration Script
# Run this after the base Ubuntu installation to configure the desktop environment

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
echo -e "${BLUE}  Ubuntu Post-Install Configuration${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Step 1: Install restricted extras (codecs, drivers, etc.)
echo -e "\n${YELLOW}Step 1: Install Restricted Extras${RESET}"
read -p "Install ubuntu-restricted-extras (codecs, fonts, etc.)? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    sudo apt install -y ubuntu-restricted-extras
    echo -e "${GREEN}Restricted extras installed!${RESET}"
fi

# Step 2: Install desktop environment alternatives (optional)
echo -e "\n${YELLOW}Step 2: Desktop Environment (Optional)${RESET}"
echo "Select additional desktop environment to install:"
echo "1) KDE Plasma"
echo "2) XFCE"
echo "3) MATE"
echo "4) Skip (use default)"
read -p "Choice [1-4]: " choice

case $choice in
    1)
        echo "Installing KDE Plasma..."
        sudo apt install -y kde-plasma-desktop
        ;;
    2)
        echo "Installing XFCE..."
        sudo apt install -y xubuntu-desktop
        ;;
    3)
        echo "Installing MATE..."
        sudo apt install -y ubuntu-mate-desktop
        ;;
    4)
        echo "Skipping desktop environment..."
        ;;
    *)
        echo "Invalid choice, skipping..."
        ;;
esac

# Step 3: Install audio tools
echo -e "\n${YELLOW}Step 3: Audio Tools${RESET}"
read -p "Install PulseAudio volume control? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo apt install -y pavucontrol
    echo -e "${GREEN}Audio tools installed!${RESET}"
fi

# Step 4: Install Bluetooth support
echo -e "\n${YELLOW}Step 4: Bluetooth Support${RESET}"
read -p "Install Bluetooth tools? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo apt install -y blueman
    echo -e "${GREEN}Bluetooth tools installed!${RESET}"
fi

# Step 5: Install printing support
echo -e "\n${YELLOW}Step 5: Printing Support${RESET}"
read -p "Install printing support? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo apt install -y cups cups-pdf system-config-printer
    echo -e "${GREEN}Printing support installed!${RESET}"
fi

# Step 6: Install common applications
echo -e "\n${YELLOW}Step 6: Common Applications${RESET}"
read -p "Install common applications (VLC, GIMP, etc.)? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo apt install -y vlc gimp file-roller p7zip-full
    echo -e "${GREEN}Applications installed!${RESET}"
fi

# Step 7: Enable firewall
echo -e "\n${YELLOW}Step 7: Firewall Configuration${RESET}"
if ! sudo ufw status &> /dev/null; then
    sudo apt install -y ufw
fi
read -p "Enable UFW firewall? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo ufw enable
    echo -e "${GREEN}Firewall enabled!${RESET}"
fi

# Step 8: Install Snap/Flatpak support
echo -e "\n${YELLOW}Step 8: Additional Package Support${RESET}"
read -p "Install Flatpak support? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo apt install -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo -e "${GREEN}Flatpak installed and configured!${RESET}"
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Ubuntu Configuration Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Please reboot your system to apply changes.${RESET}"
