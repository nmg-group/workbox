#!/bin/bash

clear
echo -e "\e[1mActualizando paquetes\e[0m\n"
apt-get update
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mInstalando UFW\e[0m\n"
apt-get --assume-yes install ufw
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mInstalando Easy RSA\e[0m\n"
apt-get --assume-yes install easy-rsa
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mPreparando directorio de configuracion\e[0m\n"
cd "/home/${SUDO_USER}"
mkdir -p easy-rsa
ln -s /usr/share/easy-rsa/* ./easy-rsa/
chown -R ${SUDO_USER}:${SUDO_USER} easy-rsa
chmod -R 700 easy-rsa
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mPreparando PKI\e[0m\n"
cd easy-rsa
su -c "./easyrsa init-pki" ${SUDO_USER}
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mConfigurando Autoridad de Certificacion\e[0m\n"
echo "set_var EASYRSA_BATCH       \"yes\"
set_var EASYRSA_REQ_CN         \"workbox.local\"
set_var EASYRSA_REQ_COUNTRY    \"AR\"
set_var EASYRSA_REQ_PROVINCE   \"C.A.B.A.\"
set_var EASYRSA_REQ_CITY       \"C.A.B.A.\"
set_var EASYRSA_REQ_ORG        \"WorkBOX Server\"
set_var EASYRSA_REQ_EMAIL      \"it@workbox.com.ar\"
set_var EASYRSA_REQ_OU         \"Community\"
set_var EASYRSA_ALGO           \"ec\"
set_var EASYRSA_DIGEST         \"sha512\"" > vars
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mPermisos en directorio de configuracion\e[0m\n"
cd "/home/${SUDO_USER}"
chown -R ${SUDO_USER}:${SUDO_USER} easy-rsa
chmod -R 700 easy-rsa
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mCreando Autoridad de Certificacion\e[0m\n"
cd easy-rsa
su -c "./easyrsa build-ca nopass" ${SUDO_USER}
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mInstalando OpenVPN\e[0m\n"
apt-get --assume-yes install openvpn
echo -e "\e[4mListo.\n\e[0m"


echo -e "\n\e[1mGenerando y firmando certificados\e[0m\n"
cd "/home/${SUDO_USER}/easy-rsa"
su -c "./easyrsa gen-req server nopass" ${SUDO_USER}
cp ./pki/private/server.key /etc/openvpn/server/
su -c "./easyrsa sign-req server server" ${SUDO_USER}
cp pki/ca.crt /etc/openvpn/server/
cp pki/issued/server.crt /etc/openvpn/server/

su -c "openvpn --genkey --secret ta.key" ${SUDO_USER}
cp ta.key /etc/openvpn/server

cd "/home/${SUDO_USER}"
su -c "mkdir -p ./client-configs/keys" ${SUDO_USER}
cp /etc/openvpn/server/ca.crt ./client-configs/keys/
cp /etc/openvpn/server/ta.key ./client-configs/keys/
chmod -R 700 ./client-configs
chown -R ${SUDO_USER}:${SUDO_USER} ./client-configs
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mGenerando CSR workbox_vpn\e[0m\n"
cd "/home/${SUDO_USER}/easy-rsa"
su -c "./easyrsa gen-req workbox_vpn nopass" ${SUDO_USER}
su -c "cp pki/private/workbox_vpn.key ../client-configs/keys/" ${SUDO_USER}
echo -e "\e[4mListo.\n\e[0m"

echo -e "\n\e[1mFirmando CSR workbox_vpn\e[0m\n"
cd "/home/${SUDO_USER}/easy-rsa"
su -c "./easyrsa sign-req client workbox_vpn" ${SUDO_USER}
su -c "cp pki/issued/workbox_vpn.crt ../client-configs/keys/" ${SUDO_USER}
echo -e "\e[4mListo.\n\e[0m"




echo -e "\n\e[1mConfigurando OpenVPN\e[0m\n"
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/server/
gunzip /etc/openvpn/server/server.conf.gz
sed -i "s/tls-auth/tls-crypt ta.key\\n;tls-auth/g" /etc/openvpn/server/server.conf
sed -i "s/cipher AES-256-CBC/cipher AES-256-GCM\\nauth SHA256\\n;cipher AES-256-CBC/g" /etc/openvpn/server/server.conf
sed -i "s/dh dh2048.pem/dh none\\n;dh dh2048.pem/g" /etc/openvpn/server/server.conf
sed -i "s/;user nobody/user nobody/g" /etc/openvpn/server/server.conf
sed -i "s/;group nogroup/group nogroup/g" /etc/openvpn/server/server.conf
echo -e '\npush "route 192.168.0.0 255.255.0.0"' >> /etc/openvpn/server/server.conf
echo -e "\e[4mListo.\n\e[0m"




echo -e "\n\e[1mConfigurando la red y reenvios\e[0m\n"
echo -e "\nnet.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

cp /etc/ufw/before.rules /etc/ufw/before.rules.bak
ethernetInterface=$(ip addr show | awk '/inet.*brd/{print $NF}')
sed -i "s/# Don't delete these required lines/# START OPENVPN RULES\\n# NAT table rules\\n\*nat\\n:POSTROUTING ACCEPT [0:0]\\n# Allow traffic from OpenVPN client to ${ethernetInterface}\\n-A POSTROUTING -s 10.8.0.0\/8 -o ${ethernetInterface} -j MASQUERADE\\nCOMMIT\\n# END OPENVPN RULES\\n\\n# Don't delete these required lines/g" /etc/ufw/before.rules
sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
ufw allow 1194/udp
ufw allow OpenSSH
ufw disable
ufw --force enable
echo -e "\e[4mListo.\n\e[0m"



echo -e "\n\e[1mHabilitando el servicio\e[0m\n"
systemctl -f enable openvpn-server@server.service
systemctl start openvpn-server@server.service
# systemctl status openvpn-server@server.service
echo -e "\e[4mListo.\n\e[0m"
