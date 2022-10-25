#!/bin/bash

echo "---- NMAP ----"
echo "Running NMAP..."
nmap -e tun0 -sn 10.10.10.0/24 10.10.20.0/24 172.16.20.0/24 172.16.40.0/24 192.168.10.0/24 -oG - | awk '/Up$/{print $2}' > results
echo "The following hosts are up..."
cat results

echo "---- NMAP port scan ----"
while read line
do
echo "Running port scan for {$line}"
nmap -A $line
done < results

