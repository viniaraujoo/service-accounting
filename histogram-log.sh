#!/bin/bash

mes=$1;
ano=$2;

commands=$(egrep "$ano-$mes-[0-9]+" ~/command_history | awk '{print $3}');

echo "==================   Histogram   =================="
echo;

if ! [ -z "$commands" ] ; then
    echo "$commands" | awk '{lst[$1]++} END {for (i in lst) {printf("%10s: %d\n", i, lst[i])}}' | sort -n -k2;
else
    echo "No history on this date";
fi
echo;
