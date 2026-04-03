#!/bin/env bash

source "$HOME/.dotfile/scripts/init/colors.sh"

# Check if uv is already installed
if command -v uv &> /dev/null; then
    echo -e "${GREEN}uv is already installed: $(uv --version)${RESET}"
    exit 0
fi

echo -e "${BLUE}========================================${RESET}"
echo -e "${BLUE}  Installing uv (Python Package Manager)${RESET}"
echo -e "${BLUE}========================================${RESET}"

# Install uv using the official installer script
if curl -LsSf https://astral.sh/uv/install.sh | sh; then
    echo -e "\n${GREEN}uv installed successfully: $(uv --version)${RESET}"
    echo -e "${YELLOW}Please restart your terminal or run: ${RESET}source \"\$HOME/.local/bin/env\""
else
    echo -e "\n${RED}Failed to install uv. You can try manual install from:${RESET}"
    echo -e "${YELLOW}  https://docs.astral.sh/uv/getting-started/installation/${RESET}"
    exit 1
fi
