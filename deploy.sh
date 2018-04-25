#!/bin/bash

VERSION="0.1"

# exclui o container backend
docker rm -f backend

# Exclui o container frontend
docker rm -f frontend

# Exclui a imagem do backend
docker rmi $(docker images | grep 'backend-mysql')

# Exclui a imagem do frontend
docker rmi $(docker images | grep 'frontend-php')

# Builda as imagens
docker build ./backend -t backend-mysql:$VERSION
docker build ./frontend -t frontend-php:$VERSION

# Roda o banco:
docker run -d --rm --name backend -e MYSQL_DATABASE=demo -e MYSQL_ALLOW_EMPTY_PASSWORD=yes backend-mysql:$VERSION

# Roda o front:
docker run -d --rm --name frontend -p 80:80 --link backend frontend-php:$VERSION

ECHO "Para utilizar a aplicação entre no endereço: http://192.168.99.100/";