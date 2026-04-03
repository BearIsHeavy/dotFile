#!/bin/env bash

. "$HOME/.dotfile/scripts/init/colors.sh"

# Install tmux
tmux_installer() {
    if sudo apt install tmux -y; then
      echo -e "\n${GREEN}tmux installed successfully${RESET}\n"
    else
      echo -e "\n${RED}tmux install failed${RESET}\n" 1>&2
      return 1
    fi
}

# Install tldr
tldr_installer() {
    if sudo apt install tldr -y; then
      echo -e "\n${GREEN}tldr installed successfully${RESET}\n"
    else
      echo -e "\n${RED}tldr install failed${RESET}\n" 1>&2
      return 1
    fi
    if tldr -u > /dev/null 2>&1; then
      echo -e "${GREEN}tldr cache updated${RESET}"
    else
      echo -e "${RED}tldr cache update failed${RESET}" 1>&2
    fi
}

# Install shellcheck
shellcheck_installer() {
    if sudo apt install shellcheck -y; then
      echo -e "\n${GREEN}shellcheck installed successfully${RESET}\n"
    else
      echo -e "\n${RED}shellcheck install failed${RESET}\n" 1>&2
      return 1
    fi
}

# Install eza (modern replacement for exa/ls)
eza_installer() {
  if command -v eza > /dev/null 2>&1; then
    echo -e "${GREEN}eza is already installed${RESET}"
    return 0
  fi
  if sudo apt install eza -y; then
    echo -e "${GREEN}eza installed successfully${RESET}\n"
  else
    echo -e "${RED}eza install failed${RESET}\n" 1>&2
    return 1
  fi
}

# Install batcat
batcat_installer() {
    if type batcat > /dev/null 2>&1; then
      echo -e "${GREEN}batcat is already installed${RESET}"
      return 0
    fi
    sudo apt install bat -y && \
    mkdir -p "$HOME/bin" && \
    ln -sf "$(command -v batcat)" "$HOME/bin/bat" && \
    echo -e "\n${GREEN}batcat command installed successfully${RESET}\n"
}

config_terminal_font() {
    bash "$HOME/.dotfile/scripts/init/fonts.sh" && \
    echo -e "\n${GREEN}Terminal fonts installation completed${RESET}"
}

tmux_installer || exit 101
tldr_installer || exit 102
shellcheck_installer || exit 103
eza_installer || exit 104
