#!/bin/bash

source ~/.dotfile/initial/colors.sh

(nvcc --version || sudo apt install nvidia-cuda-toolkit -y) && nvcc --version

# install prerequisites
sudo apt install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

# installation
if ( ! cd ~/Download \
      && curl --max-time 5 https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh \
      && curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh );then

  check_sha=$(sha256sum ~/Download/Anaconda3-2024.02-1-Linux-x86_64.sh | awk '{print $1}')
  if [[ $check_sha == "c536ddb7b4ba738bddbd4e581b29308cb332fa12ae3fa2cd66814bd735dff231" ]];then
    bash ~/Download/Anaconda3-2024.02-1-Linux-x86_64.sh
  fi
else
  # not connecte network
  echo -e -n "${READ}network connection error, now is reading local file...${RESET}" 
  if [[ -s ~/Download/Anaconda3-2024.02-1-Linux-x86_64.sh ]];then
    check_sha=$(sha256sum ~/Download/Anaconda3-2024.02-1-Linux-x86_64.sh | awk '{print $1}')
    echo -e -n "\n ${GREEN}$check_sha${RESET} \n"
    if [[ $check_sha == "c536ddb7b4ba738bddbd4e581b29308cb332fa12ae3fa2cd66814bd735dff231" ]];then
      bash ~/Download/Anaconda3-2024.02-1-Linux-x86_64.sh
    fi
  else
    echo -e -n "${READ}not have local file...${RESET} \n"
    exit 2 # not have conda file
  fi
fi



exit 0
