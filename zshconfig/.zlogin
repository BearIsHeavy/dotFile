ZLOGIN_SOURCE=True
bindkey '^A' beginning-of-line

# souce necessary file                                                     
if [[ -s $HOME/.dotfile/generalConfig/.alias ]];then                                       
    source $HOME/.dotfile/generalConfig/.alias                                           
fi                                                                         