kind: autotools

description: findutils (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/findutils.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-nls
