#!/bin/sh
# Cut a strict-code release in one command.
#
# Usage: sh scripts/release.sh 1.2.0
#
# Requires: clean tree, a CHANGELOG.md entry for the version, git, gh auth.
# Does: bump SKILL.md, commit, tag v<version>, push commit + tag,
# create the GitHub release, verify the local checkout.
set -eu

VERSION="${1:-}"
echo "$VERSION" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$' || {
  echo "Usage: sh scripts/release.sh <major.minor.patch>" >&2
  exit 1
}
TAG="v$VERSION"

[ -f SKILL.md ] && [ -f CHANGELOG.md ] || { echo "Run from the repo root." >&2; exit 1; }
dirty="$(git status --short | grep -v ' CHANGELOG.md$' | grep -v ' SKILL.md$' || true)"
[ -z "$dirty" ] || { echo "Working tree has non-release changes — commit first:" >&2; echo "$dirty" >&2; exit 1; }
git rev-parse "$TAG" >/dev/null 2>&1 && { echo "Tag $TAG already exists." >&2; exit 1; }
grep -q "^## $VERSION$" CHANGELOG.md || { echo "CHANGELOG.md lacks a '## $VERSION' entry." >&2; exit 1; }
command -v gh >/dev/null || { echo "gh CLI not found." >&2; exit 1; }

sed "s/^version: .*/version: $VERSION/" SKILL.md > SKILL.md.tmp && mv SKILL.md.tmp SKILL.md
grep -q "^version: $VERSION$" SKILL.md || { echo "SKILL.md version bump failed." >&2; exit 1; }

git add SKILL.md CHANGELOG.md
git commit -m "chore(release): bump to $TAG"
git tag "$TAG"
git push origin main
git push origin "$TAG"
gh release create "$TAG" --repo yanpenalva/strict-code --title "$TAG" \
  --notes "$(awk "/^## $VERSION\$/{flag=1;next}/^## /{flag=0}flag" CHANGELOG.md)"
git fetch --tags origin
echo "Released $TAG — local checkout at $(git describe --tags)."
