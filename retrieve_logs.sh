#!/bin/bash
# # PCAP
# ## R1
mkdir -p /vagrant/logs/pcap
docker cp r1:/var/log/tcpdump/r1-eth0.pcap /vagrant/logs/pcap/
docker cp r1:/var/log/tcpdump/r1-eth1.pcap /vagrant/logs/pcap/
docker cp r1:/var/log/tcpdump/r1-eth2.pcap /vagrant/logs/pcap/
docker cp r1:/var/log/tcpdump/r1-eth3.pcap /vagrant/logs/pcap/
## R2
docker cp r2:/var/log/tcpdump/r2-eth0.pcap /vagrant/logs/pcap/
docker cp r2:/var/log/tcpdump/r2-eth1.pcap /vagrant/logs/pcap/
docker cp r2:/var/log/tcpdump/r2-eth2.pcap /vagrant/logs/pcap/
## R3
docker cp r3:/var/log/tcpdump/r3-eth0.pcap /vagrant/logs/pcap/
docker cp r3:/var/log/tcpdump/r3-eth1.pcap /vagrant/logs/pcap/

## access.log
mkdir -p /vagrant/logs/access_log
docker cp d1:/var/log/apache2/access.log /vagrant/logs/access_log/d1_access.log
docker cp s1:/var/log/apache2/access.log /vagrant/logs/access_log/s1_access.log
docker cp s2:/var/log/apache2/access.log /vagrant/logs/access_log/s2_access.log
docker cp dmz1:/var/log/apache2/access.log /vagrant/logs/access_log/dmz1_access.log
docker cp r1:/var/log/apache2/access.log /vagrant/logs/access_log/r1_access.log
docker cp r2:/var/log/apache2/access.log /vagrant/logs/access_log/r2_access.log
docker cp r3:/var/log/apache2/access.log /vagrant/logs/access_log/r3_access.log

## syslog
mkdir -p /vagrant/logs/syslog/
docker cp d1:/var/log/syslog /vagrant/logs/syslog/d1_syslog
docker cp s1:/var/log/syslog /vagrant/logs/syslog/s1_syslog
docker cp s2:/var/log/syslog /vagrant/logs/syslog/s2_syslog
docker cp dmz1:/var/log/syslog /vagrant/logs/syslog/dmz1_syslog
docker cp r1:/var/log/syslog /vagrant/logs/syslog/r1_syslog
docker cp r2:/var/log/syslog /vagrant/logs/syslog/r2_syslog
docker cp r3:/var/log/syslog /vagrant/logs/syslog/r3_syslog

## authlog
mkdir -p /vagrant/logs/authlog/
docker cp d1:/var/log/auth.log /vagrant/logs/authlog/d1_auth.log
docker cp s1:/var/log/auth.log /vagrant/logs/authlog/s1_auth.log
docker cp s2:/var/log/auth.log /vagrant/logs/authlog/s2_auth.log
docker cp dmz1:/var/log/auth.log /vagrant/logs/authlog/dmz1_auth.log
docker cp r1:/var/log/auth.log /vagrant/logs/authlog/r1_auth.log
docker cp r2:/var/log/auth.log /vagrant/logs/authlog/r2_auth.log
docker cp r3:/var/log/auth.log /vagrant/logs/authlog/r3_auth.log

## btmp
mkdir -p /vagrant/logs/btmp/
docker cp d1:/var/log/btmp /vagrant/logs/btmp/d1_btmp
docker cp s1:/var/log/btmp /vagrant/logs/btmp/s1_btmp
docker cp s2:/var/log/btmp /vagrant/logs/btmp/s2_btmp
docker cp dmz1:/var/log/btmp /vagrant/logs/btmp/dmz1_btmp
docker cp r1:/var/log/btmp /vagrant/logs/btmp/r1_btmp
docker cp r2:/var/log/btmp /vagrant/logs/btmp/r2_btmp
docker cp r3:/var/log/btmp /vagrant/logs/btmp/r3_btmp

## wtmp
mkdir -p /vagrant/logs/wtmp/
docker cp d1:/var/log/wtmp /vagrant/logs/wtmp/d1_wtmp
docker cp s1:/var/log/wtmp /vagrant/logs/wtmp/s1_wtmp
docker cp s2:/var/log/wtmp /vagrant/logs/wtmp/s2_wtmp
docker cp dmz1:/var/log/wtmp /vagrant/logs/wtmp/dmz1_wtmp
docker cp r1:/var/log/wtmp /vagrant/logs/wtmp/r1_wtmp
docker cp r2:/var/log/wtmp /vagrant/logs/wtmp/r2_wtmp
docker cp r3:/var/log/wtmp /vagrant/logs/wtmp/r3_wtmp

## ProFTPD
mkdir -p /vagrant/logs/proftpd/
docker cp s2:/var/log/proftpd/xferlog /vagrant/logs/proftpd/s2_xferlog
docker cp s2:/var/log/proftpd/proftpd.log /vagrant/logs/proftpd/s2_proftpd.log