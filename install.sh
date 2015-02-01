#!/bin/sh

# install software
apt-get update

# git
apt-get install git

# apache
apt-get remove --purge apache2

# php
apt-get install php5 php5-dev
apt-get install php5-fpm
apt-get install php5-curl php5-json php5-mysql php5-pgsql php5-gd php5-mcrypt
apt-get install php-pear

# nginx
apt-get install libpcre3-dev
apt-get install libssl-dev
apt-get install nginx

# database
apt-get install postgresql
apt-get install pgbouncer

# js
apt-get install nodejs
apt-get install npm
npm install -g bower
npm install -g grunt-cli

# photo
apt-get install imagemagick

# load sysctl settings (/etc/sysctl.conf)
sysctl -p

# restart cron
service cron restart

# restart service
/etc/init.d/nginx      restart
/etc/init.d/postgresql restart
/etc/init.d/pgbouncer  restart
/etc/init.d/php5-fpm   restart
