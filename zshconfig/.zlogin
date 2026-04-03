# This script file used to config third party script
# and used to add third party PATH

ZLOGIN_SOURCED=True
# bind '^A' to move cursor to begin of correct line
bindkey '^A' beginning-of-line

# source command-not-found handler if available (Ubuntu 24.04 uses /etc/zsh_command_not_found)
if [[ -f /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi

# this snipper be used to auto-suggesion when you type commands
if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
