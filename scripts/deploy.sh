#!/bin/bash

# Usage:
#
# ./deploy.sh <branch>

PHP_BIN="php"
COMPOSER_BIN="composer"
BRANCH="main"

if [ -z "$1" ]; then
    BRANCH="$1"
fi

if [[ -n ${FORGE_COMPOSER+set} ]]; then
  PHP_BIN="$FORGE_PHP"
  COMPOSER_BIN="$FORGE_COMPOSER"
  BRANCH="$FORGE_SITE_BRANCH"
fi

$PHP_BIN craft db/backup
$PHP_BIN craft off

git reset HEAD --hard
git pull origin "$BRANCH"

$COMPOSER_BIN install --no-dev --no-interaction --prefer-dist --optimize-autoloader

$PHP_BIN craft migrate/all --no-content --interactive=0 --no-backup
$PHP_BIN craft project-config/apply
$PHP_BIN craft migrate --track=content --interactive=0

npm install
npm run build

$PHP_BIN craft on

if [[ -n ${FORGE_PHP_FPM+set} ]]; then
  ( flock -w 10 9 || exit 1
      echo 'Restarting FPM...'; sudo -S service $FORGE_PHP_FPM reload ) 9>/tmp/fpmlock
fi

# Panoptikum
git rev-parse --short HEAD > storage/.current-githash
git rev-parse HEAD > storage/.current-git-commit-sha
git tag | sort -V | tail -1 > storage/.current-gittag
git log -n 1 --pretty=%D HEAD > storage/.current-git-branch
$PHP_BIN craft _craft-panoptikum-cell/panoptikum/run
