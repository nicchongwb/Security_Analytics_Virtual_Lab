#!/bin/bash
echo "Creating SuiteCRM database..."
mysql -u root --password=P@ssw0rd1 -- <<MYSQL
CREATE DATABASE suitecrm;
CREATE USER 'Admin' IDENTIFIED BY 'Admin';
GRANT ALL ON suitecrm.* TO 'Admin';
FLUSH PRIVILEGES;
MYSQL
echo "Finished Creating SuiteCRM Database ..."
