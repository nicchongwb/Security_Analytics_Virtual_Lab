#!/bin/bash
## Transfer file to s1
docker cp /vagrant/Attacks/Exfiltration/cloakify.py s1:/tmp
docker cp /vagrant/Attacks/Exfiltration/pokemonGo s1:/tmp
docker cp /vagrant/Attacks/Exfiltration/decloakify.py k1:/
docker cp /vagrant/Attacks/Exfiltration/pokemonGo k1:/

# Run exfiltration_s1.sh in VM host
docker cp /vagrant/Attacks/Exfiltration/exfiltration_s1.sh s1:/
docker cp /vagrant/Attacks/Exfiltration/exfiltration_k1.sh k1:/
docker exec s1 chmod +x exfiltration_s1.sh

# docker exec s1 ./exfiltration.sh
