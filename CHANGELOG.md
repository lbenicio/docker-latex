# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
