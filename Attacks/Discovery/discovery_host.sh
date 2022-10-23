#!/bin/bash
# Create user in d1 first
docker exec -u 0 d1 adduser david --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
docker exec -u 0 d1 echo "david:huanyinkoh95" | chpasswd

# Create SSH credentials leak in s1 
docker exec s1 mkdir -p /.ssh
docker exec s1 echo "david:huanyinkoh95" > /.ssh/creds

# Start ssh service in d1 - prior pivoting
docker exec d1 service ssh start

# Run discovery.sh in VM host
docker cp /vagrant/Attacks/Discovery/discovery.sh s1:/
docker exec s1 chmod +x discovery.sh
docker exec s1 ./discovery.sh

