#!/bin/bash

if [ ! -f $HOME/.profile ];then
    ln -s $(HOME)/.profile ~
fi

if [ ! -f $HOME/.bashrc ];then
    ln -s $(HOME)/.bashrc ~
fi

if [ ! -f $HOME/.vimrc ];then
    ln -s $(HOME)/.vimrc ~
fi

if [ ! -f $HOME/.zshrc ];then
    ln -s $(HOME)/.zshrc ~
fi
