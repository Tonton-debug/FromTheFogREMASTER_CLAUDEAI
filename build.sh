#!/usr/bin/env sh
# Собирает zip-архивы в dist/
set -e
cd "$(dirname "$0")"
rm -rf dist && mkdir dist
for p in FromTheFog FromTheFog-Fog FromTheFog-Resources; do
  (cd "$p" && zip -qr "../dist/$p-26.2.zip" .)
done
ls -1 dist
