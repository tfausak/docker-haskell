ARG UBUNTU_VERSION=21.10
FROM ubuntu:"$UBUNTU_VERSION"

ENV LANG=C.UTF-8
ARG CLANG_VERSION=12
RUN \
  apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    "clang-$CLANG_VERSION" \
    curl \
    libnuma-dev \
    "llvm-$CLANG_VERSION-dev" \
    make \
    sudo && \
  rm --recursive /var/lib/apt/lists/*

COPY update-alternatives.sh /tmp
RUN \
  /tmp/update-alternatives.sh "$CLANG_VERSION" && \
  rm /tmp/update-alternatives.sh

ARG USER_NAME=haskell
RUN \
  useradd --create-home --shell "$( command -v bash )" "$USER_NAME" && \
  echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USER_NAME"
USER "$USER_NAME"
WORKDIR "/home/$USER_NAME"
ENV PATH="/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"

# Install ghcup.
ARG GHCUP_VERSION=0.1.17.4
RUN \
  mkdir --parents ~/.ghcup/bin && \
  curl --output ~/.ghcup/bin/ghcup "https://downloads.haskell.org/~ghcup/$GHCUP_VERSION/$( uname -m )-linux-ghcup-$GHCUP_VERSION" && \
  chmod +x ~/.ghcup/bin/ghcup && \
  ghcup --version

# Install GHC.
ARG GHC_VERSION=8.10.7
RUN \
  ghcup install ghc "$GHC_VERSION" --set && \
  ghc --version

# Install Cabal.
ARG CABAL_VERSION=3.6.2.0
RUN \
  ghcup install cabal "$CABAL_VERSION" --set && \
  cabal --version

# Install HLS.
ARG HLS_VERSION=1.6.1.0
RUN \
  ghcup install hls "$HLS_VERSION" --set && \
  haskell-language-server-wrapper --version

CMD [ "ghci" ]
