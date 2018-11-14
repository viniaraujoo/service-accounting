red=`tput setaf 2`;
bold=`tput bold`;
reset=`tput sgr0`;

clear;

while true 
do
  echo -n "${red}${bold}"'ll-best-shell:'"$(pwd)"'$'"${reset} ";
  read -a line;

  ${line[@]};     

done < "${1:-/dev/stdin}";
