#__________   __    __                        __    
#\______   \_/  |__/  |_____________    ____ |  | __
# |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
# |    |   \ |  |  |  |  |  | \// __ \\  \___|    < 
# |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
#        \/                         \/     \/     \/
#                                       author:bear

# Basic Options
setopt interactivecomments  # allow comments in interactive mode
setopt magicequalsubst      # enable filename expansion for arguments like 'foo=~/bar'
setopt notify               # report status of background jobs immediately
setopt promptsubst          # enable command substitution in prompt
setopt share_history        # share history between sessions
setopt inc_append_history   # add history immediately
# setopt correct            # Optional: auto correct mistakes (can be annoying)

# Variable Setup
ZSHRC_SOURCED=True
VIRTUAL_ENV=''
HISTSIZE=10000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history

# --- MacOS Specific: Key Bindings ---
# macOS terminals often don't populate the ${key} array by default.
# We explicitly bind the codes for Up/Down arrows to history search.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Standard codes for macOS (Terminal.app / iTerm2)
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
# Fallback for some other terminals
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# --- Function to check command exit status ---
function check_command_status() {
    # Check exit code of previous command
    if [ $? -eq 0 ]; then
        command_verification="🐻"
    else
        command_verification="❌"
    fi

    # CRITICAL: Ensure the path to trigger.sh matches where you saved the file
    # We use the previous context location, but verify this on your Mac:
    if [ -f "$HOME/.dotfile/zshconfig/trigger.sh" ]; then
        source "$HOME/.dotfile/zshconfig/trigger.sh"
    fi

    # Define Prompt Visuals
    STATUS_1="(%f$HOST🍎 %B%F{cyan}%~%f%b%F{blue})"
    STATUS_2=" %n@"
    STATUS_3="${command_verification}%F{green}${vpn_proxy}${docker_environment}%f%F{red}${git_branch}%f%F{magenta}${python_venv}${node_version}${conda_activate_env}%f"
    STATUS_4=" "
    
    # Logic to shorten prompt if it gets too long
    if [ ${#STATUS_3} -gt 34 ]; then
        unset STATUS_2 
        unset STATUS_4
    fi

    PROMPT_STATUS="%F{blue}${STATUS_1}%f - [%F{yellow}${STATUS_2}%f${STATUS_3}${STATUS_4}]"

    PROMPT="${PROMPT_STATUS} 
%B%F{red}>%f%F{blue}>%f%F{green}>%f%b "

    # Root user check
    if [ $(whoami) = 'root' ]; then
        PROMPT="${PROMPT_STATUS} 
💀 %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
    fi
}

# Execute before every prompt
precmd(){
    check_command_status
}

# --- Completion System (Highly Recommended for macOS/Homebrew) ---
# This enables tab completion for git, brew, etc.
autoload -Uz compinit
compinit

# Add PATH (Ensure ~/bin exists on your Mac)
export PATH="$HOME/bin:$PATH"

# --- Avoid duplicates in PATH ---
clean_path() {
    # Standard BSD/macOS compatible cleanup
    export PATH=$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':' | sed 's/:$//')
}
clean_path