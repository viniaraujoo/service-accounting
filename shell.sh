red=`tput setaf 2`;
bold=`tput bold`;
reset=`tput sgr0`;

clear;

while true
do
  echo -n "${red}${bold}"'ll-best-shell~$'"${reset} ";
  read -a line;

  if [ "$line" = "exit" ] ; then
     exit 0;
  fi

  echo "${line[@]}" | bash;
done < "${1:-/dev/stdin}";
