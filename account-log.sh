#!/bin/bash

mes=$1;
ano=$2;

ids_commands=$(egrep "$ano-$mes-[0-9]+" ~/command_history | awk '{print $1 " " $3}');

min_id=$(echo "$ids_commands" | head -n 1 | awk '{print $1}');
max_id=$(echo "$ids_commands" | tail -n 1 | awk '{print $1}');

times=$(awk -v min=$min_id -v max=$max_id '{if ($1 >= min && $1 <= max) { print $2 " " $3 " " $4 }}' ~/accounting.txt);
total=$(echo "$times" | awk '{x+=$1; y+=$2; z+=$3} END {print "Real " x "\nUser " y "\nSystem " z}');


echo "================== Used CPU Time ==================";
echo;
echo "$total";
echo;
