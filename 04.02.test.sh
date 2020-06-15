ethernetR=$(ip addr show | awk '/inet.*brd/{print $NF}')
echo "Hola, mi ethernet es ${ethernetR}"
