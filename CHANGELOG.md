# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-01-01

### Changes

- feat: add permissions section to markdownlint workflow for clarity (afab238)
- feat: implement local release script and update Makefile and documentation for versioning (d7c9456)
- feat: update Docker Hub login conditions to use environment variables (7641ee0)
- feat: enhance Docker build and publish summaries with structured output (3227193)
- feat: enhance documentation with comprehensive guides on build, publish, usage, configuration, and troubleshooting (7ff0556)
- feat: update Makefile to set default target and enhance help output; add GitHub Actions workflow for publishing Docker images (0918a5a)
- feat: add GitHub Actions workflows for Docker build, Markdown linting, and Telegram notifications (a843e25)
- feat: disable Docker BuildKit for compatibility and improve group creation in Dockerfile (ac692d4)
- feat: add Makefile task for publishing Docker images to both Docker Hub and GHCR (0fc47f7)
- feat: enhance Docker build and publish process with support for GHCR and namespace configuration (8bef6fb)
- feat: enhance Docker build process by adding support for latest tag and versioning (b82e809)
- feat: add issue templates for bug reports and feature requests, and a pull request template (aec0446)

### Added

- Makefile with build/clean/publish targets
- SECURITY.md with responsible disclosure policy
- CONTRIBUTING.md with contribution guidelines
- Moved Docker build sources into `src/` directory

### Changed

- README updated to reference `src/Dockerfile` and Makefile workflow

## [0.1.0] - 2025-10-04

### Initial

- Production-ready `Dockerfile` with TeX Live packages, non-root user, and entrypoint
- `entrypoint.sh` wrapping `latexmk` with sane defaults and engine selection
- `.dockerignore` to minimize build context
- Initial `README.md` with usage instructions
