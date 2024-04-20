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
