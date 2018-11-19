#!/bin/bash

red=`tput setaf 2`;
bold=`tput bold`;
reset=`tput sgr0`;
blue=`tput setaf 33`;

clear;
cd;

function short_dir {
    dir=$(pwd);
    if echo $dir | grep $HOME > /dev/null ; then
        dir=~$(echo $dir | awk -F $HOME '{print $2}');
    fi;
    echo $dir;
}

while read -p "${red}${bold}$USER"'@ll-best-shell'"${reset}:${blue}${bold}$(short_dir)${reset}"'$ ' -ea line;
do

  if [[ "${line[0]}" = "cd" ]] ; then
      ${line[@]};
  else
      echo "${line[@]}" | time -ao accounting.txt -f "%E real, %U user, %S sys" bash; 
  fi;

done < "${1:-/dev/stdin}";
echo
