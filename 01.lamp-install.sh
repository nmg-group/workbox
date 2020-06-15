#!/bin/bash

clear
echo -e "\e[1mActualizando paquetes\e[0m\n"
apt-get update
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mInstalando Apache & PHP\e[0m\n"
apt-get --assume-yes install apache2 php php-gd php-mysql php-zip php-curl
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mCambiando de directorio a /home/${SUDO_USER}\n\e[0m"
cd "/home/${SUDO_USER}"

echo -e "\n\e[1mCreando directorios para www\n\e[0m"
mkdir -p ./www/logs ./www/html_default ./www/html_wordpress
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mCreando archivos de configuracion de Apache\n\e[0m"
mkdir -p /.config/apache
rsync -avz ./resources/config/apache ./.config/
for filename in ./.config/apache/*; do
	sed -i "s/SUDO_USER/${SUDO_USER}/g" "${filename}"
	echo " -- Configurando archivo: ${filename}"
done
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mIncluyendo carpeta de configuracion Apache\e[0m\n"
echo "Include /home/${SUDO_USER}/.config/apache/*.conf" >> /etc/apache2/apache2.conf
a2dissite 000-default.conf
a2enmod rewrite
systemctl restart apache2
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mInstalando MariaDB\e[0m\n"
apt-get --assume-yes install mariadb-server
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mCreando base y permisos WordPress\e[0m\n"
sudo mysql -uroot -e "CREATE DATABASE IF NOT EXISTS wordpress;" && sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost' IDENTIFIED BY 'wordpress';"
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mInstalando WordPress:\nhttps://es-ar.wordpress.org/latest-es_AR.tar.gz\e[0m\n"
cd ./www/html_wordpress/ && wget https://es-ar.wordpress.org/latest-es_AR.tar.gz && tar -xvzf latest-es_AR.tar.gz && rm latest-es_AR.tar.gz && mv ./wordpress/* ./ && rm -rf ./wordpress
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mConfigurando wp-config.php\e[0m\n"
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpress/g" wp-config.php
sed -i "s/password_here/wordpress/g" wp-config.php
sed -i "s/username_here/wpuser/g" wp-config.php
echo -e "\e[4mListo.\n\e[0m"


echo -e "\e[1mConfigurando .htaccess\e[0m\n"
touch .htaccess

echo "# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

# END WordPress" > ./.htaccess
echo -e "\e[4mListo.\n\e[0m"

# echo -e "\e[1mDescargando tema StoreFront\e[0m\n"
# cd wp-content/themes/
# wget https://downloads.wordpress.org/theme/latest.zip -O storefront.zip
# unzip storefront.zip
# rm storefront.zip
# mv latest storefront
# echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mSeteando permisos en WordPress\e[0m\n"
cd "/home/${SUDO_USER}/www/html_wordpress"
chown $SUDO_USER:$SUDO_USER -R * && chown -R www-data:www-data wp-content && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && chmod 666 .htaccess
echo -e "\e[4mListo.\n\e[0m"

# echo "La ubicacion de php.ini es ${php -i | grep /.+/php.ini -oE}"
