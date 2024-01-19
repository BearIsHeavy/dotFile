# Function to check command exit status
VIRTUAL_ENV=basic

check_command_status()
{
    if [ $? -eq 0 ];then
	    #PROMPT_STATUS=" ($(basename "$VIRTUAL_ENV)") %F{green}😊%f"  # Success status (green)
        PROMPT_STATUS="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/') ($(basename "$VIRTUAL_ENV")) %F{green}😊%f"  # Success status (green)
    else
        #PROMPT_STATUS=" ($(basename "$VIRTUAL_ENV)") %F{red}😟%f"    # Failure status (red)
        PROMPT_STATUS="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/') ($(basename "$VIRTUAL_ENV")) %F{read}❌%f"  # Success status (green)
    fi

    if [ $(whoami) = 'root' ];then
        PROMPT="%S%F{red}%n%f%s${PROMPT_STATUS} %B%F{cyan}%1~%f%b %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
    else
        PROMPT="%S%F{green}%n%f%s${PROMPT_STATUS} %B%F{cyan}%1~%f%b %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
    fi
}

# this funcation will be execute before execute next command
precmd(){
    check_command_status
}

# This code snip will be used to set Promopt
PS1="%n@%m %1~ %#"

# souce necessary file
if [ -s $HOME/.dotfile/.alias ];then
    source $HOME/.dotfile/.alias
fi

# Add PATH
export PATH=$HOME/bin:$PATH

# ADD NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

