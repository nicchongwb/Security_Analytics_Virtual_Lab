# Recon
```bash

```

# Execution
```bash


```

# Privilege Escalation
```bash


```

# Discovery
```bash
cd /vagrant/Attacks/Discovery
# Setup discovery in vagrant host
./discovery_setup.sh

# During this stage, attacker should have root in S1
docker exec -it s1 bash
./discovery.sh # Run this in s1 root shell --> script is located in root / dir
```

# Lateral Movement
```bash
cd /vagrant/Attacks/Lateral_Movement
./lateral_movement_setup.sh

# During this stage, attacker should have root in S1
docker exec -it s1 bash
./lateral_movement.sh # Run this in s1 root shell --> script is located in root / dir
```

# Exfiltration
```bash


```

Files to be exfiltrated in S1:

| s/n | Filename            | Machine |
| --- | ------------------- | ------- |
| 1   | /networkenum.txt    | s1      |
| 2   | /ips_sorted.txt     | s1      |
| 3   | /internal_host_scan | s1      |
| 4   | /users.txt          | s1      |
| 5   | /db_users.txt       | s1      |
| 6   | /user_creds.txt     | s1      |
| 7   | /ps_aux.txt         | s1      |
| 8   | /local_groups.txt   | s1      |
| 9   | /sysenum.txt        | s1      | 