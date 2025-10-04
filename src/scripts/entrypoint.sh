#!/usr/bin/env bash
set -euo pipefail

# latexmk entrypoint wrapper with sane defaults
# Env vars:
# - MAIN_TEX: main tex file (default: main.tex)
# - OUTDIR: output directory (default: build)
# - ENGINE: pdflatex|xelatex|lualatex (default: pdflatex)
# - LATEXMK_OPTS: extra latexmk options
# - UID/GID: can be passed at build time; at runtime the container uses the non-root user already

MAIN_TEX=${MAIN_TEX:-main.tex}
OUTDIR=${OUTDIR:-build}
ENGINE=${ENGINE:-pdflatex}
LATEXMK_OPTS=${LATEXMK_OPTS:-"-file-line-error -interaction=nonstopmode"}

# Map ENGINE to latexmk flags
ENGINE_FLAG="-pdf"
case "$ENGINE" in
  xelatex) ENGINE_FLAG="-xelatex" ;;
  lualatex) ENGINE_FLAG="-lualatex" ;;
  pdflatex|pdftex) ENGINE_FLAG="-pdf" ;;
  *) echo "Unknown ENGINE '$ENGINE'. Use pdflatex|xelatex|lualatex." >&2; exit 2 ;;

esac

mkdir -p "$OUTDIR"

# If the user passes explicit args, prefer them; otherwise run sane default
if [[ $# -gt 0 ]]; then
  exec latexmk "$@"
else
  # Enable shell-escape if project requests it via TEX_SHELL_ESCAPE=1
  SHELL_ESCAPE_FLAG=""
  if [[ "${TEX_SHELL_ESCAPE:-0}" == "1" ]]; then
    SHELL_ESCAPE_FLAG="-shell-escape"
  fi

  # biber detection: if .bcf exists or biber is referenced in .tex, allow it
  BIBER_FLAG=""
  if compgen -G "*.bcf" > /dev/null || grep -Rqs "\\\usepackage\{biblatex\}" .; then
    BIBER_FLAG="-usebiber"
  fi

  exec latexmk $ENGINE_FLAG -outdir="$OUTDIR" $SHELL_ESCAPE_FLAG $BIBER_FLAG $LATEXMK_OPTS "$MAIN_TEX"
fi
