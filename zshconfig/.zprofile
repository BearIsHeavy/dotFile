# This file will be used for specifical computer
# not recommand use this file for all computer

ZPROFILE_SOURCED=TRUE

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bear/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bear/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bear/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bear/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# source conda but don't enter
if [[ $CONDA_DEFAULT_ENV == "base" ]];then
   conda deactivate
fi

export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
