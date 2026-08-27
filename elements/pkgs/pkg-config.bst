kind: autotools

description: pkg-config (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/pkg-config.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --with-internal-glib --disable-host-tool
