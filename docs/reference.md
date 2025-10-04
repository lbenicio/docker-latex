# Image reference

## Base image

- debian:bookworm-slim

## Installed components

- latexmk, biber
- texlive-binaries, latex essentials, xetex, luatex
- extra fonts and bibtex extras, science

## Entrypoint

- Path: `/usr/local/bin/latexmk-entrypoint`
- Behavior:
  - Maps ENGINE env to latexmk flags: `-pdf` | `-xelatex` | `-lualatex`
  - Auto-detects `biblatex` and enables `biber` via `-usebiber`
  - Honors `TEX_SHELL_ESCAPE=1` for `-shell-escape`
  - Runs `latexmk -outdir=$OUTDIR` with defaults or passes user-provided args directly

## User and permissions

- Non-root user created at build (`USER=latex`, configurable UID/GID)
- Working directory: `/work`
- COPY uses `--chown=${UID}:${GID}` to ensure correct ownership
