#!/bin/bash

red=`tput setaf 2`;
bold=`tput bold`;
reset=`tput sgr0`;
blue=`tput setaf 33`;

if [ ! -e ~/accounting.txt ] ; then
    echo "ID REAl_TIME USER_TIME SYS_TIME" > ~/accounting.txt;
fi

if [ ! -e ~/command_history ] ; then
    echo "ID DATE COMMAND" > ~/command_history;
fi

clear;
cd;

function short_dir {
    dir=$(pwd);
    if echo $dir | grep $HOME > /dev/null ; then
        dir=~$(echo $dir | awk -F $HOME '{print $2}');
    fi;
    echo $dir;
}


function get_id {
    last_id=$(tail -n 1 ~/accounting.txt | awk '{print $1}');

    if ! [[ $last_id =~ ^[0-9]+$ ]] ; then
        last_id=0;
    fi

    id=$(expr 1 + $last_id);
    echo $id;
}

while read -p "${red}${bold}$USER"'@ll-best-shell'"${reset}:${blue}${bold}$(short_dir)${reset}"'$ ' -ea line;
do

  id=$(get_id);

  if [[ "${line[0]}" = "cd" ]] || [[ "${line[0]}" = "exit" ]] ; then
      ${line[@]};
  else
      echo "${line[@]}" | /usr/bin/time -ao ~/accounting.txt -f "$id %e %U %S" bash; 
  fi;

  echo "$id $(date +\%F) ${line[0]}" >> ~/command_history

done < "${1:-/dev/stdin}";
echo
