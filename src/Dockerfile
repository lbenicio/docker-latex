# Minimal, production-ready LaTeX build image
# - Installs latexmk, biber, and common TeX Live packages
# - Non-root user by default; support running with host UID/GID
# - Sensible defaults via ENV; entrypoint orchestrates latexmk

FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="docker-latex"
LABEL org.opencontainers.image.description="Small LaTeX build container with latexmk/biber"
LABEL org.opencontainers.image.source="https://github.com/lbenicio/docker-latex"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
ARG VERSION=dev
LABEL org.opencontainers.image.version="${VERSION}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# Install TeX Live core components and tools
# Note: This is a balanced set to support most documents without going full TeX Live
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       make \
       perl \
       ghostscript \
       latexmk \
       biber \
       texlive-binaries \
       texlive-latex-recommended \
       texlive-latex-extra \
       texlive-fonts-recommended \
       texlive-fonts-extra \
       texlive-bibtex-extra \
       texlive-science \
       texlive-xetex \
       texlive-luatex \
       lmodern \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create an unprivileged user that owns the working directory
ARG UID=1000
ARG GID=1000
ARG USER=latex
ARG GROUP=latex
RUN groupadd -g "$GID" "$GROUP" \
    && useradd -m -u "$UID" -g "$GID" -s /bin/bash "$USER"

WORKDIR /work

# Copy entrypoint
COPY --chown=${UID}:${GID} src/scripts/entrypoint.sh /usr/local/bin/latexmk-entrypoint
RUN chmod +x /usr/local/bin/latexmk-entrypoint

# Defaults can be overridden at runtime
ENV MAIN_TEX=main.tex \
    OUTDIR=build \
    ENGINE=pdflatex \
    LATEXMK_OPTS="-file-line-error -interaction=nonstopmode"

USER ${USER}

ENTRYPOINT ["latexmk-entrypoint"]
CMD []
