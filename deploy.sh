#!/bin/bash

DOCKER_USER=$3
DOCKER_PASSWORD=$4

# exclui o container backend
docker rm -f backend

# Exclui o container frontend
docker rm -f frontend

# Exclui a imagem do backend
docker rmi $(docker images | grep 'backend-mysql') -f

# Exclui a imagem do frontend
docker rmi $(docker images | grep 'frontend-php') -f

# Builda as imagens
docker build ./backend -t backend-mysql:$1
docker build ./frontend -t frontend-php:$2

if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PASSWORD" ]; then
	# Taggeia o container
	docker tag backend-mysql:$1 $DOCKER_USER/backend-mysql:$1
	docker tag frontend-php:$2 $DOCKER_USER/frontend-php:$2

	# Faz o login no DockerHub
	docker login -u="$DOCKER_USER" -p="$DOCKER_PASSWORD"

	# Faz o push para o DockerHub
	docker push $DOCKER_USER/backend-mysql:$1
	docker push $DOCKER_USER/frontend-php:$2
fi

# Roda o banco:
docker run -d --rm --name backend -e MYSQL_DATABASE=demo -e MYSQL_ALLOW_EMPTY_PASSWORD=yes backend-mysql:$1

# Roda o front:
docker run -d --rm --name frontend -p 80:80 --link backend frontend-php:$2

ECHO "Para testar a aplicação acesse o endereço: http://localhost ou http://192.168.99.100/";
