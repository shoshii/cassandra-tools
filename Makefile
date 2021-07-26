VERSION=4.0.1
DOCKER_ID?=shoshii
REPO=${DOCKER_ID}/cassandra-tools

all: build

container:
	@echo "Building ${REPO}:${VERSION}"
	docker build --pull -t ${REPO}:${VERSION} .

build: container

run:
	docker run -it --rm --name=tools -e LOCAL_UNAME=${DOCKER_ID} -e LOCAL_UID=`id -u ${DOCKER_ID}` -e LOCAL_GID=`id -g ${DOCKER_ID}` ${REPO}:${VERSION} /bin/bash

stop:
	docker ps | grep ${REPO}:${VERSION} | cut -d " " -f 1 | xargs docker stop || echo 'failed to stop'
	docker rm cassandra

push:
	docker -- push ${REPO}:${VERSION}

.PHONY: all build run stop push