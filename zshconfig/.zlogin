# This script file used to config third party script
# and used to add third party PATH

ZLOGIN_SOURCED=TRUE
# bind '^A' to move cursor to begin of correct line
bindkey '^A' beginning-of-line

# source zsh plugins to enhance expericence
. "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" && \
fpath+=($HOME/.zsh/zsh-completions/src) && \
. "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" || echo "fail when running .zlogin file" 1>&2

if [[ -d "$HOME/.npm-gloabl/bin" ]];then 
    export PATH="$HOME/.npm-global/bin:$PATH"
fi
