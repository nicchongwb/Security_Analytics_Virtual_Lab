#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"

# Initialize version of ELK stack
ELK_VERSION="8.4.2"

# Install necessary packages
echo "[*] Installing necessary packages..."
sudo apt-get -y install apt-transport-https default-jre &> /dev/null
echo "[+] Installation of packages completed"

# Import Elastic PGP key and repository
echo "[*] Importing Elastic PGP key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - &> /dev/null
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list &> /dev/null
sudo apt update &> /dev/null
echo "[+] Elastic PGP key has been imported"

# Install Elasticsearch
echo "[*] Installing Elasticsearch..."
sudo apt-get -y install elasticsearch=$ELK_VERSION &> /dev/null
echo "[+] Installation of Elasticsearch completed"

# Copy Elasticsearch config and restart daemon
echo "[*] Copying Elasticsearch config and restarting daemon..."
cp /vagrant/configs/elasticsearch/elasticsearch.yml /etc/elasticsearch/ &> /dev/null
sudo /bin/systemctl daemon-reload &> /dev/null
sudo /bin/systemctl enable elasticsearch.service &> /dev/null
sudo sed -i -e 's/TimeoutStartSec=75/TimeoutStartSec=300/g' /usr/lib/systemd/system/elasticsearch.service &> /dev/null
sudo /bin/systemctl start elasticsearch.service &> /dev/null
echo "[+] Elasticsearch service started"

# Install Logstash
echo "[*] Installing Logstash..."
sudo apt-get -y install logstash=1:$ELK_VERSION-1 &> /dev/null
echo "[+] Installation of Logstash completed"

# Copy Logstash config and restart daemon
echo "[*] Copying Logstash config and restarting daemon..."
cp -R /vagrant/configs/logstash/* /etc/logstash/conf.d/ &> /dev/null
sudo /bin/systemctl enable logstash.service &> /dev/null
sudo /bin/systemctl start logstash.service &> /dev/null
echo "[+] Logstash service started"

# Install Kibana
echo "[*] Installing Kibana..."
sudo apt-get -y install kibana=$ELK_VERSION &> /dev/null
echo "[+] Installation of Kibana completed"

# Copy Kibana config and restart daemon
echo "[*] Copying Kibana config and restarting daemon..."
cp /vagrant/configs/kibana/kibana.yml /etc/kibana/ &> /dev/null
sudo /bin/systemctl daemon-reload &> /dev/null
sudo /bin/systemctl enable kibana.service &> /dev/null
sudo /bin/systemctl start kibana.service &> /dev/null
echo "[+] Kibana service started"

# Echo IP address of machine
IP_ADDRESS=$(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
echo "IP address of machine: $IP_ADDRESS"
echo "Navigate to http://$IP_ADDRESS:9200 to access Elasticsearch!"
echo "Navigate to http://$IP_ADDRESS:5601 to access Kibana!"
