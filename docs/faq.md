# FAQ

## Why non-root by default?

To avoid root-owned files on the host and to follow least privilege.

## How do I match host ownership?

Build with matching UID/GID build args or run the container with `--user $(id -u):$(id -g)`.

## Can I run arbitrary latexmk flags?

Yes. Provide arguments after the image name; the entrypoint forwards them.

## Does it support XeLaTeX and LuaLaTeX?

Yes. Set `ENGINE=xelatex` or `ENGINE=lualatex`.
