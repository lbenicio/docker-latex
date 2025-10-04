# Troubleshooting

## Build fails with groupadd: GID already exists

Fixed by making group creation idempotent. If you override GID, ensure it doesn't collide with system groups.

## Build uses buildx/BuildKit unexpectedly

The Makefile forces DOCKER_BUILDKIT=0. Ensure your direct commands or CI set the same if needed.

## minted or other packages need shell-escape

Run with `-e TEX_SHELL_ESCAPE=1` to enable `-shell-escape`.

## Bibliography not generated

Ensure your project uses `biblatex`; the entrypoint auto-detects and enables `biber`. Otherwise, pass latexmk flags manually.
