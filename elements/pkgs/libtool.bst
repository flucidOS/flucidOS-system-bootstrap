kind: autotools

description: libtool (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/libtool.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-static
