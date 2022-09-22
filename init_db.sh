#!/bin/bash
echo "Creating SuiteCRM database..."
sudo mysql -u root -- <<MYSQL
CREATE DATABASE suitecrm;
CREATE USER 'Admin' IDENTIFIED BY 'Admin';
GRANT ALL ON suitecrm.* TO 'Admin';
FLUSH PRIVILEGES;
MYSQL
echo "Finished Creating SuiteCRM Database ..."
