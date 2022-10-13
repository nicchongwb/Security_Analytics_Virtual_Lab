#!/bin/bash
# This script is meant to be run on the host OS
# Prerequisites:
# 	- docker compose up -d
#	- sudo ./network_setup.sh

# A. Find container network namespace for our containers
## Get the container id for each container (will be needed later)
echo '[+] Setting variables: c1_id, c2_id, r1_id to store container IDs...'
c1_id=$(docker ps --format '{{.ID}}' --filter name=c1)
echo "c1_id=${c1_id}"
c2_id=$(docker ps --format '{{.ID}}' --filter name=c2)
echo "c2_id=${c2_id}"
r1_id=$(docker ps --format '{{.ID}}' --filter name=r1)
echo "r1_id=${r1_id}"


## Get the containers pids which will be used to find their network namespace
echo '[+] Setting variables: c1_pid, c2_pid, r1_pid to store container PIDs...'
c1_pid=$(docker inspect -f '{{.State.Pid}}' ${c1_id})
echo "c1_pid=${c1_pid}"
c2_pid=$(docker inspect -f '{{.State.Pid}}' ${c2_id})
echo "c2_pid=${c2_pid}"
r1_pid=$(docker inspect -f '{{.State.Pid}}' ${r1_id})
echo "r1_pid=${r1_pid}"

## create the /var/run/netns/ path if it doesn't already exist
echo '[+] Making Dir /var/run/netns if not exist...'
mkdir -p /var/run/netns/


## Create a soft link to the containers network namespace to /var/run/netns/
echo '[+] Creating soft link to the containers network namespace to /var/run/netns...'
ln -sfT /proc/$c1_pid/ns/net /var/run/netns/$c1_id
ln -sfT /proc/$c2_pid/ns/net /var/run/netns/$c2_id
ln -sfT /proc/$r1_pid/ns/net /var/run/netns/$r1_id

## Now lets show the ip addresses in each contaier namespace
echo '[+] Running: ip netns exec $c1_id ip a...'
ip netns exec $c1_id ip a
echo '[+] Running: ip netns exec $c2_id ip a...'
ip netns exec $c2_id ip a
echo '[+] Running: ip netns exec $r1_id ip a...'
ip netns exec $r1_id ip a


# B. Create virtual ethernet interfaces and assign them to the containers

## Create the virtual ethernet devices for connecting C1 to R1
echo '[+] Creating r1-eth0 interface for connecting C1 to R1...'
ip link add 'c1-eth0' type veth peer name 'r1-eth0'

## Create the virtual ethernet devices for connecting C2 to R1
echo '[+] Creating r1-eth1 interface for connecting C2 to R1...'
ip link add 'c2-eth0' type veth peer name 'r1-eth1'

## Moving virtual interfaces from host network namespace to corresponding containers namespace

### move c1 interface to c1 container
echo '[+] Moving c1-eth0 to c1 container...'
ip link set 'c1-eth0' netns $c1_id

### move r1-eth0,1 to r1 container
echo '[+] Moving r1-eth0,1 to r1 container...'
ip link set 'r1-eth0' netns $r1_id
ip link set 'r1-eth1' netns $r1_id

### move c2 interface to c2 container
echo '[+] Moving c2-eth0 to c2 container...'
ip link set 'c2-eth0' netns $c2_id

## Rename interfaces in containers
### rename c1 container interface from c1-eth0 to eth0
echo '[+] Renaming c1 container interface from c1-eth0 to eth0...'
ip netns exec $c1_id ip link set 'c1-eth0' name 'eth0'

### rename r1 container interfaces from r1-eth0 to eth0 and r1-eth1 to eth1
echo '[+] Renaming r1 container interface from r1-eth0 to eth0...'
ip netns exec $r1_id ip link set 'r1-eth0' name 'eth0'
echo '[+] Renaming r1 container interface from r1-eth1 to eth1...'
ip netns exec $r1_id ip link set 'r1-eth1' name 'eth1'

### rename c2 container interface form c2-eth0 to eth0
echo '[+] Renaming c2 container interface from c2-eth0 to eth0...'
ip netns exec $c2_id ip link set 'c2-eth0' name 'eth0'

## bring up all interfaces in containers
echo '[+] Bringing up all interfaces in containers...'
ip netns exec $c1_id ip link set 'eth0' up
ip netns exec $c1_id ip link set 'lo' up
ip netns exec $r1_id ip link set 'eth0' up
ip netns exec $r1_id ip link set 'eth1' up
ip netns exec $r1_id ip link set 'lo' up
ip netns exec $c2_id ip link set 'eth0' up
ip netns exec $c2_id ip link set 'lo' up

### All containers should have network interfaces set in them and linked together directly with no bridge in between


# C. Setting IP and Routes on the containers
## Set c1 container ip to 10.10.10.2
echo '[+] Set c1 container ip to 10.10.10.2...'
ip netns exec $c1_id ip addr add 10.10.10.2/24 dev eth0

## Set r1 ips to 10.10.10.1 and 192.168.11.1
echo '[+] Set r1 container ip to 10.10.10.2 and 192.168.11.1...'
ip netns exec $r1_id ip addr add 10.10.10.1/24 dev eth0
ip netns exec $r1_id ip addr add 192.168.11.1/24 dev eth1

## Set c2 container ip to 192.168.11.2
echo '[+] Set c2 container ip to 192.168.11.2...'
ip netns exec $c2_id ip addr add 192.168.11.2/24 dev eth0

# D. Setting default gateways
# set default gw on c1 container
echo '[+] Set default gateway on c1...'
ip netns exec $c1_id ip route add default via 10.10.10.1 dev eth0

# set default gw on c2 container
echo '[+] Set default gateway on c2...'
ip netns exec $c2_id ip route add default via 192.168.11.1 dev eth0

# E. Test ping
echo '[+] Pinging r1 from c1...'
docker exec -it c2 ping -c 4 192.168.11.1

echo '[+] Pinging r1 from c2...'
docker exec -it c1 ping -c 4 192.168.11.2

echo '[+] Pinging c2 from c1...'
docker exec -it c1 ping -c 4 192.168.11.2
