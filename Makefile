.DEFAULT_GOAL: build

.PHONY: build

build:
	docker build -t mcoffin/terraform:$(TF_VERSION) --build-arg TF_VERSION=$(TF_VERSION) -f Dockerfile-version .
