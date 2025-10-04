# Quickstart

This guide helps you build the image and compile a LaTeX project in minutes.

## Prerequisites

- Docker installed
- A LaTeX project with a main file (default: `main.tex`)

## Build the image

Using the Makefile (builds and tags both the version and `latest` for Docker Hub and GHCR):

```sh
make
```

Customize namespaces or tag:

```sh
make build IMAGE_TAG=$(cat VERSION) \
  DOCKER_NAMESPACE=<dockerhub_user_or_org> GHCR_NAMESPACE=<ghcr_owner>
```

## Compile your project

From your project directory:

```sh
docker run --rm \
  -v "$(pwd)":/work \
  lbenicio/docker-latex:latest
```

The output PDF will be in `build/main.pdf` by default.

## VS Code tasks (optional)

Use the provided tasks to build/publish/run from VS Code’s Command Palette.
