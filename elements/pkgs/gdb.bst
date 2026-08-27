kind: autotools

description: GDB (optional late package)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gdb.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  build-dir: build
  conf-local: --disable-nls --with-system-zlib
