#!/bin/bash

DOCKER_USER=$2
DOCKER_PASSWORD=$3

# exclui o container backend
docker rm -f backend

# Exclui a imagem do backend
docker rmi $(docker images | grep 'backend-mysql')

# Builda a imagem
docker build ./backend -t backend-mysql:$1

if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PASSWORD" ]; then
	# Taggeia o container
	docker tag backend-mysql:$1 $DOCKER_USER/backend-mysql:$1

	# Faz o login no DockerHub
	docker login -u="$DOCKER_USER" -p="$DOCKER_PASSWORD"

	# Faz o push para o DockerHub
	docker push $DOCKER_USER/backend-mysql:$1
fi

# Roda o banco:
docker run -d --rm --name backend -e MYSQL_DATABASE=demo -e MYSQL_ALLOW_EMPTY_PASSWORD=yes backend-mysql:$1
