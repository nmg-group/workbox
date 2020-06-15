# workbox(code)

workbox(code) es un gestor de servidores basado en Debian Linux super simple de utilizar.

### ¿Por qué (code)?

Simple. No tenemos autorización para usar la marca workbox y está registrada en Argentina.

## ¿Como instalarlo?

### Pre-requisitos

1. De momento sólo está soportado y probado con Ubuntu Server (testeado v. 20.04).
Link: https://ubuntu.com/download/server

2. Un usuario con privilegios sudo. (**No el root**).

3. Si vas a utilizar características como el acceso VPN y Proxy, es altamente recomendable fijar la IP del equipo, puedes hacerlo desde tu router o [googleando cómo fijar la IP + **tu versión de SO**](https://www.google.com/search?q=ubuntu+20.04+static+ip+terminal&oq=ubuntu+20.04+fix+ip+terminal).


### Para instalarlo

Para instalar workbox(code) con todas las funciones, inicia sesión por línea de comandos (o abre una terminal) y pega esto en el bash:

```
wget -O - https://workbox.com.ar/install | bash
```

A continuación te solicitará el ingreso de un usuario de Github con acceso y posteriormente la clave del usuario con privilegios Sudo.

Grab a coffee ☕


## Cómo utilizarlo

### File server

Tras la instalación el servidor de archivos estará activo. Si en un ordenador con autodescubrimiento de redes activado te diriges a la carpeta de Red, lo verás ahí, esperando por tus archivos.

**Ten en cuenta**: Todas las carpetas de workbox son de acceso público de momento.


### Proxy

Por defecto, el Proxy está configurado para cachear contenido pero no limitar el acceso a ninguna categoría de sitios.
Cuando esté disponible el panel de control web puedes cambiar esta configuración.




## Autores

* **NMG** - *Initial work* - [NMG](https://nicolasmendez.com.ar)

## Licencia

Todavía nada.
