#!/bin/bash

set -e
set -u

# Move to temp directory
cd /tmp

# Install PHP and Apache
apt-get -y update
apt-get clean all
apt-get -y install apache2
apt-get -y install libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur

# Install Xdebug
pecl install Xdebug

# Install composer
curl -LsS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
composer --version

# Disable default site
sudo a2dissite 000-default.conf

# Enable site
sudo a2ensite app.conf

# Restart apache
service apache2 restart