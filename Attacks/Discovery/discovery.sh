#!/bin/bash
# T1016 : System Network Configuration Discovery
cat /etc/resolv.conf > networkenum.txt # Obtains DNS servers used by the system
ifconfig -a >> networkenum.txt # Lists current Network Interfaces
arp -a >> networkenum.txt # List local arp cache
netstat -auntp >> networkenum.txt # Lists TCP/UDP Listening Ports and Connections
ss -twurp >> networkenum.txt # Lists active connections and processes
ip route >> networkenum.txt # See routes
for i in {1..254} ;do (ping 10.10.10.$i -c 1 -w 5 >/dev/null && echo "10.10.20.$i" &) ;done > ips.txt
for i in {1..254} ;do (ping 10.10.20.$i -c 1 -w 5 >/dev/null && echo "10.10.20.$i" &) ;done >> ips.txt
for i in {1..254} ;do (ping 172.16.20.$i -c 1 -w 5 >/dev/null && echo "172.16.20.$i" &) ;done >> ips.txt
for i in {1..254} ;do (ping 172.16.20.$i -c 1 -w 5 >/dev/null && echo "172.16.40.$i" &) ;done >> ips.txt
for i in {1..254} ;do (ping 192.168.10.$i -c 1 -w 5 >/dev/null && echo "192.168.10.$i" &) ;done >> ips.txt
for i in {1..254} ;do (ping 192.168.30.$i -c 1 -w 5 >/dev/null && echo "192.168.30.$i" &) ;done >> ips.txt
cat ips.txt | sort -u > ips_sorted.txt

# T1046 : Network Service Discovery
nmap -sV -sC -O -T4 -n -Pn -oA fastscan -iL ips_sorted.txt -o internal_host_scan

# T1087 : Account Discovery
## T1087.001 - Local Account 
awk -F: '{ print $1}' /etc/passwd > users.txt
cat ~/.ssh/creds > /ssh_creds.txt

# T1057 : Process Discovery
ps -aux > ps_aux.txt

# T1069 : Permission Groups Discovery
## T1069.001 - Local Groups
cut -d: -f1 /etc/passwd | xargs groups > local_groups.txt

# T1082 : System Information Discovery
uname -a > sysenum.txt
fdisk -l >> sysenum.txt

