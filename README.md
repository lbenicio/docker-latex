# docker-latex

A minimal, production-ready Docker image to compile LaTeX projects locally without installing TeX Live on your machine. It wraps `latexmk` with sane defaults and supports `pdflatex`, `xelatex`, and `lualatex`, plus `biber` when `biblatex` is detected.

## Features

- Based on Debian slim packages: fast and reliable
- Includes: `latexmk`, `biber`, common TeX Live packages
- Non-root user by default to avoid root-owned files on your host
- Simple entrypoint that auto-detects biber and supports shell-escape via env
- Small build contexts via `.dockerignore`

## Quick start

1. Place your LaTeX project in a folder with a `main.tex` (or specify `MAIN_TEX`).
1. Build the image:

```sh
# from repository root
# using Makefile
make build IMAGE_NAME=docker-latex IMAGE_TAG=latest

# or directly with docker, referencing src/Dockerfile
docker build -f src/Dockerfile -t docker-latex:latest .
```

1. Compile your project, mounting the current folder as `/work`:

```sh
docker run --rm \
  -v "$(pwd)":/work \
  docker-latex:latest
```

The PDF will be at `build/main.pdf` by default.

### VS Code tasks

This repo includes VS Code tasks to build, publish, and run the image:

- Run: Terminal > Run Task… > pick one of
  - docker: build (Makefile)
  - docker: build (direct)
  - docker: publish
  - docker: run

You’ll be prompted for the image name/tag (defaults provided).

## Customization

Environment variables (all optional):

- `MAIN_TEX`: entry .tex file (default: `main.tex`)
- `OUTDIR`: output directory (default: `build`)
- `ENGINE`: `pdflatex` | `xelatex` | `lualatex` (default: `pdflatex`)
- `LATEXMK_OPTS`: extra flags passed to `latexmk`
- `TEX_SHELL_ESCAPE`: set to `1` to enable `-shell-escape`

Examples:

```sh
# Use xelatex and custom main file
docker run --rm -v "$(pwd)":/work -e ENGINE=xelatex -e MAIN_TEX=thesis.tex docker-latex

# Change output directory
docker run --rm -v "$(pwd)":/work -e OUTDIR=out docker-latex

# Pass arbitrary latexmk arguments (overrides defaults when provided)
docker run --rm -v "$(pwd)":/work docker-latex -pdf -C  # clean
```

## Non-root and file ownership

The container runs as a non-root user. Files created in the mounted folder will
be owned by that user (UID 1000 by default). If your host user has a different
UID, you can build the image with matching UID/GID:

```sh
docker build \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  -t docker-latex .
```

Alternatively, override at runtime if your Docker supports `--user`:

```sh
docker run --rm \
  --user $(id -u):$(id -g) \
  -v "$(pwd)":/work \
  docker-latex
```

## Notes

- Installed TeX Live packages cover many common templates. For exotic packages,
  extend the `apt-get install` line in the Dockerfile.
- If your project requires shell-escape (e.g., minted), set `-e TEX_SHELL_ESCAPE=1`.
- To clean artifacts: `docker run --rm -v "$(pwd)":/work docker-latex -C`.

## License

This project is licensed under the GNU General Public License v3.0 only
(SPDX: GPL-3.0-only). See the `LICENSE.txt` file for the full text.
