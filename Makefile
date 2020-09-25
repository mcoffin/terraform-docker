.DEFAULT_GOAL: build

DOCKER_PULL ?= false

DOCKERFLAGS ?=

ifneq ($(DOCKER_PULL),false)
	DOCKERFLAGS += --pull
endif

build:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION) --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-version .

build-source:
	docker build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION)-source --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-source .

all: build build-source

.PHONY: build build-source all
