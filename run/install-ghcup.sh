#! /usr/bin/env sh
set -o errexit -o xtrace

mkdir --parents ~/.ghcup/bin
curl --output ~/.ghcup/bin/ghcup "https://downloads.haskell.org/~ghcup/$GHCUP_VERSION/$( uname -m )-linux-ghcup-$GHCUP_VERSION"
chmod +x ~/.ghcup/bin/ghcup
ghcup --version
