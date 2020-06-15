bash $(dirname "$0")/00.init.sh
bash $(dirname "$0")/01.lamp-install.sh
bash $(dirname "$0")/02.nas.sh
bash $(dirname "$0")/03.proxy.sh
bash $(dirname "$0")/04.vpn.sh
bash $(dirname "$0")/04.01.vpn-clientes.sh
bash $(dirname "$0")/99.post-install.sh
reboot
