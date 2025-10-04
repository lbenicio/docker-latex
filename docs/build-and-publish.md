# Build and publish

This project supports dual tagging and multi-registry publishing (Docker Hub and GHCR).

## Local build

```sh
make
```

Equivalent direct build:

```sh
docker build -f src/Dockerfile \
  -t <dockerhub_ns>/docker-latex:$(cat VERSION) \
  -t <dockerhub_ns>/docker-latex:latest \
  -t ghcr.io/<ghcr_ns>/docker-latex:$(cat VERSION) \
  -t ghcr.io/<ghcr_ns>/docker-latex:latest \
  .
```

## Publish

```sh
make publish DOCKER_NAMESPACE=<dockerhub_ns> GHCR_NAMESPACE=<ghcr_ns> IMAGE_TAG=$(cat VERSION)
```

### Authentication

- Docker Hub: `docker login`
- GHCR: `echo <TOKEN> | docker login ghcr.io -u <USERNAME> --password-stdin`

Both `:<version>` and `:latest` are pushed for both registries.
