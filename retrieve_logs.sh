#!/bin/bash
# PCAP
## R1
docker cp r1:/var/log/tcpdump/r1-eth0.pcap /vagrant/logs
docker cp r1:/var/log/tcpdump/r1-eth1.pcap /vagrant/logs
docker cp r1:/var/log/tcpdump/r1-eth2.pcap /vagrant/logs
docker cp r1:/var/log/tcpdump/r1-eth3.pcap /vagrant/logs
## R2
docker cp r2:/var/log/tcpdump/r2-eth0.pcap /vagrant/logs
docker cp r2:/var/log/tcpdump/r2-eth1.pcap /vagrant/logs
docker cp r2:/var/log/tcpdump/r2-eth2.pcap /vagrant/logs
## R3
docker cp r3:/var/log/tcpdump/r3-eth0.pcap /vagrant/logs
docker cp r3:/var/log/tcpdump/r3-eth1.pcap /vagrant/logs