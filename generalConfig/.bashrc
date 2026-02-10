#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # Removed debian_chroot
    PS1='\[\033[01;32m\]\u🥰 \[\033[01;34m\]\W >\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# xterm title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\]\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# --- MAC SPECIFIC: LS COLORS ---
# macOS uses CLICOLOR and LSCOLORS instead of dircolors (unless coreutils is installed)
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [ -x "$(command -v dircolors)" ]; then
    test -r "$HOME"/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls -G' # macOS color flag

# Add an "alert" alias for long running commands.
# CHANGED: Uses AppleScript for notifications instead of notify-send
alias alert='osascript -e "display notification \"Task finished\" with title \"Terminal\""'

# Source aliases
if [ -f "$HOME"/.dotfile/.alias ]; then
    source "$HOME"/.dotfile/.alias
fi

# enable programmable completion features
# CHANGED: Path for Homebrew bash-completion on M4 Mac
if ! shopt -oq posix; then
  if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    . /opt/homebrew/etc/profile.d/bash_completion.sh
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

unset PROMPT_COMMAND
set bell-style none