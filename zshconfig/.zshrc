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

# source .zlogin file
# if dones't want to running this model, you can comment following code
if [[ -z $ZPROFILE_SOURCED && -f "$HOME/.zprofile" ]];then
    . "$HOME/.zprofile"
fi

if [[ -z $ZLOGIN_SOURCED && -f "$HOME/.zlogin" ]];then
    . "$HOME/.zlogin"
fi

# Check if the command exists and give download suggestions
function command_not_found_handler() {
    if pkgfile "$1" > /dev/null 2>&1; then
        echo "The command '$1' is not installed. You can install it with:"
        local packages="$(pkgfile -b $1 | paste -s -d ',')"
        local items=(${(@s/,/)packages})
        for package in $items; do
            echo "sudo pacman -S $package"
        done
    else
        echo "zsh: command not found: $1"
    fi
    return 127
}

# enable command sustitution in prompt
setopt promptsubst 


# history search
typeset -g -A key

key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


# check command status and set flag
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

# Avoid duplicates in history
setopt hist_ignore_all_dups
# Sync history immediately between sessions
setopt share_history inc_append_history
# enabled timestamps
export HISTTIMEFORMAT='%F %T '
