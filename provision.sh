#!/usr/bin/env bash

# iptables
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
service iptables save
service iptables restart

# Prepare Dir for Wordpress
mkdir -p /site
ln -s /vagrant/source/wordpress /site/wordpress
chown -R vagrant.vagrant /site

# Add repo for MariaDB --------------------------
cat /vagrant/config/mariadb.repo > /etc/yum.repos.d/mariadb.repo
rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB

# Apache ----------------------------------------
# Install Apache
yum install httpd MariaDB-devel MariaDB-client MariaDB-server -y

# Prepare for static file crash with VirtualBox
echo "EnableSendfile off" >> /etc/httpd/conf/httpd.conf

# Setup Virtualhost
cp /vagrant/config/wordpress.local.conf /etc/httpd/conf.d/wordpress.local.conf

cd /usr/local/src
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/epel-release-6-5.noarch.rpm
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-11.ius.el6.noarch.rpm
rpm -ivh epel-release-6-5.noarch.rpm ius-release-1.0-11.ius.el6.noarch.rpm

# Install PHP5.4
yum install php54 php54-devel php54-common php54-cli php54-pear php54-xml php54-mbstring php54-gd php54-pgsql php54-mysql -y

# Setup php.ini
cat /vagrant/config/php.add.ini >> /etc/php.ini

# Setup MariaDB ----------------------------------------
service mysql start

/usr/bin/mysqladmin -u root password 'vagrant'
/usr/bin/mysqladmin -u root -pvagrant -h localhost.localdomain password 'vagrant'

mkdir /var/log/mysql
chown -R mysql.mysql /var/log/mysql

cp /vagrant/config/my.cnf /etc/my.cnf
service mysql restart

mysql -u root -pvagrant -e ";create database wordpress default character set utf8;"
mysql -u root -pvagrant -e ";grant all privileges on *.* to vagrantuser@'%' identified by 'vagrant';"

chkconfig mysql on
chkconfig httpd on

# Start Server
service httpd start
