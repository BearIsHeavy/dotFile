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
ZSHENV_SOURCE=True

logo="

__________   __    __                        __
\______   \_/  |__/  |_____________    ____ |  | __
 |    |  _/\   __\   __\_  __ \__  \ _/ ___\|  |/ /
 |    |   \ |  |  |  |  |  | \// __ \\  \___|    <
 |______  / |__|  |__|  |__|  (____  /\___  >__|_ \ 🐻
        \/                         \/     \/     \/ author:Bear
"

# Add Editor
export EDITOR=vim
export VISUAL=vim

# --- Autosuggestions (Adjusted for Homebrew) ---
# Install via: brew install zsh-autosuggestions
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -d ~/.zsh/zsh-autosuggestions ]]; then
    # Keep your manual fallback just in case
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    echo "zsh-autosuggestions not found. Try: brew install zsh-autosuggestions"
fi