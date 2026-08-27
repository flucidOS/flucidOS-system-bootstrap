kind: autotools

description: CPython (after native toolchain)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/python.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  build-dir: build
  conf-local: --without-ensurepip --disable-shared
