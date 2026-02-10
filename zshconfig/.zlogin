ZLOGIN_SOURCE=True
bindkey '^A' beginning-of-line

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