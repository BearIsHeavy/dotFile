#__________   __    __                        __    
#\______   \_/  |__/  |_____________    ____ |  | __
# |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
# |    |   \ |  |  |  |  |  | \// __ \\  \___|    < 
# |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
#        \/                         \/     \/     \/
#                                       author:bear

# Function to check command exit status
VIRTUAL_ENV=''

# Set history model
HISTSIZE=2000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history


function check_command_status()
{

[ $? -eq 0 ] && command_verification="🐻" || command_verification="❌"
[ -f $HOME/.dotfile/zshconfig/trigger.sh ] && source "$HOME/.dotfile/zshconfig/trigger.sh"
STATUS_1="(%f$HOST⛈  %B%F{cyan}%~%f%b%F{blue})"
STATUS_2=" %n@"
STATUS_3="${command_verification}%F{green}${vpn_proxy}${docker_environment}%f%F{red}$git_branch%f%F{magenta}${python_venv}${node_version}${conda_activate_env}%f"
STATUS_4=" "
[ ${#STATUS_3} -gt 34 ] && unset STATUS_2 && unset STATUS_4
PROMPT_STATUS="%F{blue}${STATUS_1}%f - [%F{yellow}${STATUS_2}%f${STATUS_3}${STATUS_4}]"

PROMPT="${PROMPT_STATUS} 
%B%F{red}>%f%F{blue}>%f%F{green}>%f%b "

# root user
if [ $(whoami) = 'root' ];then
PROMPT="${PROMPT_STATUS} 
💀 %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
fi

}

# this funcation will be execute before execute next command
precmd(){
    check_command_status
}

#enable command sustitution in prompt
setopt promptsubst 

# Add PATH
export PATH="$HOME/bin:$PATH"


# Add key array
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Avoid duplicates in history
# setopt hist_ignore_all_dups

# Sync history immediately between sessions
setopt share_history inc_append_history

# Avoid duplicates in PATH
clean_path() {
  export PATH=$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':' | sed 's/:$//')
}
clean_path
# Source zsh Profile
[[ -z $ZPROFILE_SOURCED ]] && echo ".zprofile not be loaded"
