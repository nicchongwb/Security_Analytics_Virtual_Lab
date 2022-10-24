#!/bin/bash
# Create user in d1 first
docker exec -u 0 d1 adduser david --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
docker cp setpassword.sh d1:/
docker exec d1 chmod +x /setpassword.sh
docker exec d1 ./setpassword.sh

# copy ssh_bruteforce.sh into s1
docker cp /vagrant/Attacks/Lateral_Movement/lateral_movement.sh s1:/
docker exec s1 chmod +x lateral_movement.sh

# docker exec -it s1 ./lateral_movement.sh