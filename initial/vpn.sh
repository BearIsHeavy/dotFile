#!/bin/env bash

. $HOME/.dotfile/initial/colors.sh # import color file

if ! curl --max-time 5 www.google.com -i; then
  echo -e -n "${RED}Not connection github etc${RESET} \n" 1>&2; exit 2
else
  echo -e -n "${GREEN}Sucessfully to connecte github etc.${RESET}"
fi

