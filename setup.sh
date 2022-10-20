#!/bin/bash
# This script is meant to be run on the host OS
# RUN in root
# ./setup.sh

RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color


echo -e "${BGREEN}\n[+]${NC} Prunning all docker volumes...${NC}"
yes | docker volume prune
echo -e "${BGREEN}\n[+]${NC} Prunning all docker containers...${NC}"
yes | docker container prune # Prune all container before hand
echo -e "${BGREEN}\n[+]${NC} Prunning all docker networks...${NC}"
yes | docker network prune # Prune all network before hand
## Do not uncomment this - it will remove all the builder cache which will cause the rebuilding/building images to be long
# echo -e "${BGREEN}\n[+]${NC} Prunning all docker builder cache...${NC}"
# yes | docker builder prune # Prune all builder before hand

# # 0. Build images
echo -e "${BGREEN}\n[+]${NC} Building ubuntu-network image...${NC}"
docker build -t ubuntu-network -f /vagrant/Dockerfile.ubuntu-network /vagrant/
echo -e "${BGREEN}\n[+]${NC} Building kali image...${NC}" 
docker build -t kali -f /vagrant/Dockerfile.kali /vagrant/
echo -e "${BGREEN}\n[+]${NC} Building suitecrm-server image...${NC}"
docker build -t suitecrm-server -f /vagrant/Dockerfile.suitecrm-server /vagrant/
# # # 0. Build ELK Stack Containers
echo -e "${BGREEN}\n[+]${NC} Building elasticsearch image...${NC}"
docker build -t elasticsearch -f /vagrant/Dockerfile.elastic /vagrant/
echo -e "${BGREEN}\n[+]${NC} Building logstash image...${NC}"
docker build -t logstash -f /vagrant/Dockerfile.logstash /vagrant/
echo -e "${BGREEN}\n[+]${NC} Building kibana image...${NC}"
docker build -t kibana -f /vagrant/Dockerfile.kibana /vagrant/

# 0. Docker compose up -d
echo -e "\n${BGREEN}[+]${NC} Running docker compose up -d --build.."
docker compose -f /vagrant/docker-compose.yaml up -d --build
echo -e "${BGREEN}[+]${NC} Docker compose up!${NC}"


# A. Find container network namespace for our containers
echo -e "${BGREEN}\n[+]${NC} A. Setting bash script variables...${NC}"
# A1. Get the container id for each container (will be needed later)
echo -e "${BGREEN}[+]${NC} A1. Setting variables: c1_id, c2_id, c3_id, c4_id, r1_id, r2_id to store container IDs..."
c1_id=$(docker ps --format "{{.ID}}" --filter name=c1)
echo "c1_id=${c1_id}"
c2_id=$(docker ps --format "{{.ID}}" --filter name=c2)
echo "c2_id=${c2_id}"
c3_id=$(docker ps --format "{{.ID}}" --filter name=c3)
echo "c3_id=${c3_id}"
c4_id=$(docker ps --format "{{.ID}}" --filter name=c4)
echo "c4_id=${c4_id}"
c5_id=$(docker ps --format "{{.ID}}" --filter name=c5)
echo "c5_id=${c5_id}"
c6_id=$(docker ps --format "{{.ID}}" --filter name=c6)
echo "c6_id=${c6_id}"
r1_id=$(docker ps --format "{{.ID}}" --filter name=r1)
echo "r1_id=${r1_id}"
r2_id=$(docker ps --format "{{.ID}}" --filter name=r2)
echo "r2_id=${r2_id}"
r3_id=$(docker ps --format "{{.ID}}" --filter name=r3)
echo "r2_id=${r3_id}"

# A2. Get the containers pids which will be used to find their network namespace
echo -e "${BGREEN}\n[+]${NC} A2. Setting variables: c1_pid, c2_pid, c3_pid, c4_pid, c5_pid, c6_pid, r1_pid, r2_pid to store container${NC}...${NC}"
c1_pid=$(docker inspect -f "{{.State.Pid}}" ${c1_id})
echo "c1_pid=${c1_pid}"
c2_pid=$(docker inspect -f "{{.State.Pid}}" ${c2_id})
echo "c2_pid=${c2_pid}"
c3_pid=$(docker inspect -f "{{.State.Pid}}" ${c3_id})
echo "c3_pid=${c3_pid}"
c4_pid=$(docker inspect -f "{{.State.Pid}}" ${c4_id})
echo "c4_pid=${c4_pid}"
c5_pid=$(docker inspect -f "{{.State.Pid}}" ${c5_id})
echo "c5_pid=${c5_pid}"
c6_pid=$(docker inspect -f "{{.State.Pid}}" ${c6_id})
echo "c6_pid=${c6_pid}"
r1_pid=$(docker inspect -f "{{.State.Pid}}" ${r1_id})
echo "r1_pid=${r1_pid}"
r2_pid=$(docker inspect -f "{{.State.Pid}}" ${r2_id})
echo "r2_pid=${r2_pid}"
r3_pid=$(docker inspect -f "{{.State.Pid}}" ${r3_id})
echo "r3_pid=${r3_pid}"

# A3. create the /var/run/netns/ path if it doesn"t already exist
echo -e "${BGREEN}\n[+]${NC} A3. Making Dir /var/run/netns if not exist...${NC}"
mkdir -p /var/run/netns/

# A4. Create a soft link to the containers network namespace to /var/run/netns/
echo -e "${BGREEN}\n[+]${NC} A4. Creating soft link to the containers network namespace to /var/run/netns...${NC}"
ln -sfT /proc/$c1_pid/ns/net /var/run/netns/$c1_id
ln -sfT /proc/$c2_pid/ns/net /var/run/netns/$c2_id
ln -sfT /proc/$c3_pid/ns/net /var/run/netns/$c3_id
ln -sfT /proc/$c4_pid/ns/net /var/run/netns/$c4_id
ln -sfT /proc/$c5_pid/ns/net /var/run/netns/$c5_id
ln -sfT /proc/$c6_pid/ns/net /var/run/netns/$c6_id
ln -sfT /proc/$r1_pid/ns/net /var/run/netns/$r1_id
ln -sfT /proc/$r2_pid/ns/net /var/run/netns/$r2_id
ln -sfT /proc/$r3_pid/ns/net /var/run/netns/$r3_id

# A5. Now lets show the ip addresses in each contaiemr namespace
echo -e "${BGREEN}\n[+]${NC} A5. Printing IP addresses ofs each container...${NC}"
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c1${NC}: ip netns exec $c1_id ${GREEN} ip a${NC}..."
ip netns exec $c1_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c2${NC}: ip netns exec $c2_id ${GREEN} ip a${NC}..."
ip netns exec $c2_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c3${NC}: ip netns exec $c3_id ${GREEN} ip a${NC}..."
ip netns exec $c3_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c4${NC}: ip netns exec $c4_id ${GREEN} ip a${NC}..."
ip netns exec $c4_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c5${NC}: ip netns exec $c5_id ${GREEN} ip a${NC}..."
ip netns exec $c5_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}c6${NC}: ip netns exec $c6_id ${GREEN} ip a${NC}..."
ip netns exec $c6_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}r1${NC}: ip netns exec $r1_id ${GREEN} ip a${NC}..."
ip netns exec $r1_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}r2${NC}: ip netns exec $r2_id ${GREEN} ip a${NC}..."
ip netns exec $r2_id ip a
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}r3${NC}: ip netns exec $r3_id ${GREEN} ip a${NC}..."
ip netns exec $r3_id ip a


# B. Create virtual ethernet interfaces and assign them to the containers
echo -e "${BGREEN}\n[+]${NC} B. Creating and assigning virtual ethernet interfaces to containers...${NC}"
# B1. Create the virtual ethernet devices for connecting C1 to R1
echo -e "${BGREEN}[+]${NC} B1. Creating r1-eth0 interface for ${GREEN}connecting C1 to R1${NC}..."
ip link add "c1-eth0" type veth peer name "r1-eth0"

## Create the virtual ethernet devices for connecting C2 to R1
echo -e "${BGREEN}[+]${NC} Creating r1-eth1 interface for ${GREEN}connecting C2 to R1${NC}..."
ip link add "c2-eth0" type veth peer name "r1-eth1"

## Create the virtual ethernet devices for connecting C4 to R2
echo -e "${BGREEN}[+]${NC} Creating r2-eth0 interface for ${GREEN}connecting C4 to R2${NC}..."
ip link add "c4-eth0" type veth peer name "r2-eth0"

## Create the virtual ethernet devices for connecting R1 to R2
echo -e "${BGREEN}[+]${NC} Creating r2-eth1 interface for ${GREEN}connecting R1 to R2${NC}..."
ip link add "r1-eth3" type veth peer name "r2-eth1"

## Create the virtual ethernet devices for connecting R1 to R3
echo -e "${BGREEN}[+]${NC} Creating r3-eth0 interface for ${GREEN}connecting R1 to R3${NC}..."
ip link add "r1-eth2" type veth peer name "r3-eth0"


# B2. Moving virtual interfaces from host network namespace to corresponding containers namespace
## move c1 interface to c1 container
echo -e "\n${BGREEN}[+]${NC} B2. Moving ${GREEN}c1-eth0 to c1${NC} container${NC}..."
ip link set "c1-eth0" netns $c1_id

## move c2 interface to c2 container
echo -e "${BGREEN}[+]${NC} Moving ${GREEN}c2-eth0 to c2${NC} container..."
ip link set "c2-eth0" netns $c2_id

## move c4 interface to c4 container
echo -e "${BGREEN}[+]${NC} Moving ${GREEN}c4-eth0 to c4${NC} container..."
ip link set "c4-eth0" netns $c4_id

## move r1-eth0,1,2,3 to r1 container
echo -e "${BGREEN}[+]${NC} Moving ${GREEN}r1-eth0,1 to r1${NC} container..."
ip link set "r1-eth0" netns $r1_id
ip link set "r1-eth1" netns $r1_id
ip link set "r1-eth2" netns $r1_id
ip link set "r1-eth3" netns $r1_id

## move r2-eth0,1 to r2 container
echo -e "${BGREEN}[+]${NC} Moving ${GREEN}r2-eth0,1 to r2${NC} container..."
ip link set "r2-eth0" netns $r2_id
ip link set "r2-eth1" netns $r2_id

## move r3-eth0 to r3 container
echo -e "${BGREEN}[+]${NC} Moving ${GREEN}r3-eth0 to r3${NC} container..."
ip link set "r3-eth0" netns $r3_id

# B3. Rename interfaces in containers
### rename c1 container interface from c1-eth0 to eth0
echo -e "\n${BGREEN}[+]${NC} B3. Renaming c1 container interface from ${GREEN}c1-eth0 to eth0${NC}..."
ip netns exec $c1_id ip link set "c1-eth0" name "eth0"

### rename c2 container interface form c2-eth0 to eth0
echo -e "${BGREEN}[+]${NC} Renaming c2 container interface from ${GREEN}c2-eth0 to eth0${NC}..."
ip netns exec $c2_id ip link set "c2-eth0" name "eth0"

### rename c4 container interface form c4-eth0 to eth0
echo -e "${BGREEN}[+]${NC} Renaming c4 container interface from ${GREEN}c4-eth0 to eth0${NC}..."
ip netns exec $c4_id ip link set "c4-eth0" name "eth0"

### rename r1 container interfaces from r1-eth0 to eth0 and r1-eth1 to eth1, and for eth2 && eth3
echo -e "${BGREEN}[+]${NC} Renaming r1 container interface from ${GREEN}r1-eth0 to eth0${NC}..."
ip netns exec $r1_id ip link set "r1-eth0" name "eth0"
echo -e "${BGREEN}[+]${NC} Renaming r1 container interface from ${GREEN}r1-eth1 to eth1${NC}..."
ip netns exec $r1_id ip link set "r1-eth1" name "eth1"
echo -e "${BGREEN}[+]${NC} Renaming r1 container interface from ${GREEN}r1-eth2 to eth2${NC}..."
ip netns exec $r1_id ip link set "r1-eth2" name "eth2"
echo -e "${BGREEN}[+]${NC} Renaming r1 container interface from ${GREEN}r1-eth3 to eth3${NC}..."
ip netns exec $r1_id ip link set "r1-eth3" name "eth3"

### rename r2 container interfaces from r2-eth0 to eth0 and r2-eth1 to eth1
echo -e "${BGREEN}[+]${NC} Renaming r2 container interface from ${GREEN}r2-eth0 to eth0${NC}..."
ip netns exec $r2_id ip link set "r2-eth0" name "eth0"
echo -e "${BGREEN}[+]${NC} Renaming r2 container interface from ${GREEN}r2-eth1 to eth1${NC}..."
ip netns exec $r2_id ip link set "r2-eth1" name "eth1"

### rename r3 container interfaces from r3-eth0 to eth0
echo -e "${BGREEN}[+]${NC} Renaming r3 container interface from ${GREEN}r3-eth0 to eth1${NC}..."
ip netns exec $r3_id ip link set "r3-eth0" name "eth1"


# B4. Bring up all interfaces in containers
## At the end of this, all containers should have network
## interfaces set in them and linked together directly with no bridge in between
echo -e "${BGREEN}\n[+]${NC} B4. Bringing up all interfaces in containers...${NC}"
ip netns exec $c1_id ip link set "eth0" up
echo -e "${BGREEN}[+]${NC} c1 eth0 up!"
ip netns exec $c1_id ip link set "lo" up
echo -e "${BGREEN}[+]${NC} c1 lo up!"

ip netns exec $c2_id ip link set "eth0" up
echo -e "${BGREEN}\n[+]${NC} c2 eth0"
ip netns exec $c2_id ip link set "lo" up
echo -e "${BGREEN}[+]${NC} c2 lo up!"

ip netns exec $c4_id ip link set "eth0" up
echo -e "${BGREEN}\n[+]${NC} c4 eth0"
ip netns exec $c4_id ip link set "lo" up
echo -e "${BGREEN}[+]${NC} c4 lo up!"

ip netns exec $r1_id ip link set "eth0" up
echo -e "${BGREEN}\n[+]${NC} r1 eth0"
ip netns exec $r1_id ip link set "eth1" up
echo -e "${BGREEN}[+]${NC} r1 eth1 up!"
ip netns exec $r1_id ip link set "eth2" up
echo -e "${BGREEN}[+]${NC} r1 eth2 up!"
ip netns exec $r1_id ip link set "eth3" up
echo -e "${BGREEN}[+]${NC} r1 eth3 up!"
ip netns exec $r1_id ip link set "lo" up
echo -e "${BGREEN}[+]${NC} r1 lo up!"

ip netns exec $r2_id ip link set "eth0" up
echo -e "${BGREEN}\n[+]${NC} r2 eth0"
ip netns exec $r2_id ip link set "eth1" up
echo -e "${BGREEN}[+]${NC} r2 eth1 up!"
ip netns exec $r2_id ip link set "lo" up
echo -e "${BGREEN}[+]${NC} r2 lo up!"

ip netns exec $r3_id ip link set "eth1" up
echo -e "${BGREEN}\n[+]${NC} r3 eth1"


# C. Setting IP and Routes on the containers
echo -e "${BGREEN}\n[+]${NC} C. Setting IP and Routes on the containers...${NC}"
## Set c1 container ip to 10.10.10.2
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}c1${NC} container ip to ${GREEN}10.10.10.2${NC}..."
ip netns exec $c1_id ip addr add 10.10.10.2/24 dev eth0

## Set c2 container ip to 192.168.10.2
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}c2${NC} container ip to ${GREEN}192.168.10.2${NC}..."
ip netns exec $c2_id ip addr add 192.168.10.2/24 dev eth0

## Set c4 container ip to 172.16.10.2
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}c4${NC} container ip to ${GREEN}172.16.10.2${NC}..."
ip netns exec $c4_id ip addr add 172.16.10.2/24 dev eth0

## Set r1 ips to 10.10.10.1 and 192.168.10.1
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}r1${NC} container ip to ${GREEN}10.10.10.2, 192.168.10.1, 192.168.20.1, 172.16.20.1${NC}..."
ip netns exec $r1_id ip addr add 10.10.10.1/24 dev eth0
ip netns exec $r1_id ip addr add 192.168.10.1/24 dev eth1
ip netns exec $r1_id ip addr add 192.168.20.1/24 dev eth2
ip netns exec $r1_id ip addr add 172.16.20.1/24 dev eth3

## Set r2 ips to 172.16.10.1 and 172.168.20.1
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}r2${NC} container ip to ${GREEN}172.16.10.1, 172.168.20.2${NC}..."
ip netns exec $r2_id ip addr add 172.16.10.1/24 dev eth0
ip netns exec $r2_id ip addr add 172.16.20.2/24 dev eth1

## Set r3 ips to 192.168.20.2
echo -e "${BGREEN}[+]${NC} Setting ${GREEN}r3${NC} container ip to ${GREEN}192.168.20.2${NC}..."
ip netns exec $r3_id ip addr add 192.168.20.2/24 dev eth1


# D. Setting default gateways
echo -e "${BGREEN}\n[+]${NC} D. Setting default gateways...${NC}"
## set default gw for c1 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c1 to r1${NC}..."
ip netns exec $c1_id ip route add default via 10.10.10.1 dev eth0

## set default gw for c2 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c2 to r1${NC}..."
ip netns exec $c2_id ip route add default via 192.168.10.1 dev eth0

## set default gw for c3 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c3 to r3${NC}..."
ip netns exec $c3_id ip route replace default via 192.168.30.2 dev eth0

## set default gw for c4 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c4 to r2${NC}..."
ip netns exec $c4_id ip route add default via 172.16.10.1 dev eth0

## set default gw for c5 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c5 to r3${NC}..."
ip netns exec $c5_id ip route replace default via 192.168.30.2 dev eth0

## set default gw for c6 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}c6 to r3${NC}..."
ip netns exec $c6_id ip route replace default via 192.168.30.2 dev eth0

## set default gw for r1 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}r1 to r2${NC}..."
ip netns exec $r1_id ip route add default via 172.16.20.2 dev eth3
echo -e "${BGREEN}[+]${NC} Setting route on ${GREEN}r1 to r3${NC}..."
ip netns exec $r1_id ip route add 192.168.30.0/24 via 192.168.20.2 dev eth2

## set default gw for r2 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}r2 to r1${NC}..."
ip netns exec $r2_id ip route add default via 172.16.20.1 dev eth1
echo -e "${BGREEN}[+]${NC} Setting route on ${GREEN}r2 to r3${NC}..."
ip netns exec $r1_id ip route add 192.168.30.0/24 via 172.16.20.1 dev eth1

## set default gw for r3 container
echo -e "${BGREEN}[+]${NC} Set default gateway on ${GREEN}r3 to r1${NC}..."
ip netns exec $r3_id ip route replace default via 192.168.20.1 dev eth1


# E. Printing Routes of Containers
echo -e "${BGREEN}\n[+]${NC} A5. Printing IP addresses ofs each container...${NC}"
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C1${NC}: ip netns exec $c1_id ${GREEN}ip route${NC}..."
ip netns exec $c1_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C2${NC}: ip netns exec $c2_id ${GREEN}ip route${NC}..."
ip netns exec $c2_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C4${NC}: ip netns exec $c4_id ${GREEN}ip route${NC}..."
ip netns exec $c4_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}R1${NC}: ip netns exec $r1_id ${GREEN}ip route${NC}..."
ip netns exec $r1_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}R2${NC}: ip netns exec $r2_id ${GREEN}ip route${NC}..."
ip netns exec $r2_id ip route

echo -e "${BGREEN}[+]${NC} Running for ${GREEN}R3${NC}: ip netns exec $r3_id ${GREEN}ip route${NC}..."
ip netns exec $r3_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C3${NC}: ip netns exec $c3_id ${GREEN}ip route${NC}..."
ip netns exec $c3_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C5${NC}: ip netns exec $c5_id ${GREEN}ip route${NC}..."
ip netns exec $c5_id ip route
echo -e "${BGREEN}[+]${NC} Running for ${GREEN}C6${NC}: ip netns exec $c6_id ${GREEN}ip route${NC}..."
ip netns exec $c6_id ip route

# F. Ping test - takes some time
chmod +x /vagrant/ping_test.sh
## Uncomment the cmd below or manually run the ping test via
## sudo ./ping_test.sh
# ./ping_test.sh

# G. Setup OpenVPN tunnel between c2 and c4 with VPN Pivoting
docker exec -it c2 openvpn --genkey --secret static-OpenVPN.key
docker exec -it c2 echo -e "mode p2p\ndev tun\nport 1194\nproto tcp-server\nifconfig 172.16.30.1 172.16.30.2\nsecret ../../static-OpenVPN.key\n;user nobody\n;group nobody\n\nkeepalive 10 60\nping-timer-rem\npersist-tun\npersist-key\n\ncomp-lzo" > /etc/openvpn/server.conf
docker exec -it c2 echo 1 > /proc/sys/net/ipv4/ip_forward
docker exec -it c2 ufw allow from any to any port 1194 proto tcp
docker exec -it c2 iptables -t nat -A POSTROUTING -s 172.16.30.2 -o eth0 -j MASQUERADE
docker exec -it c4 echo -e "mode p2p\nremote 192.168.10.2\ndev tun\nport 1194\nproto tcp-client\nifconfig 172.16.30.2 172.16.30.1\nsecret ../../static-OpenVPN.key\ncomp-lzo\nroute-metric 15\nroute 192.168.10.0 255.255.255.0 172.16.10.1" > /etc/openvpn/client.conf
docker cp c2:/static-OpenVPN.key /home/kali/Desktop
docker cp /home/kali/Desktop/static-OpenVPN.key c4:/
docker exec -it c2 openvpn --config /etc/openvpn/server.conf &
docker exec -it c4 openvpn --config /etc/openvpn/client.conf &
