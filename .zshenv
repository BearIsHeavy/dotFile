# Running zsh which files will be loaded?
# For zsh: 
# Note that zsh seems to read ~/.profile
# if ~/.zshrc is not present.

# +----------------+-----------+-----------+------+
# |                |Interactive|Interactive|Script|
# |                |login      |non-login  |      |
# +----------------+-----------+-----------+------+
# |/etc/zshenv     |    A      |    A      |  A   |
# +----------------+-----------+-----------+------+
# |~/.zshenv       |    B      |    B      |  B   |
# +----------------+-----------+-----------+------+
# |/etc/zprofile   |    C      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zprofile     |    D      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zshrc      |    E      |    E      |      |
# +----------------+-----------+-----------+------+
# |~/.zshrc        |    F      |    F      |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogin     |    G      |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogin       |    H      |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |                |           |           |      |
# +----------------+-----------+-----------+------+
# |~/.zlogout      |    I      |           |      |
# +----------------+-----------+-----------+------+
# |/etc/zlogout    |    J      |           |      |
# +----------------+-----------+-----------+------+
#

# This file used to add zsh-set envirement
logo="

__________   __    __                        __
\______   \_/  |__/  |_____________    ____ |  | __
 |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
 |    |   \ |  |  |  |  |  | \// __ \\  \___|    <
 |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
        \/                         \/     \/     \/
                                        author:Bear
"

# souce necessary file                                                     
if [[ -s $HOME/.dotfile/.alias ]];then                                       
    source $HOME/.dotfile/.alias                                           
fi                                                                         

# source ld file to list only directory
[ -f $HOME/.dotfile/bin/ldir.sh ] && source $HOME/.dotfile/bin/ldir.sh

# Add Editor
export EDITOR=vim
export VISUAL=vim

export PATH="$PATH:$HOME/.local/bin"

