#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install cabal "$CABAL_VERSION" --set
cabal --version
