# G. Teardown - run in sudo
### Clean up network namespaces links
echo '[+] Setting variables: c1_id, c2_id, c3_id, c4_id, r1_id, r2_id to store container IDs...'
c1_id=$(docker ps --format '{{.ID}}' --filter name=c1)
echo "c1_id=${c1_id}"
c2_id=$(docker ps --format '{{.ID}}' --filter name=c2)
echo "c2_id=${c2_id}"
c3_id=$(docker ps --format '{{.ID}}' --filter name=c3)
echo "c3_id=${c3_id}"
c4_id=$(docker ps --format '{{.ID}}' --filter name=c4)
echo "c4_id=${c4_id}"
c5_id=$(docker ps --format '{{.ID}}' --filter name=c5)
echo "c5_id=${c5_id}"
c6_id=$(docker ps --format '{{.ID}}' --filter name=c6)
echo "c6_id=${c6_id}"
r1_id=$(docker ps --format '{{.ID}}' --filter name=r1)
echo "r1_id=${r1_id}"
r2_id=$(docker ps --format '{{.ID}}' --filter name=r2)
echo "r2_id=${r2_id}"
r3_id=$(docker ps --format '{{.ID}}' --filter name=r3)
echo "r3_id=${r3_id}"

echo '[+] Removing softlinks created...'
# rm /var/run/netns/*
rm /var/run/netns/$c1_id
rm /var/run/netns/$c2_id
rm /var/run/netns/$c3_id
rm /var/run/netns/$c4_id
rm /var/run/netns/$c5_id
rm /var/run/netns/$c6_id
rm /var/run/netns/$r1_id
rm /var/run/netns/$r2_id
rm /var/run/netns/$r3_id

echo '[+] Docker compose down...' 
docker compose down
echo '[+] Teardown complete!'