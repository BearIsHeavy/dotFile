#!/bin/env bash

source "$HOME/.dotfile/scripts/init/colors.sh"

# --- Install Docker CE ---

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Installing Docker CE${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Step 1: Remove conflicting packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y "$pkg" 2>/dev/null
done

# Step 2: Set up Docker's apt repository
echo -e "\n${YELLOW}Setting up Docker apt repository...${RESET}"
sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Step 3: Install Docker packages
echo -e "\n${YELLOW}Installing Docker CE...${RESET}"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

# Step 4: Start and enable Docker
echo -e "\n${YELLOW}Starting Docker service...${RESET}"
sudo systemctl enable --now docker

# Step 5: Add user to docker group (no sudo needed)
echo -e "\n${YELLOW}Adding $(whoami) to docker group...${RESET}"
sudo usermod -aG docker "$(whoami)"

# Verify installation
if docker --version > /dev/null 2>&1; then
    echo -e "\n${GREEN}========================================${RESET}"
    echo -e "${GREEN}  Docker installed successfully!${RESET}"
    echo -e "${GREEN}  $(docker --version)${RESET}"
    echo -e "${GREEN}  Compose $(docker compose version)${RESET}"
    echo -e "${GREEN}========================================${RESET}"
    echo -e "${YELLOW}NOTE: You need to re-login for docker group to take effect${RESET}"
    echo -e "${YELLOW}      (or run: newgrp docker)${RESET}"
else
    echo -e "\n${RED}Docker installation failed${RESET}" 1>&2
    exit 1
fi
