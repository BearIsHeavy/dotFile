#!/bin/env bash

last_command="$(tail -n 1 <(history) | awk '{print substr($0, 8)}')"

if [[ $last_command =~ (conda activate) ]];then
  conda_activate_env="(🐍 $(echo $last_command | awk '{print $3}'))"
elif [[ $last_command =~ 'deactivate' ]];then
  unset conda_activate_env
fi
