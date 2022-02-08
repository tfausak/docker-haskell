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
    libnuma1 \
    "llvm-$CLANG_VERSION-dev" \
    make \
    sudo && \
  update-alternatives --install /usr/local/bin/clang clang "$( command -v clang-$CLANG_VERSION )" 9 \
    --slave /usr/local/bin/asan_symbolize asan_symbolize "$( command -v asan_symbolize-$CLANG_VERSION )" \
    --slave /usr/local/bin/bugpoint bugpoint "$( command -v bugpoint-$CLANG_VERSION )" \
    --slave /usr/local/bin/clang-cpp clang-cpp "$( command -v clang-cpp-$CLANG_VERSION )" \
    --slave /usr/local/bin/clang++ clang++ "$( command -v clang++-$CLANG_VERSION )" \
    --slave /usr/local/bin/count count "$( command -v count-$CLANG_VERSION )" \
    --slave /usr/local/bin/dsymutil dsymutil "$( command -v dsymutil-$CLANG_VERSION )" \
    --slave /usr/local/bin/FileCheck FileCheck "$( command -v FileCheck-$CLANG_VERSION )" \
    --slave /usr/local/bin/llc llc "$( command -v llc-$CLANG_VERSION )" \
    --slave /usr/local/bin/lli lli "$( command -v lli-$CLANG_VERSION )" \
    --slave /usr/local/bin/lli-child-target lli-child-target "$( command -v lli-child-target-$CLANG_VERSION )" \
    --slave /usr/local/bin/not not "$( command -v not-$CLANG_VERSION )" \
    --slave /usr/local/bin/obj2yaml obj2yaml "$( command -v obj2yaml-$CLANG_VERSION )" \
    --slave /usr/local/bin/opt opt "$( command -v opt-$CLANG_VERSION )" \
    --slave /usr/local/bin/sanstats sanstats "$( command -v sanstats-$CLANG_VERSION )" \
    --slave /usr/local/bin/split-file split-file "$( command -v split-file-$CLANG_VERSION )" \
    --slave /usr/local/bin/verify-uselistorder verify-uselistorder "$( command -v verify-uselistorder-$CLANG_VERSION )" \
    --slave /usr/local/bin/yaml-bench yaml-bench "$( command -v yaml-bench-$CLANG_VERSION )" \
    --slave /usr/local/bin/yaml2obj yaml2obj "$( command -v yaml2obj-$CLANG_VERSION )" && \
  update-alternatives --install /usr/local/bin/llvm-config llvm-config "$( command -v llvm-config-$CLANG_VERSION )" 9 \
    --slave /usr/local/bin/llvm-addr2line llvm-addr2line "$( command -v llvm-addr2line-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-ar llvm-ar "$( command -v llvm-ar-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-as llvm-as "$( command -v llvm-as-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-bcanalyzer llvm-bcanalyzer "$( command -v llvm-bcanalyzer-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-bitcode-strip llvm-bitcode-strip "$( command -v llvm-bitcode-strip-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-c-test llvm-c-test "$( command -v llvm-c-test-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cat llvm-cat "$( command -v llvm-cat-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cfi-verify llvm-cfi-verify "$( command -v llvm-cfi-verify-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cov llvm-cov "$( command -v llvm-cov-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cvtres llvm-cvtres "$( command -v llvm-cvtres-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cxxdump llvm-cxxdump "$( command -v llvm-cxxdump-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cxxfilt llvm-cxxfilt "$( command -v llvm-cxxfilt-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-cxxmap llvm-cxxmap "$( command -v llvm-cxxmap-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-diff llvm-diff "$( command -v llvm-diff-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-dis llvm-dis "$( command -v llvm-dis-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-dlltool llvm-dlltool "$( command -v llvm-dlltool-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-dwarfdump llvm-dwarfdump "$( command -v llvm-dwarfdump-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-dwp llvm-dwp "$( command -v llvm-dwp-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-elfabi llvm-elfabi "$( command -v llvm-elfabi-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-exegesis llvm-exegesis "$( command -v llvm-exegesis-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-extract llvm-extract "$( command -v llvm-extract-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-gsymutil llvm-gsymutil "$( command -v llvm-gsymutil-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-ifs llvm-ifs "$( command -v llvm-ifs-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-install-name-tool llvm-install-name-tool "$( command -v llvm-install-name-tool-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-jitlink llvm-jitlink "$( command -v llvm-jitlink-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-jitlink-executor llvm-jitlink-executor "$( command -v llvm-jitlink-executor-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-lib llvm-lib "$( command -v llvm-lib-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-libtool-darwin llvm-libtool-darwin "$( command -v llvm-libtool-darwin-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-link llvm-link "$( command -v llvm-link-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-lipo llvm-lipo "$( command -v llvm-lipo-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-lto llvm-lto "$( command -v llvm-lto-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-lto2 llvm-lto2 "$( command -v llvm-lto2-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-mc llvm-mc "$( command -v llvm-mc-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-mca llvm-mca "$( command -v llvm-mca-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-ml llvm-ml "$( command -v llvm-ml-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-modextract llvm-modextract "$( command -v llvm-modextract-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-mt llvm-mt "$( command -v llvm-mt-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-nm llvm-nm "$( command -v llvm-nm-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-objcopy llvm-objcopy "$( command -v llvm-objcopy-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-objdump llvm-objdump "$( command -v llvm-objdump-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-opt-report llvm-opt-report "$( command -v llvm-opt-report-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-pdbutil llvm-pdbutil "$( command -v llvm-pdbutil-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-PerfectShuffle llvm-PerfectShuffle "$( command -v llvm-PerfectShuffle-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-profdata llvm-profdata "$( command -v llvm-profdata-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-profgen llvm-profgen "$( command -v llvm-profgen-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-ranlib llvm-ranlib "$( command -v llvm-ranlib-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-rc llvm-rc "$( command -v llvm-rc-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-readelf llvm-readelf "$( command -v llvm-readelf-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-readobj llvm-readobj "$( command -v llvm-readobj-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-reduce llvm-reduce "$( command -v llvm-reduce-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-rtdyld llvm-rtdyld "$( command -v llvm-rtdyld-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-size llvm-size "$( command -v llvm-size-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-split llvm-split "$( command -v llvm-split-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-stress llvm-stress "$( command -v llvm-stress-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-strings llvm-strings "$( command -v llvm-strings-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-strip llvm-strip "$( command -v llvm-strip-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-symbolizer llvm-symbolizer "$( command -v llvm-symbolizer-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-tblgen llvm-tblgen "$( command -v llvm-tblgen-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-undname llvm-undname "$( command -v llvm-undname-$CLANG_VERSION )" \
    --slave /usr/local/bin/llvm-xray llvm-xray "$( command -v llvm-xray-$CLANG_VERSION )" && \
  rm --recursive /var/lib/apt/lists/*

ARG USER_NAME=haskell
RUN \
  useradd --create-home --shell "$( command -v bash )" "$USER_NAME" && \
  echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$USER_NAME"
USER "$USER_NAME"
WORKDIR "/home/$USER_NAME"
ENV PATH="/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"

RUN mkdir --parents ~/.cabal/store ~/.ghcup/bin
VOLUME "/home/$USER_NAME/.cabal/store"

# Install ghcup.
ARG GHCUP_VERSION=0.1.17.4
RUN \
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
