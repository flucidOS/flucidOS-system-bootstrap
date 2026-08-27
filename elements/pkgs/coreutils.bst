kind: autotools

description: coreutils (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/coreutils.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --enable-no-install-program=kill,uptime --disable-nls
