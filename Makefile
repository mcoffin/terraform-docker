.DEFAULT_GOAL: build

DOCKER_PULL ?= false

DOCKER_EXE ?= docker
DOCKERFLAGS ?=

ifneq ($(DOCKER_PULL),false)
	DOCKERFLAGS += --pull
endif

build:
	$(DOCKER_EXE) build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION) --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-version .
	$(DOCKER_EXE) tag {mcoffin,seventy3dataco}/terraform:$(TF_VERSION)

build-source:
	$(DOCKER_EXE) build $(DOCKERFLAGS) -t mcoffin/terraform:$(TF_VERSION)-source --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-source .

build-alpine:
	$(DOCKER_EXE) build $(DOCKERFLAGS) -t mcoffin/terraform:alpine-$(shell date -u +'%Y%m%d' | tr -d '\n') .

all: build build-source

push: build
	for img in {mcoffin,seventy3dataco}/terraform:$(TF_VERSION); do $(DOCKER_EXE) push "$$img"; done

.PHONY: build build-source build-alpine all push
