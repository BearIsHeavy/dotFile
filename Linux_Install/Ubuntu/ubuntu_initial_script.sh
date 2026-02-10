#!/bin/bash

# Set up domestic sources
apt_sources="/etc/apt/sources.list.d/ubuntu.sources"
[[ -e $apt_sources ]] && cp $apt_sources "/etc/apt/sources.list.d/ubuntu.sources.bak"
echo -e "
# 阿里云
Types: deb
URIs: http://mirrors.aliyun.com/ubuntu/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg 

# 清华源
Types: deb
URIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 中科大源
Types: deb
URIs: http://mirrors.ustc.edu.cn/ubuntu/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 网易163
Types: deb
URIs: http://mirrors.163.com/ubuntu/
Suites: noble noble-updates noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
" > $apt_sources

# Update and Upgrade
sudo apt update && sudo apt upgrade

# Set root account
function set_root_information() {
    echo "your are setting root passwd"
    sudo passwd root
}

# Install NVIDIA GPU
function view_gpu_information() {
    lspci | grep -i 'nvidia'
}