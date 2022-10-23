#!/bin/bash
echo "Installing composer, downloading and setting up SuiteCRM v7.11.15..."
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
sed -i -e 's/\/var\/www\/html/\/var\/www\/html\/suitecrm/g' /etc/apache2/sites-available/000-default.conf