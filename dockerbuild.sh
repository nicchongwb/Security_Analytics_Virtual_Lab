BLUE="\033[1;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color

echo -e "${BGREEN}\n[+]${NC} Prunning all docker volumes...${NC}"
yes | docker volume prune
echo -e "${BGREEN}\n[+]${NC} Prunning all docker containers...${NC}"
yes | docker container prune # Prune all container before hand
echo -e "${BGREEN}\n[+]${NC} Prunning all docker networks...${NC}"
yes | docker network prune # Prune all network before hand
## Do not uncomment this - it will remove all the builder cache which will cause the rebuilding/building images to be long
# echo -e "${BGREEN}\n[+]${NC} Prunning all docker builder cache...${NC}"
# yes | docker builder prune # Prune all builder before hand

# # 0. Build images
echo -e "${BGREEN}\n[+]${NC} Building ubuntu-network image...${NC}"
docker build -t ubuntu-network -f Dockerfile.ubuntu-network .
# echo -e "${BGREEN}\n[+]${NC} Building kali image...${NC}" 
# docker build -t kali -f Dockerfile.kali .
# echo -e "${BGREEN}\n[+]${NC} Building suitecrm-server image...${NC}"
# docker build -t suitecrm-server -f Dockerfile.suitecrm-server .
# # # 0. Build ELK Stack Containers
echo -e "${BGREEN}\n[+]${NC} Building elasticsearch image...${NC}"
docker build -t elasticsearch -f Dockerfile.elastic .
echo -e "${BGREEN}\n[+]${NC} Building logstash image...${NC}"
docker build -t logstash -f Dockerfile.logstash .
echo -e "${BGREEN}\n[+]${NC} Building kibana image...${NC}"
docker build -t kibana -f Dockerfile.kibana .