#!/bin/bash

DOCKER_USER=$2
DOCKER_PASSWORD=$3

# Exclui o container frontend
docker rm -f frontend

# Exclui a imagem do frontend
docker rmi $(docker images | grep 'frontend-php')

# Builda a imagem
docker build ./frontend -t frontend-php:$1

if [ -n "$DOCKER_USER" ] && [ -n "$DOCKER_PASSWORD" ]; then
	# Taggeia o container
	docker tag frontend-php:$1 $DOCKER_USER/frontend-php:$1

	# Faz o login no DockerHub
	docker login -u="$DOCKER_USER" -p="$DOCKER_PASSWORD"

	# Faz o push para o DockerHub
	docker push $DOCKER_USER/frontend-php:$1
fi

# Roda o front:
docker run -d --rm --name frontend -p 80:80 --link backend frontend-php:$1

ECHO "Para testar a aplicação acesse o endereço: http://localhost ou http://192.168.99.100/";