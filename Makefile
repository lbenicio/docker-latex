# Simple Makefile to build, clean, and publish the docker-latex image

IMAGE_NAME ?= docker-latex
# Read default tag from VERSION file if present, fallback to 'latest'
VERSION_FILE := $(CURDIR)/VERSION
DEFAULT_TAG := $(shell [ -f $(VERSION_FILE) ] && cat $(VERSION_FILE) || echo latest)
IMAGE_TAG ?= $(DEFAULT_TAG)
IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)
IMAGE_LATEST := $(IMAGE_NAME):latest

DOCKERFILE := src/Dockerfile
BUILD_ARGS ?= \
	--build-arg UID=$(shell id -u) \
	--build-arg GID=$(shell id -g) \
	--build-arg VERSION=$(IMAGE_TAG)

.PHONY: build clean publish help version

help:
	@echo "Targets:"
	@echo "  build    Build the image (IMAGE_NAME, IMAGE_TAG configurable)"
	@echo "  clean    Remove local image"
	@echo "  publish  Push image to registry (requires you to be logged in)"
	@echo "  help     Show this help"
	@echo "  version  Print version from VERSION file"

build:
	docker build -f $(DOCKERFILE) $(BUILD_ARGS) -t $(IMAGE) -t $(IMAGE_LATEST) .

clean:
	- docker rmi $(IMAGE) || true
	- docker rmi $(IMAGE_LATEST) || true

publish:
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)

version:
	@echo $(DEFAULT_TAG)
