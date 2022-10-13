#!/bin/bash
# This script is meant to be run on the host OS
# RUN in root
# ./setup.sh

RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color

# F. Test ping
echo -e "${BGREEN}\n[+]${NC} F. Commencing PING TEST...${NC}"
## F1. Gateway ping
echo -e "${BGREEN}[+]${NC} F1. ${GREEN}HOST-to-GATEWAY${NC} (respective) PING TEST..."
echo -e "${BGREEN}[+]${NC} Pinging r1_eth0 from c1_eth0..."
docker exec -it c1 ping -c 4 10.10.10.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth1 from c2_eth0${NC}..."
docker exec -it c2 ping -c 4 192.168.10.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth2 from c3_eth0${NC}..."
docker exec -it c3 ping -c 4 192.168.20.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth0 from c4_eth0${NC}..."
docker exec -it c4 ping -c 4 172.16.10.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth1 from r1_eth3${NC}..."
docker exec -it r1 ping -c 4 172.16.20.2

## F2. Inter-subnet Host ping
echo -e "\n${BGREEN}[+]${NC} F2. ${GREEN}INTER-SUBNET HOST-to-HOST${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging c2 from c1..."
docker exec -it c1 ping -c 4 192.168.10.2

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}c3 from c1${NC}..."
docker exec -it c1 ping -c 4 192.168.20.2

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}c3 from c2${NC}..."
docker exec -it c2 ping -c 4 192.168.20.2

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}c1 from c4${NC}..."
docker exec -it c4 ping -c 4 10.10.10.2

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}c2 from c4${NC}..."
docker exec -it c4 ping -c 4 192.168.10.2

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}c1 from c4${NC}..."
docker exec -it c4 ping -c 4 192.168.20.2

## F3. Inter-subnet Router ping
echo -e "\n${BGREEN}[+]${NC} F3. INTER-SUBNET HOST-to-ROUTER PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging r2_eth0 from c1..."
docker exec -it c1 ping -c 4 172.16.10.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth1 from c1${NC}..."
docker exec -it c1 ping -c 4 172.16.20.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth0 from c2${NC}..."
docker exec -it c2 ping -c 4 172.16.10.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth1 from c2${NC}..."
docker exec -it c2 ping -c 4 172.16.20.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth0 from c3${NC}..."
docker exec -it c3 ping -c 4 172.16.10.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth1 from c3${NC}..."
docker exec -it c3 ping -c 4 172.16.20.1

echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth0 from c4${NC}..."
docker exec -it c4 ping -c 4 10.10.10.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth1 from c4${NC}..."
docker exec -it c4 ping -c 4 192.168.10.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth2 from c4${NC}..."
docker exec -it c4 ping -c 4 192.168.20.1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth3 from c4${NC}..."
docker exec -it c4 ping -c 4 172.16.20.1