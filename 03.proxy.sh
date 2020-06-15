#!/bin/bash

clear
echo -e "\e[1mActualizando paquetes\e[0m\n"
apt-get update
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mInstalando Squid Proxy\e[0m\n"
apt-get --assume-yes install squid
echo -e "\e[4mListo.\n\e[0m"

cd "/home/${SUDO_USER}"
rsync -avz $(dirname "$0")/resources/config/squid .config/
mkdir -p /mnt/NAS/SquidCache
chmod -R 777 /mnt/NAS/SquidCache

echo -e "\n\e[1mSeteando config Squid Proxy\e[0m\n"
cd /etc/squid
if ! grep -q workbox squid.conf; then
	cp squid.conf squid.conf.orig
	sed -i "s/http_access deny all/# http_access deny all/g" squid.conf
	echo -e "
# workbox
# Incluir blacklists
include /etc/squid/blacklists.conf

# Incluir ACL para dominios bloqueados (manualmente)
acl blockeddomain dstdomain "/etc/squid/blocked.domains.acl"
http_access deny blockeddomain

# Permitir el resto
http_access allow all

# Cache directory:
cache_dir ufs /mnt/NAS/SquidCache 1024 16 256
#  END workbox
" >> squid.conf

	# Setear permisos en .config/squid
	chmod -R 777 "/home/${SUDO_USER}/.config/squid"
	mv /usr/share/squid-langpack/es /usr/share/squid-langpack/es_old
	ln -s "/home/${SUDO_USER}/.config/squid/errors" /usr/share/squid-langpack/es
	ln -s "/home/${SUDO_USER}/.config/squid/blacklists" /etc/squid/blacklists
	ln -s "/home/${SUDO_USER}/.config/squid/blacklists.conf" /etc/squid/blacklists.conf
	ln -s "/home/${SUDO_USER}/.config/squid/blocked.domains.acl" /etc/squid/blocked.domains.acl
        echo -e "\e[4mListo.\n\e[0m"
else
        echo -e "\e[4mNo se han hecho cambios (archivo ya modificado).\n\e[0m"
fi

echo -e "\n\e[1mReiniciando Squid Proxy\e[0m\n"
service squid restart
echo -e "\e[4mListo.\n\e[0m"
