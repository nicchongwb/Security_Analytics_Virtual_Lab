# F. Teardown - run in sudo
### Clean up network namespaces links
echo '[+] Setting variables: c1_id, c2_id, r1_id to store container IDs...'
c1_id=$(docker ps --format '{{.ID}}' --filter name=c1)
echo "c1_id=${c1_id}"
c2_id=$(docker ps --format '{{.ID}}' --filter name=c2)
echo "c2_id=${c2_id}"
r1_id=$(docker ps --format '{{.ID}}' --filter name=r1)
echo "r1_id=${r1_id}"

echo '[+] Removing softlinks created...'
rm /var/run/netns/$c1_id
rm /var/run/netns/$r1_id
rm /var/run/netns/$c2_id