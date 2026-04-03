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

# Install tldr (tealdeer is the recommended Rust-based replacement)
tldr_installer() {
    # On Ubuntu 24.04, the apt tldr package is broken.
    # Install tealdeer (tldr in Rust) instead if cargo is available,
    # otherwise skip.
    if command -v cargo > /dev/null 2>&1; then
        cargo install tealdeer && \
        echo -e "\n${GREEN}tealdeer (tldr) installed via cargo${RESET}\n" || \
        { echo -e "\n${YELLOW}tealdeer install failed, skipping${RESET}\n"; return 0; }
    else
        echo -e "\n${YELLOW}cargo not found, skipping tldr/tealdeer install${RESET}"
        echo -e "${YELLOW}Install manually: cargo install tealdeer${RESET}\n"
        return 0
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
