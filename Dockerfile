ARG ALPINE_VERSION=3.20.3
FROM "alpine:$ALPINE_VERSION"

ARG USER_NAME=vscode
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

ARG GHCUP_VERSION=0.1.30.0
ENV GHCUP_USE_XDG_DIRS=1
RUN \
  set -o errexit -o xtrace; \
  if test -n "$GHCUP_VERSION"; then \
    arch=$( uname -m ); \
    url="https://downloads.haskell.org/~ghcup/$GHCUP_VERSION/$arch-linux-$( if test "$arch" = aarch64; then echo static-; fi )ghcup-$GHCUP_VERSION"; \
    curl --output ~/.local/bin/ghcup "$url"; \
    chmod +x ~/.local/bin/ghcup; \
    ghcup --version; \
  fi

ARG GHC_VERSION=9.10.1
RUN \
  set -o errexit -o xtrace;\
  if test -n "$GHC_VERSION"; then \
    ghcup install ghc --set "$GHC_VERSION"; \
    ghcup gc --profiling-libs --share-dir; \
    ghc --version; \
  fi

ARG CABAL_VERSION=3.12.1.0
RUN \
  set -o errexit -o xtrace; \
  if test -n "$CABAL_VERSION"; then \
    ghcup install cabal --set "$CABAL_VERSION"; \
    cabal user-config init; \
    cabal --version; \
  fi
