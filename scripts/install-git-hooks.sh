#!/usr/bin/env sh

set -eu

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"
chmod +x .githooks/commit-msg .github/scripts/validate-git-conventions.sh
git config core.hooksPath .githooks

printf 'Git hooks установлены для %s\n' "$repo_root"
printf 'Важно: git commit --no-verify может обойти локальный hook.\n'
