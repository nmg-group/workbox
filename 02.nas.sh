#!/bin/bash

clear
echo -e "\e[1mCreando estructura de directorios\e[0m\n"
mkdir -p /mnt/NAS
cd /mnt/NAS
mkdir -p Publico Departamentos Usuarios Backup TimeCapsule Musica Soporte SquidCache
touch ./TimeCapsule/.com.apple.timemachine.supported
touch ./.workbox.compatible.drive
chmod -R 777 /mnt/NAS
echo -e "\e[4mListo.\n\e[0m"

echo -e "\e[1mActualizando paquetes\e[0m\n"
apt-get update
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mInstalando Samba\e[0m\n"
apt-get --assume-yes install samba samba-common-bin
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mSeteando config global Samba\e[0m\n"
cd /etc/samba
if ! grep -q Publico smb.conf; then
	mv smb.conf smb.conf.orig
	testparm -s smb.conf.orig > smb.conf
	sed -i "s/\[global\]/\[global\]\\n      guest account = ${SUDO_USER}\\n	create mask = 0777\\n	directory mask = 0777/g" smb.conf
	echo -e "
[Publico]
        comment = Guest access here
        path = /mnt/NAS/Publico
        browseable = Yes
        read only = No
        guest ok = Yes

[Usuarios]
        comment = Carpetas de usuario
        path = /mnt/NAS/Usuarios
        browseable = Yes
        read only = No
        guest ok = Yes

[Departamentos]
        comment = Carpetas de departamentos
        path = /mnt/NAS/Departamentos
        browseable = Yes
        read only = No
        guest ok = Yes

[Backup]
        comment = Backups de informacion
        path = /mnt/NAS/Backup
        browseable = Yes
        read only = Yes
        guest ok = Yes
" >> smb.conf
        echo -e "\e[4mListo.\n\e[0m"
else
        echo -e "\e[4mNo se han hecho cambios (archivo ya modificado).\n\e[0m"
fi


echo -e "\n\e[1mInstalando Netatalk\e[0m\n"
apt-get --assume-yes install netatalk avahi-daemon avahi-utils
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mSeteando config global Netatalk\e[0m\n"

if ! grep -q Publico /etc/netatalk/afp.conf; then
	cp /etc/netatalk/afp.conf /etc/netatalk/afp.conf.orig
	sed -i "s/\[Global\]/\[Global\]\\nuam list = uams_guest.so, uams_dhx.so, uams_dhx2.so\\nguest account = ${SUDO_USER}\\nmimic model = RackMac/g" /etc/netatalk/afp.conf

	echo -e "
[Publico]
path = /mnt/NAS/Publico
rwlist = ${SUDO_USER}

[Usuarios]
path = /mnt/NAS/Usuarios
rwlist = ${SUDO_USER}

[Departamentos]
path = /mnt/NAS/Departamentos
rwlist = ${SUDO_USER}

[Backup]
path = /mnt/NAS/Backup

[Time Capsule]
path = /mnt/NAS/TimeCapsule
rwlist = ${SUDO_USER}
time machine = yes" >> /etc/netatalk/afp.conf
	echo -e "\e[4mListo.\n\e[0m"
else
	echo -e "\e[4mNo se han hecho cambios (archivo ya modificado).\n\e[0m"
fi

echo -e "\n\e[1mReiniciando servicios...\e[0m\n"
service smbd restart && service netatalk restart
echo -e "\e[4mListo.\n\e[0m"
