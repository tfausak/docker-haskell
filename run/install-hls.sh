#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install hls "$HLS_VERSION" --set
haskell-language-server-wrapper --version
mkdir --parents ~/.cache
