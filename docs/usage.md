# Usage

docker-latex wraps `latexmk` with sane defaults and a helpful entrypoint.

## Environment variables

- MAIN_TEX: entry .tex file (default: `main.tex`)
- OUTDIR: output directory (default: `build`)
- ENGINE: `pdflatex` | `xelatex` | `lualatex` (default: `pdflatex`)
- LATEXMK_OPTS: extra flags passed to `latexmk`
- TEX_SHELL_ESCAPE: set to `1` to enable `-shell-escape`

## Examples

Use XeLaTeX:

```sh
docker run --rm -v "$(pwd)":/work -e ENGINE=xelatex lbenicio/docker-latex
```

Custom main file and output dir:

```sh
docker run --rm -v "$(pwd)":/work -e MAIN_TEX=thesis.tex -e OUTDIR=out lbenicio/docker-latex
```

Pass raw latexmk options (overrides defaults when provided):

```sh
docker run --rm -v "$(pwd)":/work lbenicio/docker-latex -pdf -C
```
