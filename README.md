# workbox(code)

**¿Qué tienen en común un Raspberry Pi y un server HPE Proliant DL580 10th gen?**

Qué con una sola línea de código (y en 8 minutos) podés convertirlos en un servidor de archivos en red, acceso remoto seguro VPN, proxy de aceleración y seguridad de internet y más. **Ah, y es gratis**.

workbox(code) es un gestor de servidores basado en Debian Linux super-super-super-super-super simple de utilizar.

## Que... qué??

Paradójicamente, la tecnología más robusta, estable y mejor desarrollada del mundo es de acceso libre y gratuito; aún así pequeñas y medianas empresas se ven atrapadas en licencias pagas de empresas privadas por software de menor calidad.

¿Por qué? Porque el software Open Source (libre y gratuito), en general requiere de conocimientos un poco o bastante más avanzados para lograr implementarlo o utilizarlo que una solución privativa como por ejemplo, Windows. Digamos que viene "más masticada" la cosa.

### ¿Cuál es la misión de workbox?

Tomar parte de ese excelente software Open Source creado por comunidades de profesionales a través del mundo y ponerlo a disposición de usuarios menos (o nada) técnicos. Cómo lo hacemos? Incluyendo herramientas que hacen de administrar ese software algo tan o más simple que comprar uno pago.

**¿Por qué "(code)"?**

Simple: No tenemos autorización para usar la marca workbox y está registrada en Argentina (donde nació el proyecto).

## ¿Como instalarlo?

### Pre-requisitos

1. De momento sólo está soportado y probado sobre Ubuntu (testeado sobre Ubuntu server v. 20.04). No requiere interfaz gráfica.
Link: https://ubuntu.com/download

2. Un usuario con privilegios sudo. (**No el root**).

3. Si vas a utilizar características como el acceso VPN y Proxy, es altamente recomendable fijar la IP del equipo, puedes hacerlo desde tu router o [googleando cómo fijar la IP + **tu versión de SO**](https://www.google.com/search?q=ubuntu+20.04+static+ip+terminal&oq=fix+ip+misistemaoperativo).

4. Para poder conectar desde el exterior, por ejemplo a la VPN, es recomendable que cuentes con IP fija o en su defecto algún tipo de dominio dinámico.

* Una vez que hayas realizado la instalación, puedes indicarnos el resultado a través de un [issue](https://github.com/nmendezgranton/workbox/issues) con el título: "Resultado instalación - Arquitectura / SO versión" y conteniendo detalles o comentarios de tu instalación. Primero busca un issue referido a tu misma arquitectura, por favor.

Los resultados de las pruebas que recibamos se compilarán en [Pruebas](/pruebas/Pruebas.md).


### Para instalarlo

Para instalar workbox(code) con todas las funciones, inicia sesión por línea de comandos (o abre una terminal) y pega esto en el bash:

```
wget -O - https://nmg.systems/workbox/install | bash
```

La instalación puede demorar entre 4 y 20 minutos dependiendo del equipo. (Paciencia, prometido que vale la pena) 🧘‍♂️

**SHA 256 checksum**: 8cc2a8b89327090358cac06f4f7adcb8934f90875f5859070f434462e492c3dd
([¿Cómo comprobar la suma de verificación?](https://www.google.com/search?q=como+comprobar+sha+256+checksum))

## ¿Cómo utilizarlo?

### File server

Tras la instalación el servidor de archivos estará activo. Si en un ordenador con autodescubrimiento de redes activado te diriges a la carpeta de Red, lo verás ahí, esperando por tus archivos.

**Ten en cuenta**: Todas las carpetas de workbox son de acceso público de momento.


### Proxy

Por defecto, el Proxy está configurado para cachear contenido pero no limitar el acceso a ninguna categoría de sitios.
Cuando esté disponible el panel de control web puedes cambiar esta configuración.

Para usarlo, indica en la configuración de proxy de los equipos en los que quieras utilizarlo la siguiente información:

```
Servidor proxy: IP.DE.TU.WORKBOX
Puerto: 3128
```

**Importante**: No expongas el puerto de tu proxy al exterior! Con la configuración por defecto esto representa una vulnerabilidad de seguridad!


### VPN

Durante la instalación se crea un perfil de usuario para la VPN con el nombre de workbox_vpn.

Para poder conectarte a la VPN deberás:

1. Abrir el puerto 1194 en tu router y redireccionarlo a la IP del equipo.
2. Descargar OpenVPN en el dispositivo que quieras utilizar para conectar a la VPN.
3. Ingresando por la red al equipo, abre el archivo workbox_vpn.ovpn desde el directorio /workbox/Publico/VPN.
  1. Reemplaza la línea con el texto **remote my.remote.workbox.com.ar 1194** por **remote direccion_IP_publica_o_dominio_dinamico 1194** y guarda el archivo.
  2. Importa el archivo modificado en la aplicación OpenVPN.
  3. Conecta.

#### Problemas conocidos (VPN)

Si intentas conectarte desde otra red privada (detrás de un router) cuyo segmento de red coincide con el que usas en la red donde está el workbox no podrás conectarte.

Ej.: Si la red donde estás asigna direcciones IP **192.168.0.X** y la red donde está workbox asigna direcciones **192.168.0.X** no podrás conectar.


## Detalle de servicios

Accede a los [detalles](Servicios.md).


## Roadmap

Será un largo camino, pero valdrá la pena. Accede a los [detalles del roadmap](Roadmap.md).

## Cómo colaborar

Puedes colaborar con el proyecto y con ello contribuir a que crezca de varias maneras:

* Compartiéndolo con colegas para que lo conozcan y utilicen.
* Informando de errores, falta de documentación y otros a través de [issues](https://github.com/nmendezgranton/workbox/issues).
* Enviando resultados de tus pruebas en otras plataformas (sólo distros basadas en Debian de momento).
* Sugiriendo nuevas funciones y características a través de [issues](https://github.com/nmendezgranton/workbox/issues).


## Autores

* **NMG** - *Initial work* - [NMG](https://nicolasmendez.com.ar)


## Licencia

Ve al archivo [License](LICENSE) para ver derechos y limitaciones (GNU GPL v3).

Made in Argentina 🇦🇷 by ~~gauchos~~ nerds.
