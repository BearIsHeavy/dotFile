# Function to check command exit status
VIRTUAL_ENV=basic

# this snipper be used to auto-suggesion when you type commands
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

function check_command_status()
{
    if [ $? -eq 0 ];then
        git_branch=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/')
        if [[ $git_branch == "" ]];then
            python_venv="($(basename "$VIRTUAL_ENV"))"
            PROMPT_STATUS="%F{yellow} $python_venv %f%F{green}😊%f"
        else
            PROMPT_STATUS="%F{blue} $git_branch %f%F{green}😊%f"
        fi
    else
        git_branch=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/')
        if [[ $git_branch == "" ]];then
            python_venv="($(basename "$VIRTUAL_ENV"))"
            PROMPT_STATUS="%F{yellow} $python_venv %f%F{green}❌%f"
        else
            PROMPT_STATUS="%F{blue} $git_branch %f%F{green}❌%f"
        fi
    fi

    # root user
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

