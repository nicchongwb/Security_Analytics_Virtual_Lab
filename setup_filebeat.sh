#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"

# Initialize version of ELK stack
ELK_VERSION="8.4.2"

# Import Elastic PGP key and repository
echo "[*] Importing Elastic PGP key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - &> /dev/null
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list &> /dev/null
sudo apt update &> /dev/null
echo "[+] Elastic PGP key has been imported"

# Install Filebeat
echo "[*] Installing Filebeat..."
sudo apt-get -y install filebeat=$ELK_VERSION &> /dev/null
echo "[+] Installation of Filebeat completed"

# Copy Filebeat config and restart daemon
echo "[*] Copying Filebeat config and restarting daemon..."
cp /vagrant/ELK\ Stack/configs/filebeat/filebeat.yml /etc/filebeat/ &> /dev/null
sudo /bin/systemctl daemon-reload &> /dev/null
sudo /bin/systemctl enable filebeat.service &> /dev/null
sudo /bin/systemctl start filebeat.service &> /dev/null
echo "[+] Filebeat service started"
