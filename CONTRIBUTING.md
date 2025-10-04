# Contributing to docker-latex

Thanks for your interest in improving this project!

## Code of Conduct

Please read and follow our [Code of Conduct](./CODE_OF_CONDUCT.md).

## How to propose changes

1. Discuss: Open an issue or discussion describing the problem or idea.
2. Fork and branch: Create a feature branch from `main`.
3. Make focused changes: Keep diffs small and scoped.
4. Tests/docs: Update docs and include small examples where helpful.
5. Pull Request: Open a PR with a clear description and checklist completed.

## Development setup

- Docker is required to build and run the image locally
- Primary Dockerfile lives at `src/Dockerfile`
- Entrypoint is `src/docker/entrypoint.sh`
- Convenience tasks available via `Makefile`

Common workflows:

```sh
# Build with Makefile
make build IMAGE_NAME=docker-latex IMAGE_TAG=dev

# Build directly with docker
docker build -f src/Dockerfile -t docker-latex:dev .

# Run the image against the current directory
docker run --rm -v "$(pwd)":/work docker-latex:dev
```

## Style and conventions

- Keep Dockerfile layers minimal; prefer `--no-install-recommends`
- Use non-root user and avoid privileged operations
- Document new environment variables and defaults in README
- Maintain `.dockerignore` to keep build contexts small
- Markdown: wrap lines ~80-100 chars where practical; follow markdownlint

## Pull Request checklist

- [ ] Title and description explain the change and motivation
- [ ] Updated `README.md` if behavior or usage changes
- [ ] Updated `CHANGELOG.md` (Unreleased section)
- [ ] No secrets, tokens, or private data included
- [ ] Build works: `make build` or `docker build -f src/Dockerfile ...`

## Security

Please report potential vulnerabilities privately. See [SECURITY.md](./SECURITY.md).

## License

By contributing, you agree that your contributions will be licensed under the
project’s current license (see `LICENSE.txt`).
