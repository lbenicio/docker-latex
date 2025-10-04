# Simple Makefile to build, clean, and publish the docker-latex image

IMAGE_NAME ?= docker-latex
# Namespaces for registries (override as needed)
DOCKER_NAMESPACE ?= lbenicio
GHCR_NAMESPACE ?= lbenicio

# Read default tag from VERSION file if present, fallback to 'latest'
VERSION_FILE := $(CURDIR)/VERSION
DEFAULT_TAG := $(shell [ -f $(VERSION_FILE) ] && cat $(VERSION_FILE) || echo latest)
IMAGE_TAG ?= $(DEFAULT_TAG)

# Fully-qualified image names
DOCKER_IMAGE := $(DOCKER_NAMESPACE)/$(IMAGE_NAME)
GHCR_IMAGE := ghcr.io/$(GHCR_NAMESPACE)/$(IMAGE_NAME)

IMAGE := $(DOCKER_IMAGE):$(IMAGE_TAG)
IMAGE_LATEST := $(DOCKER_IMAGE):latest
IMAGE_GHCR := $(GHCR_IMAGE):$(IMAGE_TAG)
IMAGE_GHCR_LATEST := $(GHCR_IMAGE):latest

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
	DOCKER_BUILDKIT=0 docker build -f $(DOCKERFILE) $(BUILD_ARGS) \
		-t $(IMAGE) \
		-t $(IMAGE_LATEST) \
		-t $(IMAGE_GHCR) \
		-t $(IMAGE_GHCR_LATEST) \
		.

clean:
	- docker rmi $(IMAGE) || true
	- docker rmi $(IMAGE_LATEST) || true
	- docker rmi $(IMAGE_GHCR) || true
	- docker rmi $(IMAGE_GHCR_LATEST) || true

publish:
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)
	docker push $(IMAGE_GHCR)
	docker push $(IMAGE_GHCR_LATEST)

version:
	@echo $(DEFAULT_TAG)
