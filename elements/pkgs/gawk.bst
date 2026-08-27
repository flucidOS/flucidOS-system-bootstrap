kind: autotools

description: gawk (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gawk.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-nls
