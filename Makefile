JENKINS_VER ?= 2.112

REPO = wodby/jenkins
NAME = jenkins-$(JENKINS_VER)

TAG ?= $(JENKINS_VER)
BASE_IMAGE_TAG = $(JENKINS_VER)-alpine

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) ./

test:
	./test $(REPO):$(TAG)

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) $(PARAMS) -ti $(REPO):$(TAG) /bin/bash

# PARAMS="-v /var/run/docker.sock:/var/run/docker.sock"
run:
	docker run --rm --name $(NAME) $(PARAMS) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PARAMS) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
