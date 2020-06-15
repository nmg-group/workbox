# Servicios

Todo en un workbox(code) - nombre que le daremos al equipo una vez instalado - está basado en servicios. Por ejemplo uno de los servicios es el proxy, otro el de VPN; todos ellos están basados en Software Open Source.

A continuación veremos un breve detalle de cada servicio en workbox y sus bases.

**Cliente**: Un equipo/usuario que accederá o consumirá servicios del workbox, normalmente desde dentro de la misma red.


## File server

Este servicio permite compartir archivos entre los dispositivos de una red. Tras habilitarlo, un equipo nuevo aparecerá en la red, ingresando a él puedes guardar archivos en los recursos compartidos (carpetas) que serán accesibles (y modificables) por cualquier otro equipo en la misma [red privada](https://es.wikipedia.org/wiki/Red_privada).

El servidor de archivos es compatible con Windows, Linux y Mac.

**Ten en cuenta**: Actualmente todos los recursos compartidos en workbox son accesibles sin usuario/contraseña.


## Proxy server

Este servicio funciona como intermediario entre el navegador del usuario (un dispositivo cliente) y servidores en internet. Un proxy como el instalado en workbox permite:

1. Acelerar el uso de internet almacenando una copia de los archivos estáticos (como imágenes) para no descargarlos cada vez desde el servidor en internet (dentro de una ventana de tiempo).

2. Controlar el uso de internet permitiendo o denegando el acceso a determinadas categorías de contenido, en el caso de workbox:
  - **Ads** - Redes de publicidad online.
  - **Aggressive** - Contenido de agresividad.
  - **Audio/Video** - Sitios de streaming o compartición.
  - **Drugs** - Venta online de drogas.
  - **Gambling** - Sitios de apuestas online.
  - **Hacking** - Sitios sobre hacking.
  - **Mail** - Sitios de webmail.
  - **Porn** - Contenido pornográfico.
  - **Proxy** - Proxies reconocidos.
  - **Redirector** - Servicios de redirección.
  - **Social-Network** - Redes sociales.
  - **Spyware** - Contenido malicioso (Spyware).
  - **Suspect** - Contenido sospechoso.
  - **Violence** - Contenido violento.
  - **Warez** - Software pirateado.

## VPN Virtual Private Network

Este servicio permite a los clientes que se encuentren fuera de la red interna, conectarse a través de un canal seguro y utilizar los recursos de la red interna tales como compartir archivos, utilizar impresoras o programas internos como si se encontraran físicamente conectados a la red local.

![VPN](/assets/VPN.png)

[Wikipedia](https://es.wikipedia.org/wiki/Red_privada_virtual).

Esto es particularmente útil para home office, compartir archivos o sistemas internos sin exponerlos al exterior.
