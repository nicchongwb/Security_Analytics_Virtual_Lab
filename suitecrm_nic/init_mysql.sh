#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "apt-get update..."
apt-get update > /dev/null 2>&1
# Define MySQL password
MYSQL_ROOT_PASSWORD='P@ssw0rd1'

echo "installing mariabdb-server & expect..."
# Install mariadb-server & expect
apt-get install -y mariadb-server expect > /dev/null 2>&1

# systemctl start mariadb
/etc/init.d/mariadb start

echo "MySQL Root Password: $MYSQL_ROOT_PASSWORD\r"

# Expect Script
tee ~/secure_our_mysql.sh > /dev/null << EOF
spawn $(which mysql_secure_installation)
expect "Enter current password for root (enter for none):"
send "$MYSQL_ROOT_PASSWORD\r"
expect "Switch to unix_socket authentication "
send "n\r"
expect "Change the root password? "
send "y\r"
expect "New password:"
send "$MYSQL_ROOT_PASSWORD\r"
expect "Re-enter new password:"
send "$MYSQL_ROOT_PASSWORD\r"
expect "Remove anonymous users? "
send "y\r"
expect "Disallow root login remotely? "
send "y\r"
expect "Remove test database and access to it? "
send "y\r"
expect "Reload privilege tables now? "
send "y\r"
EOF

echo "Runs mysql_secure_installation script..."
# Runs the "mysql_secure_installation" script
expect ~/secure_our_mysql.sh 

echo "Cleanup mysql_secure_installation script..."
# Cleanup
rm -v ~/secure_our_mysql.sh # Remove the generated Expect script
echo "Purge expect..."
apt-get purge expect > /dev/null 2>&1

echo "MySQL setup completed successfully. Insecure defaults are gone. Ensure removal of the MySQL root password in this script"
