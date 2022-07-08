#! /usr/bin/env sh
set -o errexit -o xtrace

ghcup install cabal "$CABAL_VERSION" --set
cabal --version
mkdir --parents ~/.cabal/bin

sudo mkdir "$CABAL_STORE"
sudo chmod g+w "$CABAL_STORE"
sudo chgrp sudo "$CABAL_STORE"
cabal user-config init --augment "store-dir: $CABAL_STORE"
