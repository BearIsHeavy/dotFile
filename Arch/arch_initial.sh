#!/bin/bash
# Arch Linux Post-Installation Configuration Script
# Run this after the base Arch installation to configure the desktop environment

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
echo -e "${BLUE}  Arch Linux Post-Install Configuration${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Step 1: Install desktop environment (optional)
echo -e "\n${YELLOW}Step 1: Desktop Environment${RESET}"
echo "Select desktop environment to install:"
echo "1) KDE Plasma"
echo "2) GNOME"
echo "3) XFCE"
echo "4) Skip (WM only)"
read -p "Choice [1-4]: " choice

case $choice in
    1)
        echo "Installing KDE Plasma..."
        sudo pacman -S --noconfirm plasma plasma-desktop sddm konsole dolphin
        sudo systemctl enable sddm
        ;;
    2)
        echo "Installing GNOME..."
        sudo pacman -S --noconfirm gnome gnome-extra gdm
        sudo systemctl enable gdm
        ;;
    3)
        echo "Installing XFCE..."
        sudo pacman -S --noconfirm xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
        sudo systemctl enable lightdm
        ;;
    4)
        echo "Skipping desktop environment..."
        ;;
    *)
        echo "Invalid choice, skipping..."
        ;;
esac

# Step 2: Install audio support
echo -e "\n${YELLOW}Step 2: Audio Support${RESET}"
read -p "Install PipeWire audio? (Y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
    sudo pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa wireplumber
    systemctl --user enable pipewire-pulse
    echo -e "${GREEN}PipeWire installed!${RESET}"
fi

# Step 3: Install network management
echo -e "\n${YELLOW}Step 3: Network Management${RESET}"
if ! command -v nmcli &> /dev/null; then
    read -p "Install NetworkManager? (Y/n): " ans
    if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
        sudo pacman -S --noconfirm networkmanager network-manager-applet
        sudo systemctl enable NetworkManager
        echo -e "${GREEN}NetworkManager installed and enabled!${RESET}"
    fi
fi

# Step 4: Install Bluetooth support
echo -e "\n${YELLOW}Step 4: Bluetooth Support${RESET}"
read -p "Install Bluetooth support? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm bluez bluez-utils blueman
    sudo systemctl enable bluetooth
    echo -e "${GREEN}Bluetooth support installed!${RESET}"
fi

# Step 5: Install printing support
echo -e "\n${YELLOW}Step 5: Printing Support${RESET}"
read -p "Install CUPS printing support? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm cups cups-pdf nss-mdns
    sudo systemctl enable cups
    echo -e "${GREEN}CUPS installed!${RESET}"
fi

# Step 6: Install common applications
echo -e "\n${YELLOW}Step 6: Common Applications${RESET}"
read -p "Install common applications (firefox, thunderbird, etc.)? (y/N): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm firefox thunderbird file-roller ark
    echo -e "${GREEN}Applications installed!${RESET}"
fi

# Step 7: Enable TRIM for SSD (if applicable)
echo -e "\n${YELLOW}Step 7: SSD Optimization${RESET}"
if lsblk -d -o name,rota | grep -q '1$'; then
    echo "HDD detected, skipping TRIM..."
else
    read -p "Enable periodic TRIM for SSD? (Y/n): " ans
    if [[ "$ans" =~ ^[Yy]$ ]] || [[ -z "$ans" ]]; then
        sudo systemctl enable fstrim.timer
        echo -e "${GREEN}TRIM enabled!${RESET}"
    fi
fi

echo -e "\n${GREEN}========================================${RESET}"
echo -e "${GREEN}  Arch Linux Configuration Complete!${RESET}"
echo -e "${GREEN}========================================${RESET}"
echo -e "${BLUE}Please reboot your system to apply changes.${RESET}"
