#!/bin/bash

# Initialize version of ELK stack
ELK_VERSION="8.4.3"

# Import Elastic PGP key and repository
echo "[*] Importing Elastic PGP key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - &> /dev/null
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-8.x.list &> /dev/null
apt update &> /dev/null
echo "[+] Elastic PGP key has been imported"

# Install Filebeat
echo "[*] Installing Filebeat..."
apt-get -y install filebeat=$ELK_VERSION &> /dev/null
echo "[+] Installation of Filebeat completed"

# Copy Filebeat config and start service
echo "[*] Copying Filebeat config and starting service..."
cp filebeat.yml /etc/filebeat/
# /etc/init.d/filebeat start
# echo "[+] Filebeat service started"
