#!/bin/bash

echo "---- NMAP ----"
echo "Running NMAP..."
nmap -e tun0 -sn 10.0.0.0/8 172.16-31.0.0/16 192.168.0.0/16 -oG - | awk '/Up$/{print $2}' > results
echo "The following hosts are up..."
cat results

echo "---- NMAP port scan ----"
while read line
do
echo "Running port scan for {$line}"
nmap -A $line
done < results

