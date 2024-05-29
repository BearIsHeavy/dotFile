#!/bin/env bash

# This function only list fold not include file
function ldir()
{
  fold_information="$(/bin/ls -l $PWD)"
  for fold in $(/bin/ls $PWD);do
    if [[ -d $PWD/$fold ]];then
      infor=$(echo $fold_information | grep -Ei $fold)
      echo "$infor"
    fi
  done
  unset fold_information 
}
