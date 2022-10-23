#!/bin/bash
# T1021 - Remote Services
## T1021.004 - SSH

# Create ssh-key for s1
docker exec -u 0 s1 ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y

# copy ssh_bruteforce.sh into s1
docker cp ssh_bruteforce.sh s1:/
docker exec s1 chmod +x ssh_bruteforce.sh