#!/bin/env bash

# $? 0 is OK
# $? 2 is not connected to github
# $? 3 is zsh not installed

. "$HOME/.dotfile/scripts/init/colors.sh"

install_autosuggestion() {
    echo -e "${BLUE}Installing zsh-autosuggestions...${RESET}"

    # Priority 1: Clone from GitHub
    if git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$HOME/.zsh/zsh-autosuggestions" 2>/dev/null; then
        echo -e "${GREEN}Cloned from GitHub successfully${RESET}"
        return 0
    fi

    echo -e "${YELLOW}Failed to clone from GitHub${RESET}"
    echo -e "${RED}No zsh-autosuggestions available (configure proxy and retry)${RESET}" 1>&2
    return 1
}

# Download install zsh
if ! which zsh 1>/dev/null; then
	echo -e -n "${GREEN}Prepare to running: sudo apt update && sudo apt install zsh${RESET} \n"

	if sudo apt update && sudo apt install zsh; then
		echo -e "Install zsh Successfully \n"
	else
		echo -e "Download Fail please manuial install zsh \n" 1>&2 && exit 2
	fi
fi

# Offer to set zsh as default shell
if which zsh &> /dev/null && [[ "$SHELL" != *"zsh"* ]]; then
    echo -e "${YELLOW}zsh is installed but not set as your default shell.${RESET}"
    read -r -p "Set zsh as default shell? (y/N): " chsh_ans
    if [[ "$chsh_ans" =~ ^[Yy]$ ]]; then
        chsh -s "$(which zsh)" && echo -e "${GREEN}Default shell changed to zsh. Please re-login to apply.${RESET}" \
            || echo -e "${RED}Failed to change default shell${RESET}" 1>&2
    fi
fi

# Download zsh-autosuggestions
if [[ ! -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    install_autosuggestion
fi

# Download zsh-syntax-highlighting
if [[ ! -f $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    echo -e "${BLUE}Installing zsh-syntax-highlighting...${RESET}"
    if git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$HOME/.zsh/zsh-syntax-highlighting" 2>/dev/null; then
        echo -e "${GREEN}Cloned from GitHub successfully${RESET}"
    else
        echo -e "${YELLOW}Failed to clone zsh-syntax-highlighting (check proxy)${RESET}" 1>&2
    fi
fi

# Download zsh-history-substring-search
if [[ ! -f $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    echo -e "${BLUE}Installing zsh-history-substring-search...${RESET}"
    if git clone https://github.com/zsh-users/zsh-history-substring-search \
        "$HOME/.zsh/zsh-history-substring-search" 2>/dev/null; then
        echo -e "${GREEN}Cloned from GitHub successfully${RESET}"
    else
        echo -e "${YELLOW}Failed to clone zsh-history-substring-search (check proxy)${RESET}" 1>&2
    fi
fi

# Download z (smart directory jumper)
if [[ ! -f $HOME/.zsh/z/z.sh ]]; then
    echo -e "${BLUE}Installing z (smart directory jumper)...${RESET}"
    if git clone https://github.com/rupa/z \
        "$HOME/.zsh/z" 2>/dev/null; then
        echo -e "${GREEN}Cloned from GitHub successfully${RESET}"
    else
        echo -e "${YELLOW}Failed to clone z (check proxy)${RESET}" 1>&2
    fi
fi

# Download command-not-found (optional on Ubuntu 24.04)
if ! dpkg -l command-not-found > /dev/null 2>&1; then
    sudo apt install -y command-not-found || \
    echo -e "${YELLOW}command-not-found not available (optional)${RESET}"
fi
