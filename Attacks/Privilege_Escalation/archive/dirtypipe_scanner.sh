#!/bin/bash
#
# DirtyPipe (CVE-2022-0847) Vulnerability Scanner

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
        echo "[!] This kernel version is not vulnerable to DirtyPipe!"
        exit 0
    else
        echo "[+] This kernel version is vulnerable to DirtyPipe!"

        # Checks if /usr/bin/su has SUID bit set
        echo "[*] Checking if SUID bit is set on /usr/bin/su..."
        if [[ "$(find / -perm -4000 2>/dev/null)" =~ "/usr/bin/su" ]];
            then
                echo "[+] SUID bit is set on /usr/bin/su!"
            else
                # If SUID bit is not set on /usr/bin/su, terminate the script
                echo "[!] SUID bit is not set on /usr/bin/su!"
                exit 0
        fi
fi