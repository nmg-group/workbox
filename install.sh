MONKEY='\U1F435'
SUCCESS='\U1F389'
COFFEE='\U2615'
WORLD='\U1F30D'
ALARM='\U1F6A8'

UNAME=$(uname -a)

# Determinando la distro y versión de sistema operativo.
if [[ $UNAME == *"Debian"* ]]; then
  WB_SO="Debian"
  WB_VER=$(grep VERSION= /etc/os-release | cut -f2 -d'=' | sed 's/\"//g')
elif [[ $UNAME == *"Ubuntu"* ]]; then
  WB_SO="Ubuntu"
  WB_VER=$(grep DISTRIB_RELEASE /etc/lsb-release | cut -f2 -d'=')
elif [[ $UNAME == *"arm"* ]]; then
  WB_SO="Raspbian"
  WB_VER=$(grep VERSION= /etc/os-release | cut -f2 -d'=' | sed 's/\"//g')
else
  echo "No es posible instalar en este sistema"
  echo "uname -a = ${UNAME}"
  exit
fi

echo -e "El SO es compatible! ${SUCCESS}"
echo "SO: ${WB_SO}"
echo -e "Version: ${WB_VER}\n"


# El script sólo debe correrse con privilegios sudo (pero no root)
if [[ $EUID = 0 ]]; then
  if [[ $SUDO_USER == "" ]]; then
    echo -e "No instales este software con el usuario root"
    echo "Por favor instala usando sudo."
    echo -e "Saliendo del instalador"
    exit
  fi
else
  echo -e "Por favor instala usando sudo"
  echo -e "Saliendo del instalador"
  exit
fi

if [[ $WB_SO == "Raspbian" ]]; then
  touch /boot/ssh
fi



bash $(dirname "$0")/00.init.sh
bash $(dirname "$0")/01.lamp-install.sh
bash $(dirname "$0")/02.nas.sh
bash $(dirname "$0")/03.proxy.sh
bash $(dirname "$0")/04.vpn.sh
bash $(dirname "$0")/04.01.vpn-clientes.sh
bash $(dirname "$0")/99.post-install.sh
reboot
