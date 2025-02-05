#!/bin/bash

set -e -u -x
cd "$(dirname "$0")/.."

git diff --staged --quiet
git diff --quiet HEAD pyproject.toml
rm -rf dist
hatch version "$1"
hatch build
git add mkdocstrings_handlers/crystal/__init__.py
git commit -m "v$1"
git tag -a -m "" "v$1"
hatch publish
git push origin master --tags
