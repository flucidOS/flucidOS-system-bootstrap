kind: autotools

description: help2man (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/help2man.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-nls
