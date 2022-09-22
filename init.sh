#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "apt-get update..."
sudo apt-get -qq update > /dev/null 2>&1

echo "install apache2..."
sudo apt-get install -yqq apache2 > /dev/null 2>&1     

echo "add php repository..."
sudo add-apt-repository ppa:ondrej/php > /dev/null 2>&1

echo "apt-get update..."
sudo apt-get -qq update > /dev/null 2>&1

echo "Install php libraries..."
sudo apt install -yqq php7.4 php7.4-imagick php7.4-fpm php7.4-mysql php7.4-common php7.4-gd php7.4-imap php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-gmp libapache2-mod-php7.4 > /dev/null 2>&1

echo "installing composer, downloading and setting up SuiteCRM v7.10.35..."
wget https://getcomposer.org/download/1.8.1/composer.phar > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer
sudo chown www-data:www-data /usr/local/bin/composer
sudo chmod 655 /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
sudo wget https://github.com/salesagility/SuiteCRM/archive/v7.10.35.zip > /dev/null 2>&1
sudo unzip v7.10.35.zip -d /var/www/html/ > /dev/null 2>&1
cd /var/www/html
sudo mv SuiteCRM-7.10.35 suitecrm
composer install --working-dir=/var/www/html/suitecrm/ > /dev/null 2>&1
sudo cp /vagrant/config_si.php /var/www/html/suitecrm/ 
sudo chown -R www-data:www-data suitecrm
echo "Running SuiteCRM Web Installer..."
curl "http://127.0.0.1/suitecrm/install.php?goto=SilentInstall&cli=true" > /dev/null 2>&1 && echo "SuiteCRM installed successfully!"
echo "Visit http://<IP_Address>/suitecrm to login"

# echo "finished Installation./nProvider: Hyper-v - perform curl http://<IP_address>/suitecrm/install.php?goto=SilentInstall&cli=true to complete installation./n Upon successful installation, proceed to http://<VM_IP_address>/suitecrm to login.\n\n Provider: VirtualBox - Visit http://127.0.0.1:8080/suitecrm to login"

