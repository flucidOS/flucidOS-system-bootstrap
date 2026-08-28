kind: autotools

description: |
  Cross binutils – first package (carbonOS / LFS).
  pkg-src binutils tarball is a git-style tree (bfd/development.sh has
  development=true), which re-adds -Werror after configure. Force
  development=false and pass -Wno-error so GCC 14 does not fail on
  gas/gasp.c format-overflow.

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz

build-depends:
- freedesktop-sdk.bst:components/texinfo.bst
- tools/import-fdo.bst

environment:
  # Last matching flag wins; keep -Wno-error after any package defaults
  CFLAGS: "-O2 -g -Wno-error"
  CXXFLAGS: "-O2 -g -Wno-error"

variables:
  build-dir: build
  conf-local: >-
    --with-sysroot=%{bootstrap-sysroot}
    --target=%{bootstrap-triplet}
    --with-lib-path=%{libdir}
    --disable-nls
    --disable-werror
    --disable-plugins

config:
  configure-commands:
    (<):
    - |
      # git/dev snapshots set this; release tarballs do not
      if [ -f bfd/development.sh ]; then
        sed -i 's/^development=true/development=false/' bfd/development.sh
      fi
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64
    - rm -rf %{install-root}%{datadir}/info
    - rm -rf %{install-root}%{libdir}/bfd-plugins
