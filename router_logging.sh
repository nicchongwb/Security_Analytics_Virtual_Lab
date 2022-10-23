#!/bin/bash
# R1
docker exec r1 mkdir -p /var/log/tcpdump
docker exec r1 tcpdump -i eth0 -nn -w /var/log/tcpdump/r1-eth0.pcap &
docker exec r1 tcpdump -i eth1 -nn -w /var/log/tcpdump/r1-eth1.pcap &
docker exec r1 tcpdump -i eth2 -nn -w /var/log/tcpdump/r1-eth2.pcap &
docker exec r1 tcpdump -i eth3 -nn -w /var/log/tcpdump/r1-eth3.pcap &
# R2
docker exec r2 mkdir -p /var/log/tcpdump
docker exec r2 tcpdump -i eth0 -nn -w /var/log/tcpdump/r2-eth0.pcap &
docker exec r2 tcpdump -i eth1 -nn -w /var/log/tcpdump/r2-eth1.pcap &
docker exec r2 tcpdump -i eth2 -nn -w /var/log/tcpdump/r2-eth2.pcap &
# R3
docker exec r3 mkdir -p /var/log/tcpdump
docker exec r3 tcpdump -i eth0 -nn -w /var/log/tcpdump/r3-eth0.pcap &
docker exec r3 tcpdump -i eth1 -nn -w /var/log/tcpdump/r3-eth1.pcap &
