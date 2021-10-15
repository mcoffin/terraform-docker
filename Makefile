.DEFAULT_GOAL: build

DOCKER_PULL ?= false

DOCKERFLAGS ?=

ifneq ($(DOCKER_PULL),false)
	DOCKERFLAGS += --pull
endif

build:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION) --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-version .
	docker tag {mcoffin,seventy3dataco}/terraform:$(TF_VERSION)

build-source:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION)-source --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-source .

build-alpine:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:alpine-$(shell date -u +'%Y%m%d' | tr -d '\n') .

all: build build-source

push: build
	for img in {mcoffin,seventy3dataco}/terraform:$(TF_VERSION); do docker push "$$img"; done

.PHONY: build build-source build-alpine all push
