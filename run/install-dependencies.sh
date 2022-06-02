#! /usr/bin/env sh
set -o errexit -o xtrace

apt-get update
env DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --no-install-recommends \
  ca-certificates \
  "clang-$CLANG_VERSION" \
  curl \
  git \
  less \
  libgmp-dev \
  liblzma-dev \
  libnuma-dev \
  "llvm-$CLANG_VERSION-dev" \
  make \
  nano \
  netbase \
  openssh-client \
  sudo \
  zlib1g-dev
rm --recursive /var/lib/apt/lists/*
