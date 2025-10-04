#!/usr/bin/env bash
set -euo pipefail

# Local release helper
# - Bumps version (major|minor|patch)
# - Gathers commits since last release tag and adds a CHANGELOG entry
# - Updates VERSION, commits, tags, pushes, and creates a GitHub release
#
# Requirements:
# - git configured with push permissions
# - GitHub CLI (gh) authenticated OR GITHUB_TOKEN env set for API fallback
#
# Usage:
#   scripts/release.sh minor   # bump minor version
#   scripts/release.sh patch   # bump patch version
#   scripts/release.sh major   # bump major version

BUMP_TYPE=${1:-}
if [[ -z "$BUMP_TYPE" ]]; then
  echo "Usage: $0 <major|minor|patch>" >&2
  exit 2
fi

case "$BUMP_TYPE" in
  major|minor|patch) ;;
  *) echo "Invalid bump type: $BUMP_TYPE (use major|minor|patch)" >&2; exit 2;;
endcase

# Ensure we're on main and up-to-date
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
  echo "Warning: you are on '$CURRENT_BRANCH', not 'main'. Continuing in 5 seconds..." >&2
  sleep 5
fi

git fetch --tags --prune

# Determine current version
CURRENT_VER=$(cat VERSION 2>/dev/null || echo "0.0.0")
CURRENT_VER=${CURRENT_VER#v}
IFS='.' read -r MAJ MIN PAT <<<"${CURRENT_VER:-0.0.0}"
MAJ=${MAJ:-0}; MIN=${MIN:-0}; PAT=${PAT:-0}

case "$BUMP_TYPE" in
  major)
    NEW_VER="$((MAJ+1)).0.0" ;;
  minor)
    NEW_VER="${MAJ}.$((MIN+1)).0" ;;
  patch)
    NEW_VER="${MAJ}.${MIN}.$((PAT+1))" ;;
esac

# Find last release tag (vX.Y.Z) and date
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
RANGE=""
if [[ -n "$LAST_TAG" ]]; then
  RANGE="${LAST_TAG}..HEAD"
fi

# Collect commits since last tag
if [[ -n "$RANGE" ]]; then
  git log --no-merges --pretty=format:'- %s (%h)' $RANGE > commits.txt || true
else
  git log --no-merges --pretty=format:'- %s (%h)' > commits.txt || true
fi

if [[ ! -s commits.txt ]]; then
  echo "- No changes since last release" > commits.txt
fi

TODAY=$(date -u +%F)

# Update VERSION
echo "$NEW_VER" > VERSION

# Update CHANGELOG.md: insert new section after Unreleased if present
awk -v ver="$NEW_VER" -v date="$TODAY" '
  BEGIN { inserted=0 }
  {
    print $0
    if (!inserted && $0 ~ /^## \[Unreleased\]/) {
      print ""
      print "## [" ver "] - " date
      print ""
      print "### Changes"
      print ""
      while ((getline l < "commits.txt") > 0) print l
      close("commits.txt")
      inserted=1
    }
  }
  END {
    if (!inserted) {
      print ""
      print "## [" ver "] - " date
      print ""
      print "### Changes"
      print ""
      while ((getline l < "commits.txt") > 0) print l
      close("commits.txt")
    }
  }
' CHANGELOG.md > CHANGELOG.tmp && mv CHANGELOG.tmp CHANGELOG.md

# Commit and tag
REL_TAG="v$NEW_VER"

if ! git diff --quiet VERSION CHANGELOG.md; then
  git add VERSION CHANGELOG.md
  git commit -m "chore(release): $REL_TAG"
else
  echo "No changes detected; aborting." >&2
  exit 0
fi

git tag -a "$REL_TAG" -m "$REL_TAG"

git push origin "$CURRENT_BRANCH"
git push origin "$REL_TAG"

# Prepare release body
{
  echo "# Changelog for $REL_TAG"
  echo
  echo "Date: $TODAY"
  echo "Since: ${LAST_TAG:-initial commit}"
  echo
  cat commits.txt
} > RELEASE_BODY.md

# Create GitHub release
if command -v gh >/dev/null 2>&1; then
  gh release create "$REL_TAG" --title "$REL_TAG" --notes-file RELEASE_BODY.md
else
  : "${GITHUB_TOKEN:?GITHUB_TOKEN not set and GitHub CLI not available}"
  REPO=${GITHUB_REPOSITORY:-$(git config --get remote.origin.url | sed -E 's#.*github.com[:/](.+/.+)\.git#\1#')}
  curl -sSL -X POST \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${REPO}/releases" \
    -d @- <<JSON
{
  "tag_name": "$REL_TAG",
  "name": "$REL_TAG",
  "body": $(jq -Rs . < RELEASE_BODY.md),
  "target_commitish": "$CURRENT_BRANCH",
  "draft": false,
  "prerelease": false
}
JSON
fi

rm -f commits.txt RELEASE_BODY.md

echo "Release $REL_TAG created."
