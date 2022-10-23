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
### dev_nw
#### D1
echo -e "${BGREEN}[+]${NC} Pinging r1_eth0 from d1_eth0..."
docker exec -it d1 ping -c 4 192.168.10.254

### suitecrm_nw
#### S1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth3 from s1_eth0${NC}..."
docker exec -it s1 ping -c 4 10.10.10.254
#### S2
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r1_eth3 from s2_eth0${NC}..."
docker exec -it s2 ping -c 4 10.10.10.254

### elk_nw
#### elasticsearch
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from elasticsearch_eth0${NC}..."
docker exec -it elasticsearch ping -c 4 192.168.30.254
#### logstash
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from logstash_eth0${NC}..."
docker exec -it logstash ping -c 4 192.168.30.254
#### kibana
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from kibana_eth0${NC}..."
docker exec -it kibana ping -c 4 192.168.30.254
#### heartbeat
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from heartbeat_eth0${NC}..."
docker exec -it heartbeat ping -c 4 192.168.30.254
#### metricbeat
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from metricbeat_eth0${NC}..."
docker exec -it metricbeat ping -c 4 192.168.30.254
#### packetbeat
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r3_eth0 from packetbeat_eth0${NC}..."
docker exec -it packetbeat ping -c 4 192.168.30.254

### dmz_nw
#### DMZ1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth0 from dmz1_eth0${NC}..."
docker exec -it dmz1 ping -c 4 10.10.20.254

### internet_nw
#### K1
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}r2_eth1 from k1_eth0${NC}..."
docker exec -it k1 ping -c 4 172.16.10.3
echo -e "\n${BGREEN}[+]${NC} Pinging ${GREEN}d1_eth1 from k1_eth0${NC}..."
docker exec -it k1 ping -c 4 172.16.10.4

## F2. FIRST-BOUND ping
echo -e "\n${BGREEN}[+]${NC} F2. ${GREEN}FIRST-BOUND${NC} PING TEST${NC}..."

echo -e "\n${BGREEN}[+]${NC} F2.1 ${GREEN}FIRST-BOUND from dev_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging s1 from d1..."
docker exec -it d1 ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from d1..."
docker exec -it d1 ping -c 4 10.10.10.3
echo -e "${BGREEN}[+]${NC} Pinging r2 from d1..."
docker exec -it d1 ping -c 4 172.16.20.2
echo -e "${BGREEN}[+]${NC} Pinging r3 from d1..."
docker exec -it d1 ping -c 4 172.16.40.2


echo -e "\n${BGREEN}[+]${NC} F2.2 ${GREEN}FIRST-BOUND from dmz_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging r1 from dmz1..."
docker exec -it dmz1 ping -c 4 172.16.20.3
echo -e "${BGREEN}[+]${NC} Pinging k1 from dmz1..."
docker exec -it dmz1 ping -c 4 172.16.10.2


echo -e "\n${BGREEN}[+]${NC} F2.3 ${GREEN}FIRST-BOUND from elk_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging r1 from elasticsearch..."
docker exec -it elasticsearch ping -c 4 172.16.40.3
echo -e "${BGREEN}[+]${NC} Pinging r1 from logstash..."
docker exec -it logstash ping -c 4 172.16.40.3
echo -e "${BGREEN}[+]${NC} Pinging r1 from kibana..."
docker exec -it kibana ping -c 4 172.16.40.3
echo -e "${BGREEN}[+]${NC} Pinging r1 from heartbeat..."
docker exec -it heartbeat ping -c 4 172.16.40.3
echo -e "${BGREEN}[+]${NC} Pinging r1 from metricbeat..."
docker exec -it metricbeat ping -c 4 172.16.40.3
echo -e "${BGREEN}[+]${NC} Pinging r1 from packetbeat..."
docker exec -it packetbeat ping -c 4 172.16.40.3

## F3. SECOND-BOUND ping
echo -e "\n${BGREEN}[+]${NC} F3. ${GREEN}SECOND-BOUND ${NC} PING TEST${NC}..."

echo -e "\n${BGREEN}[+]${NC} F3.1 ${GREEN}SECOND-BOUND from dev_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging dmz1 from d1..."
docker exec -it d1 ping -c 4 10.10.20.2
echo -e "${BGREEN}[+]${NC} Pinging elasticsearch from d1..."
docker exec -it d1 ping -c 4 192.168.30.2
echo -e "${BGREEN}[+]${NC} Pinging logstash from d1..."
docker exec -it d1 ping -c 4 192.168.30.3
echo -e "${BGREEN}[+]${NC} Pinging kibana from d1..."
docker exec -it d1 ping -c 4 192.168.30.4
echo -e "${BGREEN}[+]${NC} Pinging heartbeat from d1..."
docker exec -it d1 ping -c 4 192.168.30.5
echo -e "${BGREEN}[+]${NC} Pinging metricbeat from d1..."
docker exec -it d1 ping -c 4 192.168.30.6
echo -e "${BGREEN}[+]${NC} Pinging packetbeat from d1..."
docker exec -it d1 ping -c 4 192.168.30.7

echo -e "\n${BGREEN}[+]${NC} F3.2 ${GREEN}SECOND-BOUND from dmz_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging d1 from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from dmz1..."
docker exec -it dmz1 ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from dmz1..."
docker exec -it dmz1 ping -c 4 10.10.10.3

echo -e "\n${BGREEN}[+]${NC} F3.3 ${GREEN}SECOND-BOUND from elk_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging d1 from elasticsearch..."
docker exec -it elasticsearch ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from elasticsearch..."
docker exec -it elasticsearch ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from elasticsearch..."
docker exec -it elasticsearch ping -c 4 10.10.10.3


echo -e "\n${BGREEN}[+]${NC} Pinging d1 from logstash..."
docker exec -it logstash ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from logstash..."
docker exec -it logstash ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from logstash..."
docker exec -it logstash ping -c 4 10.10.10.3


echo -e "\n${BGREEN}[+]${NC} Pinging d1 from kibana..."
docker exec -it kibana ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from kibana..."
docker exec -it kibana ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from kibana..."
docker exec -it kibana ping -c 4 10.10.10.3

echo -e "\n${BGREEN}[+]${NC} Pinging d1 from heartbeat..."
docker exec -it heartbeat ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from heartbeat..."
docker exec -it heartbeat ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from heartbeat..."
docker exec -it heartbeat ping -c 4 10.10.10.3

echo -e "\n${BGREEN}[+]${NC} Pinging d1 from metricbeat..."
docker exec -it metricbeat ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from metricbeat..."
docker exec -it metricbeat ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from metricbeat..."
docker exec -it metricbeat ping -c 4 10.10.10.3

echo -e "\n${BGREEN}[+]${NC} Pinging d1 from packetbeat..."
docker exec -it packetbeat ping -c 4 192.168.10.2
echo -e "${BGREEN}[+]${NC} Pinging s1 from packetbeat..."
docker exec -it packetbeat ping -c 4 10.10.10.2
echo -e "${BGREEN}[+]${NC} Pinging s2 from packetbeat..."
docker exec -it packetbeat ping -c 4 10.10.10.3

echo -e "\n${BGREEN}[+]${NC} F3.1 ${GREEN}THIRD-BOUND from dmz_nw${NC} PING TEST${NC}..."
echo -e "${BGREEN}[+]${NC} Pinging elasticsearch from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.2
echo -e "${BGREEN}[+]${NC} Pinging logstash from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.3
echo -e "${BGREEN}[+]${NC} Pinging kibana from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.4
echo -e "${BGREEN}[+]${NC} Pinging heartbeat from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.5
echo -e "${BGREEN}[+]${NC} Pinging metricbeat from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.6
echo -e "${BGREEN}[+]${NC} Pinging packetbeat from dmz1..."
docker exec -it dmz1 ping -c 4 192.168.30.7