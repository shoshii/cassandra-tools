VERSION=4.0.1
DOCKER_ID?=shoshii
UNAME=shoshii
REPO=${DOCKER_ID}/cassandra-tools

all: build

container:
	@echo "Building ${REPO}:${VERSION}"
	docker build --pull -t ${REPO}:${VERSION} .

build: container

run:
	docker run -it --rm --name=tools -v /Users/${UNAME}:/home/${UNAME} -e LOCAL_UNAME=${UNAME} -e LOCAL_UID=`id -u ${UNAME}` -e LOCAL_GID=`id -g ${UNAME}` ${REPO}:${VERSION} /bin/bash

stop:
	docker ps | grep ${REPO}:${VERSION} | cut -d " " -f 1 | xargs docker stop || echo 'failed to stop'
	docker rm cassandra

push:
	docker -- push ${REPO}:${VERSION}

.PHONY: all build run stop push