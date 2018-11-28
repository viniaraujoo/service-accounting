#!/bin/bash

mes=$1;

ids=$(egrep "[0-9]+-$mes-[0-9]+" ~/command_history | awk '{print $1}');
times=$(echo "$ids" | awk '{system("egrep \"^" $1 "\s\" ~/accounting.txt")}' | awk '{print $2 " "  $3 " " $4}');
total=$(echo "$times" | awk '{x+=$1; y+=$2; z+=$3} END {print "Real " x "\nUser " y "\nSystem " z}');
commands=$(echo "$ids" | awk '{system("egrep \"^" $1 "\s\" ~/command_history")}' | awk '{print $3}');


echo "================== Used CPU Time ==================";
echo;
echo "$total";
echo;
echo "==================   Histogram   =================="
echo;
echo "$commands" | awk '{lst[$1]++} END {for (i in lst) {printf("%10s: %d\n", i, lst[i])}}' | sort -n -k2;
echo;
