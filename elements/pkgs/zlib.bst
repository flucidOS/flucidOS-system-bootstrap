kind: autotools

description: zlib (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/zlib.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-cmd: "%{conf-root}/configure"
  conf-local: ""
  build-dir: "."
