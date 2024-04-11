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
HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt appendhistory


function check_command_status()
{
    if [ $? -eq 0 ];then
        #git_branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1)/')"
        branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
        [[ ! -z $branch ]] && git_branch="( $branch)" || git_branch=''
        [[ ! -z $VIRTUAL_ENV ]] && python_venv="(🐍 $(basename "$VIRTUAL_ENV"))" || python_venv=''
        #conda_env="($( conda env list | grep -Ei '\*' | awk '{if($1 != "base") print $1}'))"
        PROMPT_STATUS="%F{green} $python_venv%f%F{red}$git_branch%f%F{green}😊%f"
    else
        branch="$(git branch 2>/dev/null | grep -e '\* ' | sed 's/\*.//g')" 
        [[ ! -z $branch ]] && git_branch="( $branch)" || git_branch=""
        [[ ! -z $VIRTUAL_ENV ]] && python_venv="(🐍 $(basename "$VIRTUAL_ENV"))" || python_venv=''
        PROMPT_STATUS="%F{green} $python_venv%f%F{red}$git_branch%f%F{green}❌%f"
    fi
    # root user
    if [ $(whoami) = 'root' ];then
        PROMPT="%S%F{red}%n%f%s${PROMPT_STATUS} %B%F{cyan}%1~%f%b %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
    else
        PROMPT="%S%F{yellow}%n%f%s${PROMPT_STATUS} %B%F{cyan}%1~%f%b %B%F{red}>%f%F{blue}>%f%F{green}>%f%b "
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

# ADD EDITOR 
export EDITOR=vim
export VISUAL=vim

# print logo and change working drictory
clear
cd $HOME
if [[ -f $HOME/DailyPlan ]];then
    bat $HOME/DailyPlan
fi
#echo $logo
