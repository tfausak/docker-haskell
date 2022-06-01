#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install ghc "$GHC_VERSION" --set
ghc --version
