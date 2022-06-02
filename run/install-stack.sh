#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install stack "$STACK_VERSION" --set
stack --version
stack config set system-ghc --global true
stack config set install-ghc --global false
mkdir --parents ~/.local/bin
