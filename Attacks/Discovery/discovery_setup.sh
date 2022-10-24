#!/bin/bash
## Start ssh on d1
docker exec d1 service ssh start
## david : huanyinkoh95
docker exec s1 mysql "suitecrm" -Bse "insert into users (id, user_name, user_hash) values (2, 'david', '\$2a\$10\$XV5cpvebRHrIb0.dzqKqDOvpRxzlSxtecD3UqJswv6JZTm5jvISnW');"

# Start ssh service in d1 - prior pivoting
docker exec d1 service ssh start

# Run discovery.sh in VM host
docker cp /vagrant/Attacks/Discovery/discovery.sh s1:/
docker exec s1 chmod +x discovery.sh

# docker exec s1 ./discovery.sh