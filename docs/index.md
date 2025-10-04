# docker-latex documentation

Production-ready Docker image for building LaTeX projects with latexmk and biber. It provides sane defaults, a non-root user, and simple workflows for local and CI/CD use.

## Highlights

- Tiny, focused Debian base with TeX Live essentials
- latexmk orchestration with auto biber detection
- Non-root user by default; host UID/GID configurable at build time
- Dual tagging and multi-registry support (Docker Hub and GHCR)
- Makefile-driven developer experience and CI workflows

## Documents

- Quickstart: getting up and running fast
  - See: [quickstart.md](quickstart.md)
- Usage and runtime options
  - See: [usage.md](usage.md)
- Configuration (env vars and build args)
  - See: [configuration.md](configuration.md)
- Image reference and internals
  - See: [reference.md](reference.md)
- Build and publish (local + registries)
  - See: [build-and-publish.md](build-and-publish.md)
- CI/CD (build and publish workflows)
  - See: [ci-cd.md](ci-cd.md)
- Versioning and tags
  - See: [versioning-and-tags.md](versioning-and-tags.md)
- Troubleshooting and known issues
  - See: [troubleshooting.md](troubleshooting.md)
- Frequently asked questions
  - See: [faq.md](faq.md)
- Security and maintenance
  - See: [security-and-compliance.md](security-and-compliance.md)
- Examples
  - See: [examples/README.md](examples/README.md)
