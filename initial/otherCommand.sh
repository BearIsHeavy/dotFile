#!/bin/env bash

. $HOME/.dotfile/initial/colors.sh # import colors

# install tmux command
tmux_installer() {
    sudo apt install tmux -y || exit 2 && echo -e -r "${GREEN}\ntmux download successfully ${RESET}\n"
}

# install tldr command
tldr_installer() {
    sudo apt install tldr || echo -e -n "${RED}\ntldr install faile${RESET}\n" && echo -e -n "${GREEN}\ntldr success ${RESET} \n"
    if tldr -u > /dev/null;then
      echo -e -n "${RED}\ntldr --update fail${RESET}" 1>&2
    fi
}


# install shellcheck
shellcheck_installer() {
    if ! sudo apt install shellcheck;then
      echo -e -n "${RED}\n shellcheck faile\n${RESET}" 1>&2
      echo -e "\n"
    else
      echo -e -n "\n${GREEN}shellcheck install successfully${RESET}\n"
    fi
}


# install exa comamnd
exa_installer() {
  version_ubuntu="$(lsb_release -a 2>/dev/null | grep -Ei 'description' | awk '{print $3}' | awk -F '.' '{print $1}')"
  if [[ $version_ubuntu -ge 22 ]]; then
    sudo apt install exa || exit 1
  else
    ( mkdir -p "$HOME"/Download \
      && cd "$HOME"/Download/ \
      && wget --timeout=5 --tries=1 https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip \
      && wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip \
      && sudo apt install unzip  \
      && unzip exa-linux-x86_64-0.9.0.zip \
      && mv exa-linux-x86_64 ~/bin \
      && rm -r "$HOME"/Download/exa-linux-x86_64 ) || echo -e -n "${RED}exa command install fail${RESET}\n"; exit 3
    echo -e -n "${GREEN}exa command install successfully${RESET}\n"
  fi
}

# install batcat command
batcat_installer(){
    if ! type batcat > /dev/null;then
        sudo apt install bat && \
        mkdir -p $HOME/bin   && \
        ln -s /bin/batcat $HOME/bin && \
        echo -e -n "\n${RED}Completed batcat command install${RESET}\n"
}

config_terminal_font() {
    bash $HOME/.dotfile/initial/terminal_fonts.sh && \
    echo -en "\n${RED}Completed terminal fonts installation${RESET}"
}

tmux_installer || exit 101
tldr_installer || exit 102
shellcheck_installer || exit 103
exa_installer || exit 104
config_terminal_font || exit 105
