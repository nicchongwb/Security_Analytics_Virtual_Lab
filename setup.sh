#!/bin/bash
# This script is meant to be run on the host OS
# Run this after docker compose up
# RUN in root
# ./setup.sh

BLUE="\033[1;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color


# A. Find container network namespace for our containers
echo -e "${BGREEN}\n[+]${NC} A. Setting bash script variables...${NC}"
## A1. Get the container id for each container (will be needed later)
echo -e "${BGREEN}[+]${NC} A1. Setting variables to store container IDs..."

### suitecrm_nw
s1_id=$(docker ps --format "{{.ID}}" --filter name=s1)
echo "s1_id=${s1_id}"
s2_id=$(docker ps --format "{{.ID}}" --filter name=s2)
echo "s2_id=${s2_id}"

### dev_nw
d1_id=$(docker ps --format "{{.ID}}" --filter name=d1)
echo "d1_id=${d1_id}"

### internet_nw - excluding edge routers
k1_id=$(docker ps --format "{{.ID}}" --filter name=k1)
echo "k1_id=${k1_id}"

### dmz_nw - exluding edge routers
dmz1_id=$(docker ps --format "{{.ID}}" --filter name=dmz1)
echo "dmz1_id=${dmz1_id}"

### elk_nw
elasticsearch_id=$(docker ps --format "{{.ID}}" --filter name=elasticsearch)
echo "elasticsearch_id=${elasticsearch_id}"
logstash_id=$(docker ps --format "{{.ID}}" --filter name=logstash)
echo "logstash_id=${logstash_id}"
kibana_id=$(docker ps --format "{{.ID}}" --filter name=kibana)
echo "kibana_id=${kibana_id}"
heartbeat_id=$(docker ps --format "{{.ID}}" --filter name=heartbeat)
echo "heartbeat_id=${heartbeat_id}"
metricbeat_id=$(docker ps --format "{{.ID}}" --filter name=metricbeat)
echo "metricbeat_id=${metricbeat_id}"
packetbeat_id=$(docker ps --format "{{.ID}}" --filter name=packetbeat)
echo "packetbeat_id=${packetbeat_id}"

### routers
r1_id=$(docker ps --format "{{.ID}}" --filter name=r1)
echo "r1_id=${r1_id}"
r2_id=$(docker ps --format "{{.ID}}" --filter name=r2)
echo "r2_id=${r2_id}"
r3_id=$(docker ps --format "{{.ID}}" --filter name=r3)
echo "r3_id=${r3_id}"


## A2. Get the containers pids which will be used to find their network namespace
echo -e "${BGREEN}\n[+]${NC} A2. Setting variables to store container${NC}...${NC}"
### suitecrm_nw
s1_id=$(docker inspect -f "{{.State.Pid}}" ${s1_id})
echo "s1_id=${s1_id}"
s2_id=$(docker inspect -f "{{.State.Pid}}" ${s2_id})
echo "s2_id=${s2_id}"

### dev_nw
d1_id=$(docker inspect -f "{{.State.Pid}}" ${d1_id})
echo "d1_id=${d1_id}"

### internet_nw - excluding edge routers
k1_id=$(docker inspect -f "{{.State.Pid}}" ${k1_id})
echo "k1_id=${k1_id}"

### dmz_nw - exluding edge routers
dmz1_id=$(docker inspect -f "{{.State.Pid}}" ${dmz1_id})
echo "dmz1_id=${dmz1_id}"

### elk_nw
elasticsearch_id=$(docker inspect -f "{{.State.Pid}}" ${elasticsearch_id})
echo "elasticsearch_id=${elasticsearch_id}"
logstash_id=$(docker inspect -f "{{.State.Pid}}" ${logstash_id})
echo "logstash_id=${logstash_id}"
kibana_id=$(docker inspect -f "{{.State.Pid}}" ${kibana_id})
echo "kibana_id=${kibana_id}"
heartbeat_id=$(docker inspect -f "{{.State.Pid}}" ${heartbeat_id})
echo "heartbeat_id=${heartbeat_id}"
metricbeat_id=$(docker inspect -f "{{.State.Pid}}" ${metricbeat_id})
echo "metricbeat_id=${metricbeat_id}"
packetbeat_id=$(docker inspect -f "{{.State.Pid}}" ${packetbeat_id})
echo "packetbeat_id=${packetbeat_id}"

### routers
r1_id=$(docker inspect -f "{{.State.Pid}}" ${r1_id})
echo "r1_id=${r1_id}"
r2_id=$(docker inspect -f "{{.State.Pid}}" ${r2_id})
echo "r2_id=${r2_id}"
r3_id=$(docker inspect -f "{{.State.Pid}}" ${r3_id})
echo "r3_id=${r3_id}"


## A3. Now lets show the ip addresses in each contaiemr namespace
echo -e "${BGREEN}\n[+]${NC} A3. Printing IP addresses of each container...${NC}"
### suitecrm_nw
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}s1${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i s1 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i s1 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}s2${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i s2 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i s2 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

### dev_nw
echo -e "${BGREEN}\n[+]${NC} Running for ${GREEN}d1${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i d1 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i d1 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

### dmz_nw
echo -e "${BGREEN}\n[+]${NC} Running for ${GREEN}dmz1${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i dmz1 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i dmz1 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'


### kali
echo -e "${BGREEN}\n[+]${NC} Running for ${GREEN}k1${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i k1 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i k1 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'


### elk_nw
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}elasticsearch${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i elasticsearch ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i elasticsearch ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}logstash${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i logstash ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i logstash ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}kibana${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i kibana ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i kibana ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}heartbeat${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i heartbeat ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i heartbeat ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}metricbeat${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i metricbeat ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i metricbeat ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}packetbeat${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i packetbeat ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i packetbeat ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

### router
echo -e "${BGREEN}\n[+]${NC} Running for ${GREEN}r1${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i r1 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i r1 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}r2${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i r2 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i r2 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}r3${NC}: printing network interface : IP ${GREEN} ${NC}..."
echo -e "${BLUE}Network Interfaces:${NC}"
docker exec -i r3 ip --oneline addr show | awk '{ print $2 ": " $4 }'
echo -e "${BLUE}Routes:${NC}"
docker exec -i r3 ip route | awk '{ print "ip: " $1 " | default gw: " $9}'


# B. Enabling routing on routers
echo -e "${BGREEN}\n[+]${NC} B. Enabling routing on routers..."

echo -e "${BGREEN}\n[+]${NC} Enabling routing on r1..."
docker exec -i r1 sysctl -w net.ipv4.ip_forward=1
docker exec -i r1 sysctl net.ipv4.ip_forward
echo -e "${BGREEN}\n[+]${NC} Enabling routing on r2..."
docker exec -i r2 sysctl -w net.ipv4.ip_forward=1
docker exec -i r2 sysctl net.ipv4.ip_forward
echo -e "${BGREEN}\n[+]${NC} Enabling routing on r3..."
docker exec -i r3 sysctl -w net.ipv4.ip_forward=1
docker exec -i r3 sysctl net.ipv4.ip_forward

# C. Adding routes on nodes - including routers
echo -e "${BGREEN}\n[+]${NC} C. Adding routes on nodes..."
## ip route add <network/cidr> via <next hop> dev <host network outgoing interface>

## routers - only configure for 2 bound network
### R1
echo -e "r1 --> dmz_nw"
docker exec -i r1 ip route add 10.10.20.0/24 via 172.16.20.2 dev eth1 # r1 --> dmz_nw
echo -e "r1 --> internet_nw"
docker exec -i r1 ip route add 172.16.10.0/24 via 172.16.20.2 dev eth1 # r1 --> internet_nw
echo -e "r1 --> elk_nw"
docker exec -i r1 ip route add 192.168.30.0/24 via 172.16.40.2 dev eth2 # r1 --> elk_nw
### R2
echo -e "r2 --> dev_nw"
docker exec -i r2 ip route add 192.168.10.0/24 via 172.16.20.3 dev eth2 # r2 --> dev_nw
echo -e "r2 --> suitecrm_nw"
docker exec -i r2 ip route add 10.10.10.0/24 via 172.16.20.3 dev eth2 # r2 --> suitecrm_nw
echo -e "r2 --> elk_nw"
docker exec -i r2 ip route add 192.168.30.0/24 via 172.16.20.3 dev eth2 # r2 --> elk_nw
### R3
echo -e "r3 --> suitecrm_nw"
docker exec -i r3 ip route add 10.10.10.0/24 via 172.16.40.3 dev eth1 # r3 --> suitecrm_nw
echo -e "r3 --> dev_nw"
docker exec -i r3 ip route add 192.168.10.0/24 via 172.16.40.3 dev eth1 # r3 --> dev_nw 
echo -e "r3 --> dmz_nw"
docker exec -i r3 ip route add 10.10.20.0/24 via 172.16.40.3 dev eth1 # r3 --> dmz_nw
echo -e "r3 --> internet_nw"
docker exec -i r3 ip route add 172.16.10.0/24 via 172.16.40.3 dev eth1 # r3 --> internet_nw

## dev_nw clients
### D1
echo -e "d1 --> suitecrm_nw via r1"
docker exec -i d1 ip route add 10.10.10.0/24 via 192.168.10.254 dev eth0 # d1 --> suitecrm_nw via r1
echo -e "d1 --> dmz_nw via r1"
docker exec -i d1 ip route add 10.10.20.0/24 via 192.168.10.254 dev eth0 # d1 --> dmz_nw via r1
echo -e "d1 --> elk_nw via r1"
docker exec -i d1 ip route add 192.168.30.0/24 via 192.168.10.254 dev eth0 # d1 --> elk_nw via r1
echo -e "d1 --> r1_r2_nw via r1"
docker exec -i d1 ip route add 172.16.20.0/24 via 192.168.10.254 dev eth0 # d1 --> r1_r2_nw via r1
echo -e "d1 --> r2_r3_nw via r1"
docker exec -i d1 ip route add 172.16.40.0/24 via 192.168.10.254 dev eth0 # d1 --> r2_r3_nw via r1

## suitecrm_nw clients
### S1
echo -e "s1 --> dmz_nw via r1"
docker exec -i s1 ip route add 10.10.20.0/24 via 10.10.10.254 dev eth0 # s1 --> dmz_nw via r1
echo -e "s1 --> dev_nw via r1"
docker exec -i s1 ip route add 192.168.10.0/24 via 10.10.10.254 dev eth0 # s1 --> dev_nw via r1
echo -e "s1 --> elk_nw via r1"
docker exec -i s1 ip route add 192.168.30.0/24 via 10.10.10.254 dev eth0 # s1 --> elk_nw via r1
echo -e "s1 --> internet_nw via r1"
docker exec -i s1 ip route add 172.16.10.0/24 via 10.10.10.254 dev eth0 # s1 --> internet_nw via r1
echo -e "s1 --> r1_r2_nw via r1"
docker exec -i s1 ip route add 172.16.20.0/24 via 10.10.10.254 dev eth0 # s1 --> r1_r2_nw via r1
echo -e "s1 --> r2_r3_nw via r1"
docker exec -i s1 ip route add 172.16.40.0/24 via 10.10.10.254 dev eth0 # s1 --> r2_r3_nw via r1
### S2
echo -e "s2 --> dmz_nw via r1"
docker exec -i s2 ip route add 10.10.20.0/24 via 10.10.10.254 dev eth0 # s2 --> dmz_nw via r1
echo -e "s2 --> dev_nw via r1"
docker exec -i s2 ip route add 192.168.10.0/24 via 10.10.10.254 dev eth0 # s2 --> dev_nw via r1
echo -e "s2 --> elk_nw via r1"
docker exec -i s2 ip route add 192.168.30.0/24 via 10.10.10.254 dev eth0 # s2 --> elk_nw via r1
echo -e "s2 --> internet_nw via r1"
docker exec -i s2 ip route add 172.16.10.0/24 via 10.10.10.254 dev eth0 # s2 --> internet_nw via r1
echo -e "s2 --> r1_r2_nw via r1"
docker exec -i s2 ip route add 172.16.20.0/24 via 10.10.10.254 dev eth0 # s2 --> r1_r2_nw via r1
echo -e "s2 --> r2_r3_nw via r1"
docker exec -i s2 ip route add 172.16.40.0/24 via 10.10.10.254 dev eth0 # s2 --> r2_r3_nw via r1

## dmz_nw clients
### DMZ1
echo -e "dmz1 --> suitecrm_nw via r2"
docker exec -i dmz1 ip route add 10.10.10.0/24 via 10.10.20.254 dev eth0 # dmz1 --> suitecrm_nw via r2
echo -e "dmz1 --> dev_nw via r2"
docker exec -i dmz1 ip route add 192.168.10.0/24 via 10.10.20.254 dev eth0 # dmz1 --> dev_nw via r2
echo -e "dmz1 --> elk_nw via r2"
docker exec -i dmz1 ip route add 192.168.30.0/24 via 10.10.20.254 dev eth0 # dmz1 --> elk_nw via r2
echo -e "dmz1 --> internet_nw via r2"
docker exec -i dmz1 ip route add 172.16.10.0/24 via 10.10.20.254 dev eth0 # dmz1 --> internet_nw via r2
echo -e "dmz1 --> r1_r2_nw via r2"
docker exec -i dmz1 ip route add 172.16.20.0/24 via 10.10.20.254 dev eth0 # dmz1 --> r1_r2_nw via r2
echo -e "dmz1 --> r2_r3_nw via r2"
docker exec -i dmz1 ip route add 172.16.40.0/24 via 10.10.20.254 dev eth0 # dmz1 --> r2_r3_nw via r2

## internet_nw clients
### K1 - in real life, this shouldn't be the case
echo -e "k1 --> dmz_nw via r2"
docker exec -i k1 ip route add 10.10.20.0/24 via 172.16.10.3 dev eth0 # k1 --> dmz_nw via r2
echo -e "k1 --> r1_r2_nw via r2"
docker exec -i k1 ip route add 172.16.20.0/24 via 172.16.10.3 dev eth0 # k1 --> r1_r2_nw via r2

## elk_nw clients
### elasticsearch
echo -e "elasticsearch --> suitecrm_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> suitecrm_nw via r3
echo -e "elasticsearch --> dev_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> dev_nw via r3
echo -e "elasticsearch --> dmz_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> dmz_nw via r3
echo -e "elasticsearch --> internet_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> internet_nw via r3
echo -e "elasticsearch --> r1_r2_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> r1_r2_nw via r3
echo -e "elasticsearch --> r2_r3_nw via r3"
docker exec -u 0 -i elasticsearch ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # elasticsearch --> r2_r3_nw via r3

### logstash
echo -e "logstash --> suitecrm_nw via r3"
docker exec -u 0 -i logstash ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # logstash --> suitecrm_nw via r3
echo -e "logstash --> dev_nw via r3"
docker exec -u 0 -i logstash ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # logstash --> dev_nw via r3
echo -e "logstash --> dmz_nw via r3"
docker exec -u 0 -i logstash ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # logstash --> dmz_nw via r3
echo -e "logstash --> internet_nw via r3"
docker exec -u 0 -i logstash ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # logstash --> internet_nw via r3
echo -e "logstash --> r1_r2_nw via r3"
docker exec -u 0 -i logstash ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # logstash --> r1_r2_nw via r3
echo -e "logstash --> r2_r3_nw via r3"
docker exec -u 0 -i logstash ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # logstash --> r2_r3_nw via r3

### kibana
echo -e "kibana --> suitecrm_nw via r3"
docker exec -u 0 -i kibana ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # kibana --> suitecrm_nw via r3
echo -e "kibana --> dev_nw via r3"
docker exec -u 0 -i kibana ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # kibana --> dev_nw via r3
echo -e "kibana --> dmz_nw via r3"
docker exec -u 0 -i kibana ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # kibana --> dmz_nw via r3
echo -e "kibana --> internet_nw via r3"
docker exec -u 0 -i kibana ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # kibana --> internet_nw via r3
echo -e "kibana --> r1_r2_nw via r3"
docker exec -u 0 -i kibana ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # kibana --> r1_r2_nw via r3
echo -e "kibana --> r2_r3_nw via r3"
docker exec -u 0 -i kibana ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # kibana --> r2_r3_nw via r3


### heartbeat
echo -e "heartbeat --> suitecrm_nw via r3"
docker exec -u 0 -i heartbeat ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # heartbeat --> suitecrm_nw via r3
echo -e "heartbeat --> dev_nw via r3"
docker exec -u 0 -i heartbeat ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # heartbeat --> dev_nw via r3
echo -e "heartbeat --> dmz_nw via r3"
docker exec -u 0 -i heartbeat ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # heartbeat --> dmz_nw via r3
echo -e "heartbeat --> internet_nw via r3"
docker exec -u 0 -i heartbeat ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # heartbeat --> internet_nw via r3
echo -e "heartbeat --> r1_r2_nw via r3"
docker exec -u 0 -i heartbeat ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # heartbeat --> r1_r2_nw via r3
echo -e "heartbeat --> r2_r3_nw via r3"
docker exec -u 0 -i heartbeat ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # heartbeat --> r2_r3_nw via r3

### metricbeat
echo -e "metricbeat --> suitecrm_nw via r3"
docker exec -u 0 -i metricbeat ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # metricbeat --> suitecrm_nw via r3
echo -e "metricbeat --> dev_nw via r3"
docker exec -u 0 -i metricbeat ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # metricbeat --> dev_nw via r3
echo -e "metricbeat --> dmz_nw via r3"
docker exec -u 0 -i metricbeat ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # metricbeat --> dmz_nw via r3
echo -e "metricbeat --> internet_nw via r3"
docker exec -u 0 -i metricbeat ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # metricbeat --> internet_nw via r3
echo -e "metricbeat --> r1_r2_nw via r3"
docker exec -u 0 -i metricbeat ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # metricbeat --> r1_r2_nw via r3
echo -e "metricbeat --> r2_r3_nw via r3"
docker exec -u 0 -i metricbeat ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # metricbeat --> r2_r3_nw via r3

### packetbeat
echo -e "packetbeat --> suitecrm_nw via r3"
docker exec -u 0 -i packetbeat ip route add 10.10.10.0/24 via 192.168.30.254 dev eth0 # packetbeat --> suitecrm_nw via r3
echo -e "packetbeat --> dev_nw via r3"
docker exec -u 0 -i packetbeat ip route add 192.168.10.0/24 via 192.168.30.254 dev eth0 # packetbeat --> dev_nw via r3
echo -e "packetbeat --> dmz_nw via r3"
docker exec -u 0 -i packetbeat ip route add 10.10.20.0/24 via 192.168.30.254 dev eth0 # packetbeat --> dmz_nw via r3
echo -e "packetbeat --> internet_nw via r3"
docker exec -u 0 -i packetbeat ip route add 172.16.10.0/24 via 192.168.30.254 dev eth0 # packetbeat --> internet_nw via r3
echo -e "packetbeat --> r1_r2_nw via r3"
docker exec -u 0 -i packetbeat ip route add 172.16.20.0/24 via 192.168.30.254 dev eth0 # packetbeat --> r1_r2_nw via r3
echo -e "packetbeat --> r2_r3_nw via r3"
docker exec -u 0 -i packetbeat ip route add 172.16.40.0/24 via 192.168.30.254 dev eth0 # packetbeat --> r2_r3_nw via r3

# G. Setup OpenVPN tunnel between c2 and c4 with VPN Pivoting
docker exec d1 openvpn --genkey --secret static-OpenVPN.key
docker exec d1 bash -c 'echo -e "mode p2p\ndev tun\nport 1194\nproto tcp-server\nifconfig 172.16.30.1 172.16.30.2\nsecret ../../static-OpenVPN.key\n;user nobody\n;group nobody\n\nkeepalive 10 60\nping-timer-rem\npersist-tun\npersist-key\n\ncomp-lzo" > /etc/openvpn/server.conf'
docker exec d1 bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'
docker exec d1 ufw allow from any to any port 1194 proto tcp
docker exec d1 iptables -t nat -A POSTROUTING -s 172.16.30.2 -o eth0 -j MASQUERADE
docker exec k1 bash -c 'echo -e "mode p2p\nremote 172.16.10.4\ndev tun\nport 1194\nproto tcp-client\nifconfig 172.16.30.2 172.16.30.1\nsecret ../../static-OpenVPN.key\ncomp-lzo\nroute 0.0.0.0 0.0.0.0 172.16.30.1" > /etc/openvpn/client.conf'
docker cp d1:/static-OpenVPN.key /home
docker cp /home/static-OpenVPN.key k1:/
docker exec -dit d1 openvpn --config /etc/openvpn/server.conf 
docker exec -dit k1 openvpn --config /etc/openvpn/client.conf
docker exec k1 route del default

# #Setting filebeat on D1
# docker exec d1 bash -c 'echo "#! /bin/bash" > editfilebeat.sh'
# docker exec d1 bash -c 'echo "sed -i \"43 i - type: log\n  enabled: true\n  paths:\n    - /var/log/btmp\n  tags: [\\\"faillog\\\"]\" /etc/filebeat/filebeat.yml" >> editfilebeat.sh'
# docker exec d1 bash -c 'echo "sed -i \"48 i - type: log\n  enabled: true\n  paths:\n    - /var/log/wtmp\n  tags: [\\\"lastlog\\\"]\" /etc/filebeat/filebeat.yml" >> editfilebeat.sh'
# docker exec d1 bash -c 'chmod +x editfilebeat.sh'
# docker exec d1 bash -c './editfilebeat.sh'
