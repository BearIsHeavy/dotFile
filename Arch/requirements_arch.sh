#!/bin/bash
# Arch Linux package requirements

set -e

echo "Updating package database..."
sudo pacman -Sy

echo "Upgrading existing packages..."
sudo pacman -Su --noconfirm

echo "Installing essential packages..."
sudo pacman -S --noconfirm \
    git \
    curl \
    wget \
    vim \
    neovim \
    tmux \
    zsh \
    base-devel \
    gcc \
    make \
    cmake \
    python \
    python-pip \
    nodejs \
    npm \
    ripgrep \
    fd \
    fzf \
    jq \
    htop \
    tree \
    exa \
    bat \
    httpie \
    net-tools \
    openssh \
    gnupg \
    zsh-completions \
    zsh-autosuggestions \
    zsh-syntax-highlighting

echo "Checking for AUR helper (yay/paru)..."
if command -v yay &> /dev/null; then
    echo "yay is already installed"
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    echo "paru is already installed"
    AUR_HELPER="paru"
else
    echo "Installing yay as AUR helper..."
    sudo pacman -S --noconfirm --needed git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    AUR_HELPER="yay"
    echo "yay installed successfully!"
fi

echo "Installing additional packages from AUR..."
$AUR_HELPER -S --noconfirm \
    tldr-py \
    eza

echo "Arch Linux packages installation completed!"
