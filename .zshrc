#__________   __    __                        __    
#\______   \_/  |__/  |_____________    ____ |  | __
# |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
# |    |   \ |  |  |  |  |  | \// __ \\  \___|    < 
# |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
#        \/                         \/     \/     \/
#                                       author:bear



# Function to check command exit status
VIRTUAL_ENV=basic

# Set history model
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory

#enable command sustitution in prompt
setopt promptsubst 

# this snipper be used to auto-suggesion when you type commands
if [[ -L ~/.zsh ]];then
    source ~/.zsh/zsh-autosuggestions/*.zsh
else
    read -p "Do you make symbol link to .zsh?" c
    if [[ $c =~ ^(Y|y) ]];then
        ln -s $HOME/.dotfile/.zsh $HOME/.zsh
    else
        echo "not insatll" 1>&2
        #echo ".zsh folds is not exit" 1>&2
    fi
fi

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
# source download auto-suggestion
if [[ -f /etc/zsh_command_not_found ]];then
    source /etc/zsh_command_not_found
else
    echo "/etc/zsh_command_not_found not installed"
    echo "sudo apt install zsh_command_not_found"
fi

# Add PATH
export PATH=$HOME/bin:$PATH

# ADD NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ADD EDITOR 
export EDITOR=vim
export VISUAL=vim

# print logo and change working drictory
echo $logo
cd $HOME
