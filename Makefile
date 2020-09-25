.DEFAULT_GOAL: build

DOCKER_PULL ?= false

DOCKERFLAGS ?=

ifneq ($(DOCKER_PULL),false)
	DOCKERFLAGS += --pull
endif

.PHONY: build

build:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION) --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-version .
