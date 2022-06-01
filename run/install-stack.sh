#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install stack "$STACK_VERSION" --set
stack --version
