#__________   __    __                        __    
#\______   \_/  |__/  |_____________    ____ |  | __
# |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
# |    |   \ |  |  |  |  |  | \// __ \\  \___|    < 
# |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
#        \/                         \/     \/     \/
#                                       author:bear

# print logo and change working drictory
clear
echo $logo
cd $HOME


# Function to check command exit status
VIRTUAL_ENV=basic

# Set history model
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory


function check_command_status()
{
    if [ $? -eq 0 ];then
        #git_branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/')"
        branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
        [[ ! -z $branch ]] && git_branch="( $branch)" || git_branch=""
        python_venv="( $(basename "$VIRTUAL_ENV"))"
        if [[ $git_branch == "" ]];then
            PROMPT_STATUS="%F{yellow} $python_venv %f%F{green}😊%f"
        else
            PROMPT_STATUS="%F{blue} $python_venv%f%F{red}$git_branch%f%F{green}😊%f"
        fi
    else
        branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
        [[ ! -z $branch ]] && git_branch="( $branch)" || git_branch=""
        python_venv="( $(basename "$VIRTUAL_ENV"))"
        if [[ $git_branch == "" ]];then
            PROMPT_STATUS="%F{yellow} $python_venv %f%F{green}❌%f"
        else
            PROMPT_STATUS="%F{blue} $python_venv%f%F{red}$git_branch%f%F{green}❌%f"
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


#enable command sustitution in prompt
setopt promptsubst 

# This code snip will be used to set Promopt
PS1="%n@%m %1~ %#"

# souce necessary file
if [ -s $HOME/.dotfile/.alias ];then
    source $HOME/.dotfile/.alias
fi
# source download zsh_command_not_found
if [[ -f /etc/zsh_command_not_found ]];then
    source /etc/zsh_command_not_found
else
    echo "/etc/zsh_command_not_found not installed\n" 1>&2
    echo "sudo apt install zsh_command_not_found"   1>&2
fi

# this snipper be used to auto-suggesion when you type commands
if [[ -d ~/.zsh/zsh-autosuggestions || -L ~/.zsh/zsh-autosuggestions  ]];then
    source ~/.zsh/zsh-autosuggestions/*.zsh
else
    echo -e "not find $HOME/.zsh/zsh-autosuggestion fold\n" 1>&2
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

# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/bear/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bear/anaconda3/etc/profile.d/conda.sh" ]; then
        source "/home/bear/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        export PATH="/home/bear/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# Add CUDA_PATH
CUDA_PATH="/usr/local/cuda-12.1/bin"
export PATH=$CUDA_PATH:$PATH


