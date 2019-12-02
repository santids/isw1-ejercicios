# TusLibros

## Usuarios de prueba

Se pueden usar los siguientes usuarios:

- "Tobi", password "password", es un usuario que funciona normalmente
- "Santi", password "1234", es un usuario con una tarjeta expirada

## Servidor

En esta carpeta, se encuentra el archivo `TusLibros-Model.st` con el servidor en Smalltalk. Para crear el servidor abrir un workspace y ejecutar:

```smalltalk
server := TusLibrosRESTController listeningOn: 8080.
```

El servidor se queda escuchando en el puerto `8080`.
En caso de querer detener el servidor:

```smalltalk
server destroy.
```

## Cliente
Hay dos formas de ejecutar/modificar el cliente:

### file://
Se puede abrir el archivo `index.html` directamente en el browser. En este archivo está todo el código JavaScript.
Ante una modificación en el código se debe refrescar el browser.

### http://
Con esta forma se puede utilizar el proyecto de manera modularizada. Es decir, el código JavaScript está en la carpeta `/src`. Los componentes (React Components) están en `/src/components`. El archivo (template) `html` está en `templates/_index.html`.
Todo esto se _compila_ ejecutando `python ./scripts/compiler.py` y el resultado es el archivo `index.html`

#### Requisitos
- Python3
- El paquete [`websockets`](https://websockets.readthedocs.io/en/stable/intro.html)

#### Servidor del cliente
Para ejecutar el servidor (del cliente) desde una terminal ejecutar:
```shell-session
./server.sh
```
El cliente se accede desde `http://localhost:8081`

