-include env_make

VERSION ?= 2.46

REPO = wodby/jenkins
NAME = jenkins-2.46

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(VERSION) ./

test:
	./test.sh $(NAME) $(REPO):$(VERSION)

push:
	docker push $(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build
	make push -e VERSION=$(VERSION)
