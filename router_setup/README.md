```bash
# Build image for ubuntu-network
sudo docker build -t ubuntu-network .

# Docker compose up in detached mode
sudo docker compose up -d 

# Setup networking for containers (this does not rely on docker's native networking but instead rely on the Host OS)
sudo ./network_setup.sh

# Teardown
sudo docker compoose down
sudo ./network_teardown

# Utility
## Testing r1 routing
### TCP dump in r1
sudo docker exec -it r1 bash
tcpdump -i any

### Ping c1 to c2 and observe tcpdump in r1
sudo docker exec -it c1 ping -c 4 192.168.11.2
```