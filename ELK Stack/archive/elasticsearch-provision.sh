#!/bin/bash
#Bash script to setup and install Elasticsearch

# installs java 8
apt install -y software-properties-common
apt-add-repository -y ppa:webupd8team/java
apt update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt install -y oracle-java8-installer

#Install Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.2-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.2-amd64.deb.sha512
shasum -a 512 -c elasticsearch-8.4.2-amd64.deb.sha512 
sudo dpkg -i elasticsearch-8.4.2-amd64.deb

# configure elasticsearch to be available on port 9200
sudo chmod 777 /etc/elasticsearch
sudo touch /etc/elasticsearch/elasticsearch.yml
sudo cat << EOF > /etc/elasticsearch/elasticsearch.yml
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 192.168.56.111
http.port: 9200-9300
EOF

echo "restarting service..."

service elasticsearch restart

# available on startup
update-rc.d elasticsearch defaults 95 10
