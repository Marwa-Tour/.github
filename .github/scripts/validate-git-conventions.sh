#!/usr/bin/env bash

set -euo pipefail

BRANCH_PATTERN='^(feature|fix|bugfix|hotfix|chore|docs|refactor)/[0-9]+-[a-z0-9]+(-[a-z0-9]+)*$'
COMMIT_PATTERN='^(feat|fix|chore|docs|refactor|test|ci|build|perf)(\([a-z0-9._/-]+\))?!?: .{8,} (#[0-9]+|Marwa-Tour/[A-Za-z0-9._-]+#[0-9]+)$'

error() {
  printf 'ERROR: %s\n' "$*" >&2
}

validate_message() {
  local subject="$1"
  if [[ ! "$subject" =~ $COMMIT_PATTERN ]]; then
    error "Неверный commit: $subject"
    error 'Формат: <тип>: <описание минимум 8 символов> #<номер>'
    error 'Типы: feat, fix, chore, docs, refactor, test, ci, build, perf'
    error 'Пример: fix: исправить повторную отправку #456'
    return 1
  fi
}

case "${1:-}" in
  commit-msg)
    commit_file="${2:?Передайте путь к файлу commit message}"
    validate_message "$(sed -n '1p' "$commit_file")"
    ;;
  *)
    error 'Использование: validate-git-conventions.sh commit-msg <файл>'
    exit 2
    ;;
esac
