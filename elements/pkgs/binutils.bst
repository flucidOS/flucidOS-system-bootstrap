kind: autotools

description: Final (native) binutils linked against bootstrap glibc (carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz

build-depends:
- tools/import-fdo.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst
- freedesktop-sdk.bst:components/texinfo.bst

variables:
  bootstrap-triplet: "%{flucidos-target}"
  build-dir: build
  conf-local: >-
    --with-sysroot=%{sysroot}
    --with-lib-path=%{libdir}
    --disable-nls
    --disable-werror
    --enable-deterministic-archives
    --enable-gold
    --enable-ld=default
    --enable-plugins

environment:
  CC: "%{bootstrap-triplet}-gcc"
  AR: "%{bootstrap-triplet}-ar"
  RANLIB: "%{bootstrap-triplet}-ranlib"

config:
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64 || true
    - rm -rf %{install-root}%{datadir}/info
