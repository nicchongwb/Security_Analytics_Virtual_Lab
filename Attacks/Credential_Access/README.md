## Tactic used TA0006
#Technique T1003 OS Credential Dumping
Subtechnique .008 /etc/passwd and /etc/shadow
Adversaries may attempt to dump the contents of /etc/passwd and /etc/shadow to enable offline password cracking.
Most modern Linux operating systems use a combination of /etc/passwd and /etc/shadow to store user account information including password hashes in /etc/shadow.
By default, /etc/shadow is only readable by the root user.
