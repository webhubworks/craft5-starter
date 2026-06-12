#!/bin/bash
set -euo pipefail

# Usage:
#
# ./deploy.sh <branch>

PHP_BIN="${FORGE_PHP:-php}"
COMPOSER_BIN="${FORGE_COMPOSER:-composer}"
BRANCH="${FORGE_SITE_BRANCH:-main}"

if [ -n "${1:-}" ]; then
    BRANCH="$1"
fi

# Ensure craft on is called even if the script fails (safety: error trap)
trap '$PHP_BIN craft on || true' ERR

$PHP_BIN craft off

# Use this if you do not have webhubworks/craft-backup installed:
# $PHP_BIN craft db/backup
$PHP_BIN craft backup/run --only-db

git reset HEAD --hard
git pull origin "$BRANCH"

$COMPOSER_BIN install --no-dev --no-interaction --prefer-dist --optimize-autoloader

$PHP_BIN craft migrate/all --no-content --interactive=0 --no-backup
$PHP_BIN craft project-config/apply
$PHP_BIN craft migrate --track=content --interactive=0

npm ci
npm run build

$PHP_BIN craft on

# Remove the ERR trap now that we are live — subsequent non-critical steps should not trigger maintenance mode
trap - ERR

if [[ -n ${FORGE_PHP_FPM+set} ]]; then
  touch /tmp/fpmlock 2>/dev/null || true
  ( flock -w 10 9 || exit 1
    echo 'Restarting FPM...'; sudo -S service $FORGE_PHP_FPM reload ) 9</tmp/fpmlock
fi

# Panoptikum
git rev-parse --short HEAD > storage/.current-githash
git rev-parse HEAD > storage/.current-git-commit-sha
git tag | sort -V | tail -1 > storage/.current-gittag
git log -n 1 --pretty=%D HEAD > storage/.current-git-branch
$PHP_BIN craft _craft-panoptikum-cell/panoptikum/run
