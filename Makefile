# Simple Makefile to build, clean, and publish the docker-latex image

IMAGE_NAME ?= docker-latex
IMAGE_TAG ?= latest
IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)

DOCKERFILE := src/Dockerfile
BUILD_ARGS ?= \
	--build-arg UID=$(shell id -u) \
	--build-arg GID=$(shell id -g)

.PHONY: build clean publish help

help:
	@echo "Targets:"
	@echo "  build    Build the image (IMAGE_NAME, IMAGE_TAG configurable)"
	@echo "  clean    Remove local image"
	@echo "  publish  Push image to registry (requires you to be logged in)"
	@echo "  help     Show this help"

build:
	docker build -f $(DOCKERFILE) $(BUILD_ARGS) -t $(IMAGE) .

clean:
	- docker rmi $(IMAGE)

publish:
	docker push $(IMAGE)
