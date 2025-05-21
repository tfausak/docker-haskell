FROM alpine:3.21.3

ARG USER_NAME=vscode
# hadolint ignore=DL3018
RUN \
  set -o errexit -o xtrace; \
  apk add --no-cache \
    binutils-gold \
    curl \
    doas \
    g++ \
    gcc \
    gmp-dev \
    libc-dev \
    libffi-dev \
    make \
    musl-dev \
    ncurses-dev \
    perl \
    tar \
    xz; \
  adduser -D "$USER_NAME"; \
  echo "permit nopass $USER_NAME" > "/etc/doas.d/$USER_NAME.conf"

USER "$USER_NAME"
WORKDIR "/home/$USER_NAME"
RUN \
  set -o errexit -o xtrace; \
  mkdir --parents \
    ~/.cache/cabal \
    ~/.local/bin \
    ~/.local/state/cabal
ENV PATH="/home/$USER_NAME/.local/bin:$PATH"

ARG GHCUP_VERSION=0.1.50.2
ENV GHCUP_USE_XDG_DIRS=1
RUN \
  set -o errexit -o xtrace; \
  arch=$( uname -m ); \
  url="https://downloads.haskell.org/ghcup/$GHCUP_VERSION/$arch-linux-ghcup-$GHCUP_VERSION"; \
  curl --output ~/.local/bin/ghcup "$url"; \
  chmod +x ~/.local/bin/ghcup; \
  ghcup --version

ARG GHC_VERSION=9.12.2
RUN \
  set -o errexit -o xtrace;\
  ghcup install ghc --set "$GHC_VERSION"; \
  ghcup gc --profiling-libs --share-dir; \
  ghc --version

ARG CABAL_VERSION=3.14.2.0
RUN \
  set -o errexit -o xtrace; \
  ghcup install cabal --set "$CABAL_VERSION"; \
  cabal user-config init; \
  cabal --version
