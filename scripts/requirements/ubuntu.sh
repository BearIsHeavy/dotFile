#!/bin/bash
# Ubuntu/Debian package requirements

set -e

echo "Updating package lists..."
sudo apt update

echo "Upgrading existing packages..."
sudo apt upgrade -y

echo "Installing essential packages..."
sudo apt install -y \
    git \
    curl \
    wget \
    vim \
    neovim \
    tmux \
    zsh \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    python3 \
    python3-pip \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    fzf \
    jq \
    htop \
    tree \
    tldr \
    eza \
    bat \
    httpie \
    net-tools \
    openssh-client \
    openssh-server \
    gnupg \
    software-properties-common \
    apt-transport-https \
    ca-certificates

echo "Ubuntu packages installation completed!"
