ARG UBUNTU_VERSION=22.04
FROM ubuntu:"$UBUNTU_VERSION"

ENV LANG=C.UTF-8

ARG CLANG_VERSION=12
COPY run/install-dependencies.sh /tmp
RUN /tmp/install-dependencies.sh

COPY run/update-alternatives.sh /tmp
RUN /tmp/update-alternatives.sh

ARG USER_NAME=haskell
COPY run/create-user.sh /tmp
RUN /tmp/create-user.sh

WORKDIR "/home/$USER_NAME"
USER "$USER_NAME"
ENV PATH="/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"

ARG GHCUP_VERSION=0.1.17.8
COPY run/install-ghcup.sh /tmp
RUN /tmp/install-ghcup.sh

ARG GHC_VERSION=9.0.2
COPY run/install-ghc.sh /tmp
RUN /tmp/install-ghc.sh

ARG CABAL_VERSION=3.6.2.0
COPY run/install-cabal.sh /tmp
RUN /tmp/install-cabal.sh

ARG STACK_VERSION=2.7.5
COPY run/install-stack.sh /tmp
RUN /tmp/install-stack.sh

ARG HLS_VERSION=1.7.0.0
COPY run/install-hls.sh /tmp
RUN /tmp/install-hls.sh

CMD [ "ghci" ]
