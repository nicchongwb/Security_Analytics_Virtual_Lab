#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "install software properties..."
apt-get install -y software-properties-common > /dev/null 2>&1

echo "apt-get update..."
apt-get update > /dev/null 2>&1

echo "install and start apache2..."
apt-get install -y apache2 software-properties-common > /dev/null 2>&1

/etc/init.d/apache2 start

echo "add php repository..."
add-apt-repository ppa:ondrej/php > /dev/null 2>&1

echo "apt-get update..."
apt-get update > /dev/null 2>&1

echo "Install php libraries..."
apt-get install -yqq php7.4 php7.4-imagick php7.4-fpm php7.4-mysql php7.4-common php7.4-gd php7.4-imap php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-gmp libapache2-mod-php7.4 > /dev/null 

echo "Install gcc..." # Required for privilege escalation
apt-get install -y gcc > /dev/null 2>&1

echo "Install linux libraries..." 
apt-get install -y wget curl unzip composer > /dev/null 2>&1

echo "installing composer, downloading and setting up SuiteCRM v7.11.15..."
wget https://getcomposer.org/download/1.8.1/composer.phar > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer
chown www-data:www-data /usr/local/bin/composer
chmod 655 /usr/local/bin/composer
chmod +x /usr/local/bin/composer
wget https://github.com/salesagility/SuiteCRM/archive/v7.11.15.zip > /dev/null 2>&1
unzip v7.11.15.zip -d /var/www/html/ > /dev/null 2>&1
mv /var/www/html/SuiteCRM-7.11.15 /var/www/html/suitecrm
composer install --working-dir=/var/www/html/suitecrm/ > /dev/null 2>&1
mv config_si.php /var/www/html/suitecrm/ 
chown -R www-data:www-data /var/www/html/suitecrm


