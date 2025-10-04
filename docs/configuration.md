# Configuration

## Build-time arguments

- UID: host user id (default: 1000)
- GID: host group id (default: 1000)
- VERSION: image version label (passed from Makefile)

Example:

```sh
docker build -f src/Dockerfile \
  --build-arg UID=$(id -u) --build-arg GID=$(id -g) \
  --build-arg VERSION=$(cat VERSION) \
  -t lbenicio/docker-latex:$(cat VERSION) .
```

## Makefile variables

- IMAGE_NAME: default `docker-latex`
- IMAGE_TAG: defaults to `VERSION` file value or `latest`
- DOCKER_NAMESPACE: Docker Hub namespace (default: `lbenicio`)
- GHCR_NAMESPACE: GHCR namespace (default: `lbenicio`)

Example:

```sh
make build IMAGE_TAG=$(cat VERSION) \
  DOCKER_NAMESPACE=<dockerhub_user_or_org> GHCR_NAMESPACE=<ghcr_owner>
```
