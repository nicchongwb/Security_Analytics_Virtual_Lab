#!/bin/bash
for i in $( cat ips_sorted.txt ); do
    echo "huanyinkoh95" | sshpass ssh-copy-id -f -i ~/.ssh/ "david"@"$i"
done