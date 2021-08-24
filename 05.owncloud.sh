#!/bin/bash

clear
echo -e "\e[1mActualizando paquetes\e[0m\n"
apt-get update
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mInstalando Dependencias\e[0m\n"
apt-get --assume-yes install php7.3 php7.3-curl php7.3-gd php7.3-intl php7.3-json php7.3-xml php7.3-mbstring php7.3-mysql php7.3-zip php7.3-sqlite3
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mInstalando owncloud\e[0m\n"
cd "/home/${SUDO_USER}"
wget https://download.owncloud.org/community/owncloud-10.4.1.zip
unzip owncloud-10.4.1.zip
rm owncloud-10.4.1.zip
mv owncloud www/
chown -R www-data:www-data ./www/owncloud/
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mCreando base y permisos ownCloud\e[0m\n"
sudo mysql -uroot -e "CREATE DATABASE IF NOT EXISTS owncloud;" && sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON owncloud.* TO 'ocuser'@'localhost' IDENTIFIED BY 'owncloud';"
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mHabilitando modulos Apache\e[0m\n"
a2enmod headers && a2enmod env && a2enmod dir && a2enmod mime && a2enmod unique_id
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mReiniciando el servicio\e[0m\n"
mv "/home/${SUDO_USER}/.config/apache/owncloud.bak" "/home/${SUDO_USER}/.config/apache/owncloud.conf"
service apache2 restart
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mReiniciando el servicio\e[0m\n"
mkdir -p /mnt/NAS/owncloud/data
chown -R www-data:www-data /mnt/NAS/owncloud/data
cd "/home/${SUDO_USER}/www/owncloud"
sudo -u www-data php occ maintenance:install --database "mysql" --database-name "owncloud" --database-user "ocuser" --database-pass "owncloud" --admin-user "admin" --admin-pass "password" --data-dir /mnt/NAS/owncloud/data
echo -e "\e[4mListo.\n\e[0m"
