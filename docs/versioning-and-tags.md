# Versioning and tags

## VERSION file

- Single source of truth for the image version used by the Makefile and Dockerfile labels.

## Tagging strategy

- Each build produces:
  - `<namespace>/docker-latex:<version>`
  - `<namespace>/docker-latex:latest`
  - `ghcr.io/<namespace>/docker-latex:<version>`
  - `ghcr.io/<namespace>/docker-latex:latest`

## Releases

- GitHub release tag (e.g., `v0.2.0`) is used as image tag (without `v`).
- Publish workflow pushes both `:<version>` and `:latest` tags.
