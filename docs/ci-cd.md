# CI/CD

Two GitHub Actions workflows are provided:

## Build workflow

- Path: `.github/workflows/build.yml`
- Triggers: push to `main`, pull requests to `main`, manual dispatch
- Behavior:
  - Uses classic Docker builder (DOCKER_BUILDKIT=0)
  - Builds via Makefile for both registries and tags
  - Adds a job summary including version, images, size, and duration
- Concurrency: per-ref, cancel in progress

## Publish workflow

- Path: `.github/workflows/publish.yml`
- Trigger: release published
- Behavior:
  - Resolves tag from release (strips `v`), else VERSION, else `latest`
  - Logs into GHCR with GITHUB_TOKEN; Docker Hub with secrets if provided
  - Builds via Makefile, pushes both registries (version and `latest`)
  - Adds a job summary with images, IDs, sizes, and duration
- Concurrency: per-ref, cancel in progress

## Local release script

For local releases without waiting for the yearly workflow, use:

```sh
scripts/release.sh <major|minor|patch>
```

What it does:

- Bumps the VERSION accordingly
- Generates a CHANGELOG entry from commits since last release
- Commits, tags, pushes, and creates a GitHub release

Requirements:

- git with push permissions
- Either GitHub CLI (gh) authenticated or GITHUB_TOKEN exported for API fallback
