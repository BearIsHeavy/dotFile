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

# zsh-syntax-highlighting: command color feedback
if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-history-substring-search: up/down arrow search history by input
if [[ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

# z: smart directory jumper (tracks frequently visited dirs)
# Usage: z <partial-name>  (e.g. `z proj` jumps to ~/projects/myproject)
if [[ -f ~/.zsh/z/z.sh ]]; then
    source ~/.zsh/z/z.sh
fi
