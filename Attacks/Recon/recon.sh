#!/bin/bash

printf "\n---- NMAP ----\n\n" > results
echo "Running NMAP..."
namp 192.168.20.0/24 10.10.10.0/24  | tail -n +5 | head -n -3 >> results

while read line
do
if [[$line == *open* ]] && [[ $line == *http* ]]
then 
echo "Running Gobuster..."
gobuster dir -u 192.168.20.0/24 10.10.10.0/24 -w /usr/share/wordlists/dirb/common.txt -qz > temp1
echo "Running WhatWeb..."
whatweb 192.168.20.0/24 10.10.10.0/24 -v > temp2
fi

done < results

if [ -e temp1 ]
then
printf "\n---- DIRS ----\n\n" >> results
cat temp1 >> results
rm temp1
fi

if [ -e temp2 ]
then
printf "\n---- WEB ----\n\n" >> results
cat temp2 >> results
rm temp2
fi

cat result
