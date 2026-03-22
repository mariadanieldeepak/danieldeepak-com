#!/usr/bin/env bash
# Finalize a release per .claude/rules/git-workflow-standards.md:
# - Bump package.json version (semver, no "v" prefix)
# - Ensure release/v<semver> exists (create from develop if missing)
# - Commit version bump on the release branch
# - Merge release -> production (--no-ff), annotated tag on production
# - Merge release -> develop (--no-ff), delete release branch
# Does not push; run git push manually after review.

set -euo pipefail

usage() {
  echo "Usage: $0 <version>" >&2
  echo "  version: e.g. v0.1.0 or 0.1.0 (tag will use v prefix)" >&2
  exit 1
}

[[ ${1-} ]] || usage

RAW="$1"
if [[ "$RAW" == v* ]]; then
  TAG="$RAW"
  SEMVER="${RAW#v}"
else
  TAG="v$RAW"
  SEMVER="$RAW"
fi

if ! [[ "$SEMVER" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?(\+[0-9A-Za-z.-]+)?$ ]]; then
  echo "Invalid semver: $SEMVER" >&2
  exit 1
fi

RELEASE_BRANCH="release/v${SEMVER}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repository: $ROOT" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Working tree is not clean. Commit or stash changes before releasing." >&2
  exit 1
fi

if git show-ref --verify --quiet refs/heads/master; then
  PROD_BRANCH=master
elif git show-ref --verify --quiet refs/heads/main; then
  PROD_BRANCH=main
else
  echo "No master or main branch found." >&2
  exit 1
fi

if ! git show-ref --verify --quiet refs/heads/develop; then
  echo "develop branch not found." >&2
  exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/${RELEASE_BRANCH}"; then
  echo "Creating ${RELEASE_BRANCH} from develop..."
  git checkout develop
  git checkout -b "$RELEASE_BRANCH"
else
  echo "Using existing ${RELEASE_BRANCH}..."
  git checkout "$RELEASE_BRANCH"
  git merge --no-ff develop -m "Merge branch 'develop' into ${RELEASE_BRANCH}"
fi

export SEMVER
node -e "
const fs = require('fs');
const semver = process.env.SEMVER;
const path = 'package.json';
const pkg = JSON.parse(fs.readFileSync(path, 'utf8'));
pkg.version = semver;
fs.writeFileSync(path, JSON.stringify(pkg, null, 2) + '\n');
"

git add package.json
if git diff --cached --quiet; then
  echo "No package.json changes to commit (version already ${SEMVER}?)" >&2
else
  git commit -m "chore(release): bump version to ${SEMVER}"
fi

echo "Merging ${RELEASE_BRANCH} into ${PROD_BRANCH}..."
git checkout "$PROD_BRANCH"
git merge --no-ff "$RELEASE_BRANCH" -m "Merge branch '${RELEASE_BRANCH}'"

echo "Tagging ${TAG}..."
if git show-ref --verify --quiet "refs/tags/${TAG}"; then
  echo "Tag ${TAG} already exists." >&2
  exit 1
fi
git tag -a "$TAG" -m "Release version ${SEMVER}"

echo "Merging ${RELEASE_BRANCH} into develop..."
git checkout develop
git merge --no-ff "$RELEASE_BRANCH" -m "Merge branch '${RELEASE_BRANCH}'"

echo "Deleting local ${RELEASE_BRANCH}..."
git branch -d "$RELEASE_BRANCH"

echo ""
echo "Release ${TAG} prepared locally. Review, then push (not done by this script):"
echo "  git push origin ${PROD_BRANCH} develop --tags"
echo ""
