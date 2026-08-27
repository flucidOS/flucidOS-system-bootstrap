kind: autotools

description: bash (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/bash.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --without-bash-malloc --disable-nls
