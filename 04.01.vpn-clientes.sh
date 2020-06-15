su -c "mkdir -p /home/${SUDO_USER}/client-configs/files" ${SUDO_USER}
cd "/home/${SUDO_USER}"
su -c "cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf ./client-configs/base.conf" ${SUDO_USER}
sed -i 's/remote my-server-1 1194/remote my.remote.workbox.com.ar 1194/g' ./client-configs/base.conf

sed -i 's/;user nobody/user nobody/g' ./client-configs/base.conf
sed -i 's/;group nogroup/group nogroup/g' ./client-configs/base.conf

sed -i 's/ca ca.crt/;ca ca.crt/g' ./client-configs/base.conf
sed -i 's/cert client.crt/;cert client.crt/g' ./client-configs/base.conf
sed -i 's/key client.key/;key client.key/g' ./client-configs/base.conf

sed -i 's/tls-auth ta.key 1/;tls-auth ta.key 1/g' ./client-configs/base.conf

sed -i "s/cipher AES-256-CBC/cipher AES-256-GCM\\nauth SHA256/g" ./client-configs/base.conf

echo -e "key-direction 1" >> ./client-configs/base.conf

echo -e "
; script-security 2
; up /etc/openvpn/update-resolv-conf
; down /etc/openvpn/update-resolv-conf

; script-security 2
; up /etc/openvpn/update-systemd-resolved
; down /etc/openvpn/update-systemd-resolved
; down-pre
; dhcp-option DOMAIN-ROUTE ." >> ./client-configs/base.conf

cp $(dirname "$0")/resources/scripts/openvpn-make_config.sh ./client-configs/make_config.sh
chown ${SUDO_USER}:${SUDO_USER} ./client-configs/make_config.sh
chmod 700 ./client-configs/make_config.sh

cd "/home/${SUDO_USER}/client-configs"
su -c "./make_config.sh client1" ${SUDO_USER}
su -c "mkdir -p /mnt/NAS/Publico/VPN" ${SUDO_USER}
su -c "cp ./client-configs/files/client1.ovpn /mnt/NAS/Publico/VPN/" ${SUDO_USER}
