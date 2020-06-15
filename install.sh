. $(dirname "$0")/00.init.sh
. $(dirname "$0")/01.lamp-install.sh
. $(dirname "$0")/02.nas.sh
. $(dirname "$0")/03.proxy.sh
. $(dirname "$0")/04.vpn.sh
. $(dirname "$0")/04.01.vpn-clientes.sh
. $(dirname "$0")./99.post-install.sh
reboot
