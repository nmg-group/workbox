# workbox(code)

workbox(code) es un gestor de servidores basado en Debian Linux super-super-super-super-super simple de utilizar.

## Misión workbox(code)

Tomar un montón de software libre y gratuito absolutamente genial, bien mantenido y de grado enterprise pero complejos en general de instalar/administrar/mantener; y empaquetarlo con librerías que bajen la barrera técnica de acceso a estos servicios, facilitando el uso.

**¿Por qué "(code)"?**

Simple. No tenemos autorización para usar la marca workbox y está registrada en Argentina (donde nació el proyecto).

## ¿Como instalarlo?

### Pre-requisitos

1. De momento sólo está soportado y probado sobre Ubuntu (testeado sobre Ubuntu server v. 20.04). No requiere interfaz gráfica.
Link: https://ubuntu.com/download

2. Un usuario con privilegios sudo. (**No el root**).

3. Si vas a utilizar características como el acceso VPN y Proxy, es altamente recomendable fijar la IP del equipo, puedes hacerlo desde tu router o [googleando cómo fijar la IP + **tu versión de SO**](https://www.google.com/search?q=ubuntu+20.04+static+ip+terminal&oq=ubuntu+20.04+fix+ip+terminal).

4. Para poder conectar desde el exterior, por ejemplo a la VPN, es recomendable que cuentes con IP fija o en su defecto algún tipo de dominio dinámico.

* Una vez que hayas realizado la instalación, puedes indicarnos el resultado a través de un [issues](https://github.com/nmendezgranton/workbox/issues) con el título: "Resultado instalación - Arquitectura / SO versión" y conteniendo detalles o comentarios de tu instalación. Primero busca un issue referido a tu misma arquitectura, por favor.

Los resultados de las pruebas que recibamos se compilarán en [Pruebas](/pruebas/Pruebas.md).


### Para instalarlo

Para instalar workbox(code) con todas las funciones, inicia sesión por línea de comandos (o abre una terminal) y pega esto en el bash:

```
wget -O - https://workbox.com.ar/install | bash
```

A continuación te solicitará probablemente la clave del usuario para utilizar sudo, y posteriormente el ingreso de un usuario de Github con acceso al repo.

La instalación puede demorar entre 4 y 20 minutos dependiendo del equipo. (Paciencia, prometido que vale la pena) 🧘‍♂️

**SHA 256 checksum**: 07c5952fc5ebb2ac3d8b4d23b949e83bb6d4d0794ff99f21a5a3cb96efab914d

## ¿Cómo utilizarlo?

### File server

Tras la instalación el servidor de archivos estará activo. Si en un ordenador con autodescubrimiento de redes activado te diriges a la carpeta de Red, lo verás ahí, esperando por tus archivos.

**Ten en cuenta**: Todas las carpetas de workbox son de acceso público de momento.


### Proxy

Por defecto, el Proxy está configurado para cachear contenido pero no limitar el acceso a ninguna categoría de sitios.
Cuando esté disponible el panel de control web puedes cambiar esta configuración.


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
* Enviando resultados de tus pruebas en otras plataformas (sólo distros de Linux de momento).
* Sugiriendo nuevas funciones y características a través de [issues](https://github.com/nmendezgranton/workbox/issues).


## Autores

* **NMG** - *Initial work* - [NMG](https://nicolasmendez.com.ar)


## Licencia

Todavía nada.
