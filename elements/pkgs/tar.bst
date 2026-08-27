kind: autotools

description: tar (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/tar.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-nls
