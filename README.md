# webstack Apple chip

NGINX WebStack

## Getting started

### Correr el siguiente comando para la configuración inicial.

```bash

cd docker
cp docker-compose.default.yml docker-compose.yml

```

Puede modificar **docker-compose.yml** como desee, una vez modificado, ejecute el siguiente comando:

```bash

docker-compose up -d

```

## Servicios expuestos

Los siguientes servicios son accesibles desde el exterior del contenedor:

|          | **NGINX** | **MySQL** |
| -------- | --------- | --------- |
| **PORT** | 80, 443   | 3306      |

## ¿Cómo cambiar la versión de PHP?

PHP 7 es la versión predeterminada.
Puede cambiar la versión de PHP ejecutando los siguientes comandos desde el interior del contenedor:

### Establecer PHP 7.2

```bash

/docker-files/set-php.sh 7

```

### Establecer PHP 5.6

```bash

/docker-files/set-php.sh 6

```
